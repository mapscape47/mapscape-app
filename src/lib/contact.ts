export type Category = "water" | "land" | "nature";

export type PriceTier = {
  name: string;
  price: number;
  image?: string;
};

export const WHATSAPP_NUMBERS: Record<Category, string | undefined> = {
  water: process.env.NEXT_PUBLIC_WHATSAPP_NUMBER_WATER,
  land: process.env.NEXT_PUBLIC_WHATSAPP_NUMBER_LAND_NATURE,
  nature: process.env.NEXT_PUBLIC_WHATSAPP_NUMBER_LAND_NATURE,
};

export const CATEGORY_LABELS: Record<Category, string> = {
  water: "Water",
  land: "Land",
  nature: "Nature",
};

export function whatsAppLink(phone: string | undefined, message: string) {
  const base = phone ? `https://wa.me/${phone}` : "https://wa.me/";
  return `${base}?text=${encodeURIComponent(message)}`;
}

export function callLink(phone: string | undefined) {
  return phone ? `tel:+${phone}` : "tel:";
}

export function cheapestTier(priceTiers: PriceTier[]): PriceTier | undefined {
  return priceTiers.reduce<PriceTier | undefined>(
    (cheapest, tier) => (!cheapest || tier.price < cheapest.price ? tier : cheapest),
    undefined
  );
}
