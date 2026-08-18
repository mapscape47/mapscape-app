import { ImageSlider } from "./ImageSlider";
import { PriceTierCard } from "./PriceTierCard";
import { StickyContactBar } from "./StickyContactBar";
import { PageShell } from "./PageShell";
import {
  CATEGORY_LABELS,
  WHATSAPP_NUMBERS,
  callLink,
  whatsAppLink,
  type Category,
  type PriceTier,
} from "@/lib/contact";

type Activity = {
  name: string;
  category: Category;
  description: string | null;
  price_tiers: PriceTier[];
  image_url: string | null;
};

export function ActivityPageView({ activity }: { activity: Activity }) {
  const phone = WHATSAPP_NUMBERS[activity.category];
  const categoryLabel = CATEGORY_LABELS[activity.category];

  return (
    <PageShell
      footerWhatsAppHref={whatsAppLink(phone, `Hi, I'm inquiring about ${activity.name}`)}
      footerCallHref={callLink(phone)}
      stickyBar={
        <StickyContactBar
          whatsAppHref={whatsAppLink(phone, `Hi, I'm inquiring about ${activity.name}`)}
          whatsAppLabel="Chat on WhatsApp"
          callHref={callLink(phone)}
          callLabel="Call Us"
        />
      }
    >
      <div className="mx-auto max-w-lg px-4 pt-4 sm:max-w-2xl">
        <ImageSlider />
      </div>

      <main className="mx-auto max-w-lg px-4 py-6 sm:max-w-2xl">
        <div className="rounded-2xl border border-amber-950/20 bg-amber-900 p-4 text-center shadow-md">
          <h1 className="font-heading text-2xl font-bold text-white sm:text-3xl">{activity.name}</h1>

          {activity.description && (
            <p className="mt-2 text-sm leading-relaxed text-amber-100">{activity.description}</p>
          )}
        </div>

        <div className="mt-6 flex flex-col gap-4">
          {activity.price_tiers.map((tier) => (
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
    </PageShell>
  );
}
