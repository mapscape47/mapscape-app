import { ImageSlider } from "./ImageSlider";
import { PageShell } from "./PageShell";
import { StickyContactBar } from "./StickyContactBar";
import { BackLink } from "./BackLink";
import { OverviewPointsCard } from "./OverviewPointsCard";
import { QuickAnswersCard } from "./QuickAnswersCard";
import { LocationCard } from "./LocationCard";
import { PricingSection } from "./PricingSection";
import { whatsAppLink, callLink, WHATSAPP_NUMBERS } from "@/lib/contact";
import type { Listing } from "@/lib/listings";

export function ListingPageView({
  listing,
  parentSlug,
  parentName,
}: {
  listing: Listing;
  parentSlug: string;
  parentName: string;
}) {
  const phone = WHATSAPP_NUMBERS[listing.contact_type];
  const generalMessage = `Hi Mapscape, I'm interested in ${listing.name}.`;

  return (
    <PageShell
      footerWhatsAppHref={whatsAppLink(phone, generalMessage)}
      footerCallHref={callLink(phone)}
      stickyBar={
        <StickyContactBar
          whatsAppHref={whatsAppLink(phone, generalMessage)}
          whatsAppLabel="Chat on WhatsApp"
          callHref={callLink(phone)}
          callLabel="Call Us"
        />
      }
    >
      <div className="mx-auto max-w-lg px-4 pt-4 sm:max-w-2xl">
        <BackLink href={`/${parentSlug}`} label={`Back to ${parentName}`} />
        <div className="mt-3">
          <ImageSlider images={listing.photos} />
        </div>
      </div>

      <main className="mx-auto max-w-lg px-4 py-6 sm:max-w-2xl">
        <div className="rounded-2xl border border-amber-950/20 bg-amber-900 p-4 text-center shadow-md">
          <h1 className="font-heading text-2xl font-bold text-white sm:text-3xl">{listing.name}</h1>
        </div>

        {listing.description && (
          <div className="mt-4 rounded-2xl border border-amber-950/20 bg-amber-900 p-4 text-center shadow-md">
            <p className="text-sm leading-relaxed text-amber-100">{listing.description}</p>
          </div>
        )}

        <PricingSection listing={listing} />

        <OverviewPointsCard points={listing.overview_points} />

        <QuickAnswersCard answers={listing.quick_answers} />

        <LocationCard
          address={listing.location_address}
          lat={listing.location_lat}
          lng={listing.location_lng}
        />
      </main>
    </PageShell>
  );
}
