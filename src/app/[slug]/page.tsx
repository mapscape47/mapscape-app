import type { Metadata } from "next";
import { notFound } from "next/navigation";
import { createClient } from "@/utils/supabase/server";
import { CategoryPageView } from "@/components/CategoryPageView";
import { AttractionPageView } from "@/components/AttractionPageView";
import { RentalChoicePage } from "@/components/RentalChoicePage";
import { TaxiPageView, type TaxiCar } from "@/components/TaxiPageView";
import { RestaurantListPageView } from "@/components/RestaurantListPageView";
import type { Category } from "@/lib/contact";
import type { Listing } from "@/lib/listings";

function truncate(text: string | null | undefined, max = 155) {
  if (!text) return undefined;
  return text.length > max ? `${text.slice(0, max - 1)}…` : text;
}

export async function generateMetadata({
  params,
}: {
  params: Promise<{ slug: string }>;
}): Promise<Metadata> {
  const { slug } = await params;

  if (slug === "rental") {
    return {
      title: "Bike & Car Rental in Goa",
      description: "Self-drive bike and car rentals in Goa — browse vehicles and book directly on WhatsApp.",
    };
  }

  if (slug === "taxi") {
    return {
      title: "Taxi Service in Goa",
      description: "Book a taxi anywhere in Goa, arranged directly over WhatsApp.",
    };
  }

  const supabase = await createClient();

  const { data: activity } = await supabase
    .from("activities")
    .select("name, description")
    .eq("slug", slug)
    .single();

  if (activity) {
    return { title: activity.name, description: truncate(activity.description) };
  }

  const { data: attraction } = await supabase
    .from("attractions")
    .select("name, description")
    .eq("slug", slug)
    .single();

  if (attraction) {
    return { title: attraction.name, description: truncate(attraction.description) };
  }

  return {};
}

export default async function SlugPage({
  params,
}: {
  params: Promise<{ slug: string }>;
}) {
  const { slug } = await params;

  // Rentals use a simple binary-choice landing page instead of the
  // standard listings-driven category template — no DB lookup needed.
  if (slug === "rental") {
    return <RentalChoicePage />;
  }

  const supabase = await createClient();

  // Taxi is a single flat list page — no per-car detail page, since there's
  // only one taxi contact who arranges cars anywhere in Goa.
  if (slug === "taxi") {
    const { data: cars } = await supabase
      .from("listings")
      .select("slug, name, photos, quick_answers, pricing_data")
      .eq("activity_category", "taxi")
      .eq("is_active", true);

    return <TaxiPageView cars={(cars ?? []) as unknown as TaxiCar[]} />;
  }

  const { data: activity } = await supabase
    .from("activities")
    .select("name, slug, category, description, image_urls")
    .eq("slug", slug)
    .single();

  if (activity) {
    const { data: listings } = await supabase
      .from("listings")
      .select(
        "activity_category, slug, name, description, overview_points, photos, location_address, location_lat, location_lng, quick_answers, pricing_type, pricing_data, contact_type"
      )
      .eq("activity_category", slug)
      .eq("is_active", true);

    const categorySummary = {
      ...activity,
      category: activity.category as Category,
      image_urls: activity.image_urls ?? [],
    };

    // Restaurants/cafes/salon-spa are informational only — no pricing, so
    // their cards (photo, cuisine, timings) render via a dedicated
    // component instead of the shared price-driven CategoryPageView.
    if (slug === "restaurants" || slug === "cafe" || slug === "salon-spa") {
      return (
        <RestaurantListPageView
          category={categorySummary}
          listings={(listings ?? []) as unknown as Listing[]}
        />
      );
    }

    return (
      <CategoryPageView
        category={categorySummary}
        listings={(listings ?? []) as unknown as Listing[]}
      />
    );
  }

  // Run both queries concurrently rather than waiting on the attraction
  // lookup before starting the suggested-activities one — they don't
  // depend on each other's results, only on the attraction existing.
  const [{ data: attraction }, { data: suggestedActivities }] = await Promise.all([
    supabase
      .from("attractions")
      .select("name, description, latitude, longitude, image_urls")
      .eq("slug", slug)
      .single(),
    supabase
      .from("activities")
      .select("name, slug, category, image_urls")
      .eq("is_active", true),
  ]);

  if (attraction) {
    return (
      <AttractionPageView
        attraction={{ ...attraction, image_urls: attraction.image_urls ?? [] }}
        suggestedActivities={(suggestedActivities ?? [])
          .filter((a) => a.image_urls && a.image_urls.length > 0)
          .slice(0, 4)
          .map((a) => ({
            ...a,
            category: a.category as Category,
            image_urls: a.image_urls as string[],
          }))}
      />
    );
  }

  notFound();
}
