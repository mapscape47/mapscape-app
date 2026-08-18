import { notFound } from "next/navigation";
import { createClient } from "@/utils/supabase/server";
import { ActivityPageView } from "@/components/ActivityPageView";
import { AttractionPageView } from "@/components/AttractionPageView";
import type { Category, PriceTier } from "@/lib/contact";

export default async function SlugPage({
  params,
}: {
  params: Promise<{ slug: string }>;
}) {
  const { slug } = await params;
  const supabase = await createClient();

  const { data: activity } = await supabase
    .from("activities")
    .select("name, category, description, price_tiers, image_url")
    .eq("slug", slug)
    .single();

  if (activity) {
    return (
      <ActivityPageView
        activity={{
          ...activity,
          category: activity.category as Category,
          price_tiers: (activity.price_tiers ?? []) as PriceTier[],
        }}
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
