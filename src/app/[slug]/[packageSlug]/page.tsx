import { notFound } from "next/navigation";
import { createClient } from "@/utils/supabase/server";
import { ListingPageView } from "@/components/ListingPageView";
import { RentalListPageView, type RentalVehicle } from "@/components/RentalListPageView";
import { RestaurantDetailPageView } from "@/components/RestaurantDetailPageView";
import { SalonSpaDetailPageView } from "@/components/SalonSpaDetailPageView";
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

  // Rentals are a list of self-contained cards (no per-vehicle detail page),
  // unlike every other category which drills into a single listing.
  if (slug === "rental" && (packageSlug === "bike" || packageSlug === "car")) {
    const supabase = await createClient();
    const { data: vehicles } = await supabase
      .from("listings")
      .select("slug, name, photos, quick_answers, pricing_data")
      .eq("activity_category", `rental-${packageSlug}`)
      .eq("is_active", true);

    return (
      <RentalListPageView
        vehicleType={packageSlug}
        vehicles={(vehicles ?? []) as unknown as RentalVehicle[]}
      />
    );
  }

  const supabase = await createClient();

  const { data: listing } = await supabase
    .from("listings")
    .select(
      "activity_category, slug, name, description, overview_points, photos, location_address, location_lat, location_lng, quick_answers, pricing_type, pricing_data, contact_type, menu_pdf_url"
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

  const parentName = parentActivity?.name ?? humanizeSlug(slug);

  // Restaurants/cafes have no pricing/booking section — a dedicated detail
  // view renders the Menu section in its place.
  if (slug === "restaurants" || slug === "cafe") {
    return (
      <RestaurantDetailPageView
        listing={listing as unknown as Listing & { menu_pdf_url: string | null }}
        parentSlug={slug}
        parentName={parentName}
      />
    );
  }

  // Salon & Spa also has no pricing/booking section (PDF menu instead),
  // but shows one or more branch map links in place of a single Location
  // card, since a listing can have several real-world branches.
  if (slug === "salon-spa") {
    return (
      <SalonSpaDetailPageView
        listing={listing as unknown as Listing & { menu_pdf_url: string | null }}
        parentSlug={slug}
        parentName={parentName}
      />
    );
  }

  return (
    <ListingPageView
      listing={listing as unknown as Listing}
      parentSlug={slug}
      parentName={parentName}
    />
  );
}
