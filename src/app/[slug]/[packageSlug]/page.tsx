import { notFound } from "next/navigation";
import { createClient } from "@/utils/supabase/server";
import { ListingPageView } from "@/components/ListingPageView";
import type { Listing } from "@/lib/listings";

function humanizeSlug(slug: string) {
  return slug
    .split("-")
    .map((word) => word.charAt(0).toUpperCase() + word.slice(1))
    .join(" ");
}

export default async function ListingPage({
  params,
}: {
  params: Promise<{ slug: string; packageSlug: string }>;
}) {
  const { slug, packageSlug } = await params;
  const supabase = await createClient();

  const { data: listing } = await supabase
    .from("listings")
    .select(
      "activity_category, slug, name, description, overview_points, photos, location_address, location_lat, location_lng, quick_answers, pricing_type, pricing_data, contact_type"
    )
    .eq("activity_category", slug)
    .eq("slug", packageSlug)
    .single();

  if (!listing) {
    notFound();
  }

  const { data: parentActivity } = await supabase
    .from("activities")
    .select("name")
    .eq("slug", slug)
    .single();

  return (
    <ListingPageView
      listing={listing as unknown as Listing}
      parentSlug={slug}
      parentName={parentActivity?.name ?? humanizeSlug(slug)}
    />
  );
}
