import { notFound } from "next/navigation";
import { createClient } from "@/utils/supabase/server";
import { CategoryPageView } from "@/components/CategoryPageView";
import { AttractionPageView } from "@/components/AttractionPageView";
import { RentalChoicePage } from "@/components/RentalChoicePage";
import { TaxiPageView, type TaxiCar } from "@/components/TaxiPageView";
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

    return (
      <CategoryPageView
        category={{
          ...activity,
          category: activity.category as Category,
          image_urls: activity.image_urls ?? [],
        }}
        listings={(listings ?? []) as unknown as Listing[]}
      />
    );
  }

  const { data: attraction } = await supabase
    .from("attractions")
    .select("name, description, latitude, longitude, image_urls")
    .eq("slug", slug)
    .single();

  if (attraction) {
    const { data: suggestedActivities } = await supabase
      .from("activities")
      .select("name, slug, category, image_url")
      .eq("is_active", true)
      .limit(4);

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
