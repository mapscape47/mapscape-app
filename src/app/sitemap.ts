import type { MetadataRoute } from "next";
import { createClient } from "@/utils/supabase/server";

const BASE_URL = "https://www.mapscape.in";

// These categories have a list page but no per-listing detail page
// (rental is a binary choice page, taxi is a single flat list) — so
// their listings don't get their own L3 URL.
const NO_DETAIL_PAGE_CATEGORIES = new Set(["rental-bike", "rental-car", "taxi"]);

export default async function sitemap(): Promise<MetadataRoute.Sitemap> {
  const supabase = await createClient();

  const [{ data: activities }, { data: attractions }, { data: listings }] = await Promise.all([
    supabase.from("activities").select("slug").eq("is_active", true),
    supabase.from("attractions").select("slug"),
    supabase.from("listings").select("activity_category, slug").eq("is_active", true),
  ]);

  const staticRoutes: MetadataRoute.Sitemap = [
    { url: BASE_URL, changeFrequency: "monthly", priority: 1 },
    { url: `${BASE_URL}/about`, changeFrequency: "yearly", priority: 0.3 },
    { url: `${BASE_URL}/privacy`, changeFrequency: "yearly", priority: 0.2 },
    { url: `${BASE_URL}/terms`, changeFrequency: "yearly", priority: 0.2 },
    { url: `${BASE_URL}/rental`, changeFrequency: "monthly", priority: 0.6 },
    { url: `${BASE_URL}/rental/bike`, changeFrequency: "weekly", priority: 0.6 },
    { url: `${BASE_URL}/rental/car`, changeFrequency: "weekly", priority: 0.6 },
    { url: `${BASE_URL}/taxi`, changeFrequency: "weekly", priority: 0.6 },
  ];

  const categoryRoutes: MetadataRoute.Sitemap = (activities ?? []).map((a) => ({
    url: `${BASE_URL}/${a.slug}`,
    changeFrequency: "weekly",
    priority: 0.8,
  }));

  const attractionRoutes: MetadataRoute.Sitemap = (attractions ?? []).map((a) => ({
    url: `${BASE_URL}/${a.slug}`,
    changeFrequency: "monthly",
    priority: 0.6,
  }));

  const listingRoutes: MetadataRoute.Sitemap = (listings ?? [])
    .filter((l) => !NO_DETAIL_PAGE_CATEGORIES.has(l.activity_category))
    .map((l) => ({
      url: `${BASE_URL}/${l.activity_category}/${l.slug}`,
      changeFrequency: "weekly",
      priority: 0.7,
    }));

  return [...staticRoutes, ...categoryRoutes, ...attractionRoutes, ...listingRoutes];
}
