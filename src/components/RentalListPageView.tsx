import { ImageSlider } from "./ImageSlider";
import { PageShell } from "./PageShell";
import { RentalVehicleCard } from "./RentalVehicleCard";
import { whatsAppLink, callLink, WHATSAPP_NUMBERS } from "@/lib/contact";
import type { QuickAnswer, SinglePricingData } from "@/lib/listings";

export type VehicleType = "bike" | "car";

export type RentalVehicle = {
  slug: string;
  name: string;
  photos: string[];
  quick_answers: QuickAnswer[];
  pricing_data: SinglePricingData;
};

const COPY: Record<VehicleType, { title: string; description: string; placeholderIcon: string }> = {
  bike: {
    title: "Bike Rental",
    description:
      "Self-drive scooters and motorbikes to explore Goa at your own pace — no driver, no fixed itinerary, just the open road.",
    placeholderIcon: "🏍️",
  },
  car: {
    title: "Car Rental",
    description:
      "Self-drive, air-conditioned cars for comfortable travel around Goa — ideal for families and longer trips.",
    placeholderIcon: "🚗",
  },
};

function findAnswer(quickAnswers: QuickAnswer[], label: string) {
  return quickAnswers.find((qa) => qa.label === label)?.value ?? null;
}

export function RentalListPageView({
  vehicleType,
  vehicles,
}: {
  vehicleType: VehicleType;
  vehicles: RentalVehicle[];
}) {
  const phone = WHATSAPP_NUMBERS.land;
  const copy = COPY[vehicleType];
  const generalMessage = `Hi Mapscape, I'm interested in ${copy.title}.`;
  const headerImages = vehicles
    .map((vehicle) => vehicle.photos[0])
    .filter((photo): photo is string => Boolean(photo))
    .slice(0, 5);

  return (
    <PageShell
      footerWhatsAppHref={whatsAppLink(phone, generalMessage)}
      footerCallHref={callLink(phone)}
    >
      <div className="mx-auto max-w-lg px-4 pt-4 sm:max-w-2xl">
        <ImageSlider images={headerImages} alt={copy.title} />
      </div>

      <main className="mx-auto max-w-lg px-4 py-6 sm:max-w-2xl">
        <div className="rounded-2xl border border-amber-950/20 bg-amber-900 p-4 text-center shadow-md">
          <h1 className="font-heading text-2xl font-bold text-white sm:text-3xl">{copy.title}</h1>
        </div>

        <div className="mt-4 rounded-2xl border border-amber-950/20 bg-amber-900 p-4 text-center shadow-md">
          <p className="text-sm leading-relaxed text-amber-100">{copy.description}</p>
        </div>

        <div className="mt-6 flex flex-col gap-4">
          {vehicles.map((vehicle) => (
            <RentalVehicleCard
              key={vehicle.slug}
              name={vehicle.name}
              imageUrl={vehicle.photos[0]}
              placeholderIcon={copy.placeholderIcon}
              transmission={findAnswer(vehicle.quick_answers, "Transmission")}
              seatingCapacity={
                vehicleType === "car" ? findAnswer(vehicle.quick_answers, "Seating Capacity") : null
              }
              originalPrice={
                findAnswer(vehicle.quick_answers, "Price Range")
                  ? undefined
                  : vehicle.pricing_data.price.original_price
              }
              displayPrice={
                findAnswer(vehicle.quick_answers, "Price Range")
                  ? undefined
                  : vehicle.pricing_data.price.display_price
              }
              priceLabel={findAnswer(vehicle.quick_answers, "Price Range")}
              bookNowHref={whatsAppLink(phone, `Hi Mapscape, I would like to book ${vehicle.name}.`)}
            />
          ))}
        </div>
      </main>
    </PageShell>
  );
}
