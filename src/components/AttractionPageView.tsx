import { ImageSlider } from "./ImageSlider";
import { PriceTierCard } from "./PriceTierCard";
import { PageShell } from "./PageShell";
import { MapPinIcon } from "./MapPinIcon";
import { CATEGORY_LABELS, WHATSAPP_NUMBERS, callLink, whatsAppLink, type Category } from "@/lib/contact";

type Attraction = {
  name: string;
  description: string | null;
  latitude: number;
  longitude: number;
  image_urls: string[];
};

type SuggestedActivity = {
  name: string;
  slug: string;
  category: Category;
  image_url: string | null;
};

// General business contact — attractions have no commission category of
// their own, so the footer falls back to the water-activities line.
const GENERAL_PHONE = WHATSAPP_NUMBERS.water;

export function AttractionPageView({
  attraction,
  suggestedActivities,
}: {
  attraction: Attraction;
  suggestedActivities: SuggestedActivity[];
}) {
  const directionsHref = `https://www.google.com/maps/dir/?api=1&destination=${attraction.latitude},${attraction.longitude}`;

  return (
    <PageShell
      footerWhatsAppHref={whatsAppLink(GENERAL_PHONE, "Hi, I'm interested in Mapscape experiences in Goa")}
      footerCallHref={callLink(GENERAL_PHONE)}
    >
      <div className="mx-auto max-w-lg px-4 pt-4 sm:max-w-2xl">
        <ImageSlider images={attraction.image_urls} />
      </div>

      <main className="mx-auto max-w-lg px-4 py-6 sm:max-w-2xl">
        <div className="rounded-2xl border border-amber-950/20 bg-amber-900 p-4 shadow-md">
          <h1 className="text-2xl font-bold text-white sm:text-3xl">{attraction.name}</h1>
        </div>

        <a
          href={directionsHref}
          target="_blank"
          rel="noopener noreferrer"
          className="mt-4 flex items-center justify-center gap-2 rounded-full bg-emerald-700 py-3 text-sm font-semibold text-white shadow-md transition-colors hover:bg-emerald-800"
        >
          <MapPinIcon />
          Get Directions
        </a>

        {attraction.description && (
          <div className="mt-4 rounded-2xl border border-amber-950/20 bg-amber-900 p-4 shadow-md">
            <p className="text-sm leading-relaxed text-amber-100">{attraction.description}</p>
          </div>
        )}

        {suggestedActivities.length > 0 && (
          <div className="mt-8">
            <h2 className="text-lg font-bold text-stone-800">You Might Also Like</h2>
            <div className="mt-4 flex flex-col gap-4">
              {suggestedActivities.map((activity) => (
                <PriceTierCard
                  key={activity.slug}
                  title={activity.name}
                  tag={CATEGORY_LABELS[activity.category]}
                  imageUrl={activity.image_url ?? undefined}
                  linkHref={`/${activity.slug}`}
                />
              ))}
            </div>
          </div>
        )}
      </main>
    </PageShell>
  );
}
