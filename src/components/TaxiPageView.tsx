import { ImageSlider } from "./ImageSlider";
import { PageShell } from "./PageShell";
import { TaxiCarCard } from "./TaxiCarCard";
import { whatsAppLink, callLink, WHATSAPP_NUMBERS } from "@/lib/contact";
import type { QuickAnswer, SinglePricingData } from "@/lib/listings";

export type TaxiCar = {
  slug: string;
  name: string;
  photos: string[];
  quick_answers: QuickAnswer[];
  pricing_data: SinglePricingData;
};

function findAnswer(quickAnswers: QuickAnswer[], label: string) {
  return quickAnswers.find((qa) => qa.label === label)?.value ?? null;
}

export function TaxiPageView({ cars }: { cars: TaxiCar[] }) {
  const phone = WHATSAPP_NUMBERS.land;
  const generalMessage = "Hi Mapscape, I'm interested in a taxi.";
  const headerImages = cars
    .map((car) => car.photos[0])
    .filter((photo): photo is string => Boolean(photo))
    .slice(0, 5);

  return (
    <PageShell
      footerWhatsAppHref={whatsAppLink(phone, generalMessage)}
      footerCallHref={callLink(phone)}
    >
      <div className="mx-auto max-w-lg px-4 pt-4 sm:max-w-2xl">
        <ImageSlider images={headerImages} />
      </div>

      <main className="mx-auto max-w-lg px-4 py-6 sm:max-w-2xl">
        <div className="rounded-2xl border border-amber-950/20 bg-amber-900 p-4 text-center shadow-md">
          <h1 className="font-heading text-2xl font-bold text-white sm:text-3xl">Taxi</h1>
        </div>

        <div className="mt-4 rounded-2xl border border-amber-950/20 bg-amber-900 p-4 text-center shadow-md">
          <p className="text-sm leading-relaxed text-amber-100">
            Reliable rides anywhere in Goa — pick a car below and book directly on WhatsApp.
          </p>
        </div>

        <div className="mt-6 flex flex-col gap-4">
          {cars.map((car) => (
            <TaxiCarCard
              key={car.slug}
              name={car.name}
              imageUrl={car.photos[0]}
              capacity={findAnswer(car.quick_answers, "Capacity")}
              originalPrice={car.pricing_data.price.original_price}
              displayPrice={car.pricing_data.price.display_price}
              bookNowHref={whatsAppLink(phone, `Hi Mapscape, I would like to book ${car.name}.`)}
            />
          ))}
        </div>
      </main>
    </PageShell>
  );
}
