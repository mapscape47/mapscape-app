import { notFound } from "next/navigation";
import { createClient } from "@/utils/supabase/server";
import { CategoryPageView } from "@/components/CategoryPageView";
import { AttractionPageView } from "@/components/AttractionPageView";
import type { Category } from "@/lib/contact";
import type { Listing } from "@/lib/listings";

export default async function SlugPage({
  params,
}: {
  params: Promise<{ slug: string }>;
}) {
  const { slug } = await params;
  const supabase = await createClient();

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
