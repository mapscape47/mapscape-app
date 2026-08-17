import { notFound } from "next/navigation";
import { createClient } from "@/utils/supabase/server";
import { SiteHeader } from "@/components/SiteHeader";
import { ImageSlider } from "@/components/ImageSlider";
import { PriceTierCard } from "@/components/PriceTierCard";
import { StickyContactBar } from "@/components/StickyContactBar";
import { SiteFooter } from "@/components/SiteFooter";

type Category = "water" | "land" | "nature";

type PriceTier = {
  name: string;
  price: number;
  image?: string;
};

const WHATSAPP_NUMBERS: Record<Category, string | undefined> = {
  water: process.env.NEXT_PUBLIC_WHATSAPP_NUMBER_WATER,
  land: process.env.NEXT_PUBLIC_WHATSAPP_NUMBER_LAND_NATURE,
  nature: process.env.NEXT_PUBLIC_WHATSAPP_NUMBER_LAND_NATURE,
};

const CATEGORY_LABELS: Record<Category, string> = {
  water: "Water",
  land: "Land",
  nature: "Nature",
};

function whatsAppLink(phone: string | undefined, message: string) {
  const base = phone ? `https://wa.me/${phone}` : "https://wa.me/";
  return `${base}?text=${encodeURIComponent(message)}`;
}

function callLink(phone: string | undefined) {
  return phone ? `tel:+${phone}` : "tel:";
}

export default async function ActivityPage({
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

  if (!activity) {
    notFound();
  }

  const category = activity.category as Category;
  const priceTiers = (activity.price_tiers ?? []) as PriceTier[];
  const phone = WHATSAPP_NUMBERS[category];
  const categoryLabel = CATEGORY_LABELS[category];

  return (
    <div
      className="relative min-h-screen bg-stone-50 bg-top bg-repeat-y"
      style={{ backgroundImage: "url('/backgrounds/beach-illustration.webp')" }}
    >
      <SiteHeader />
      <ImageSlider />

      <main className="mx-auto max-w-lg px-4 py-6 sm:max-w-2xl">
        <div className="rounded-2xl border border-amber-950/20 bg-amber-900 p-4 shadow-md">
          <h1 className="text-2xl font-bold text-white sm:text-3xl">{activity.name}</h1>

          {activity.description && (
            <p className="mt-2 text-sm leading-relaxed text-amber-100">{activity.description}</p>
          )}
        </div>

        <div className="mt-6 flex flex-col gap-4">
          {priceTiers.map((tier) => (
            <PriceTierCard
              key={tier.name}
              title={tier.name}
              price={tier.price}
              tag={categoryLabel}
              imageUrl={tier.image}
              ctaHref={whatsAppLink(phone, `Hi, I'm inquiring about ${activity.name} - ${tier.name}`)}
            />
          ))}
        </div>
      </main>

      <SiteFooter
        whatsAppHref={whatsAppLink(phone, `Hi, I'm inquiring about ${activity.name}`)}
        callHref={callLink(phone)}
      />

      <StickyContactBar
        whatsAppHref={whatsAppLink(phone, `Hi, I'm inquiring about ${activity.name}`)}
        whatsAppLabel="Chat on WhatsApp"
        callHref={callLink(phone)}
        callLabel="Call Us"
      />
    </div>
  );
}
