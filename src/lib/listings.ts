import type { Category } from "@/lib/contact";

export type QuickAnswer = {
  label: string;
  value: string;
};

// A price is always { display_price, original_price? }. When original_price
// is present and greater than display_price, the UI renders it struck
// through next to display_price — otherwise only display_price shows.
export type PriceObject = {
  display_price: number;
  original_price?: number | null;
};

export type SinglePricingData = {
  price: PriceObject;
  tier_name?: string;
};

export type TieredPricingData = {
  tier_name: string;
  description?: string;
  price: PriceObject;
}[];

export type MultiServicePricingData = {
  service_name: string;
  description?: string;
  price: PriceObject;
}[];

export type PricingType = "single" | "tiered" | "multi_service";

export type Listing = {
  activity_category: string;
  slug: string;
  name: string;
  description: string | null;
  overview_points: string[] | null;
  photos: string[];
  location_address: string | null;
  location_lat: number | null;
  location_lng: number | null;
  quick_answers: QuickAnswer[];
  pricing_type: PricingType;
  pricing_data: SinglePricingData | TieredPricingData | MultiServicePricingData;
  contact_type: Category;
};

export function bookingMessage(listingName: string, itemName?: string) {
  return itemName
    ? `Hi Mapscape, I would like to book ${listingName} - ${itemName}.`
    : `Hi Mapscape, I would like to book ${listingName}.`;
}

function cheapest(prices: PriceObject[]): PriceObject | undefined {
  return prices.reduce<PriceObject | undefined>(
    (min, p) => (!min || p.display_price < min.display_price ? p : min),
    undefined
  );
}

// The representative price shown on a Level 2 listing card. For "single"
// it's just that one price; for "tiered"/"multi_service" it's the cheapest
// option, prefixed "From" when there's more than one to summarize.
export function cardPricing(listing: Listing): { price: PriceObject; showFrom: boolean } | null {
  if (listing.pricing_type === "single") {
    const data = listing.pricing_data as SinglePricingData;
    return { price: data.price, showFrom: false };
  }

  const items =
    listing.pricing_type === "tiered"
      ? (listing.pricing_data as TieredPricingData)
      : (listing.pricing_data as MultiServicePricingData);

  const price = cheapest(items.map((item) => item.price));
  return price ? { price, showFrom: items.length > 1 } : null;
}
