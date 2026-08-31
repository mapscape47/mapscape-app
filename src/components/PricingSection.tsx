import { BookNowButton } from "./BookNowButton";
import { PriceDisplay } from "./PriceDisplay";
import { whatsAppLink, WHATSAPP_NUMBERS } from "@/lib/contact";
import {
  bookingMessage,
  type Listing,
  type SinglePricingData,
  type TieredPricingData,
  type MultiServicePricingData,
} from "@/lib/listings";

export function PricingSection({ listing }: { listing: Listing }) {
  const phone = WHATSAPP_NUMBERS[listing.contact_type];

  if (listing.pricing_type === "single") {
    const data = listing.pricing_data as SinglePricingData;
    return (
      <div className="mt-4 rounded-2xl border border-amber-950/20 bg-amber-900 p-4 shadow-md">
        <h2 className="font-heading text-lg font-bold text-white">Pricing & Booking</h2>
        <div className="mt-2">
          <PriceDisplay
            originalPrice={data.price.original_price}
            displayPrice={data.price.display_price}
            size="lg"
          />
        </div>
        <div className="mt-4">
          <BookNowButton href={whatsAppLink(phone, bookingMessage(listing.name, data.tier_name))} />
        </div>
      </div>
    );
  }

  if (listing.pricing_type === "tiered") {
    const tiers = listing.pricing_data as TieredPricingData;
    return (
      <div className="mt-4">
        <h2 className="font-heading text-lg font-bold text-stone-800">Pricing & Booking</h2>
        <div className="mt-3 flex flex-col gap-4">
          {tiers.map((tier) => (
            <div
              key={tier.tier_name}
              className="rounded-2xl border border-amber-950/20 bg-amber-900 p-4 shadow-md"
            >
              <p className="font-heading text-base font-bold text-white">{tier.tier_name}</p>
              {tier.description && <p className="mt-1 text-sm text-amber-100">{tier.description}</p>}
              <div className="mt-2">
                <PriceDisplay
                  originalPrice={tier.price.original_price}
                  displayPrice={tier.price.display_price}
                  size="md"
                />
              </div>
              <div className="mt-3">
                <BookNowButton
                  href={whatsAppLink(phone, bookingMessage(listing.name, tier.tier_name))}
                />
              </div>
            </div>
          ))}
        </div>
      </div>
    );
  }

  const services = listing.pricing_data as MultiServicePricingData;
  return (
    <div className="mt-4">
      <h2 className="font-heading text-lg font-bold text-stone-800">Pricing & Booking</h2>
      <div className="mt-3 flex flex-col gap-3">
        {services.map((service) => (
          <div
            key={service.service_name}
            className="rounded-2xl border border-amber-950/20 bg-amber-900 p-4 shadow-md"
          >
            <div className="flex items-center justify-between gap-3">
              <div>
                <p className="font-heading text-sm font-bold text-white">{service.service_name}</p>
                {service.description && (
                  <p className="mt-0.5 text-xs text-amber-100">{service.description}</p>
                )}
              </div>
              <PriceDisplay
                originalPrice={service.price.original_price}
                displayPrice={service.price.display_price}
                size="sm"
              />
            </div>
            <div className="mt-3">
              <BookNowButton
                href={whatsAppLink(
                  phone,
                  `Hi Mapscape, I would like to book ${service.service_name} at ${listing.name}.`
                )}
              />
            </div>
          </div>
        ))}
      </div>
    </div>
  );
}
