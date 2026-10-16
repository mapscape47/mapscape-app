import { notFound } from "next/navigation";
import { createClient } from "@/utils/supabase/server";
import { CategoryPageView } from "@/components/CategoryPageView";
import { AttractionPageView } from "@/components/AttractionPageView";
import { RentalChoicePage } from "@/components/RentalChoicePage";
import { TaxiPageView, type TaxiCar } from "@/components/TaxiPageView";
import { RestaurantListPageView } from "@/components/RestaurantListPageView";
import type { Category } from "@/lib/contact";
import type { Listing } from "@/lib/listings";

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
      .select("name, slug, category, image_url")
      .eq("is_active", true)
      .limit(4),
  ]);

  if (attraction) {
    return (
      <AttractionPageView
        attraction={{ ...attraction, image_urls: attraction.image_urls ?? [] }}
        suggestedActivities={(suggestedActivities ?? []).map((a) => ({
          ...a,
          category: a.category as Category,
        }))}
      />
    );
  }

  notFound();
}
