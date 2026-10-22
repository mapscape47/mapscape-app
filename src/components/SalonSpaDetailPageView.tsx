import { ImageSlider } from "./ImageSlider";
import { PageShell } from "./PageShell";
import { StickyContactBar } from "./StickyContactBar";
import { BackLink } from "./BackLink";
import { OverviewPointsCard } from "./OverviewPointsCard";
import { QuickAnswersCard } from "./QuickAnswersCard";
import { BookNowButton } from "./BookNowButton";
import { MenuSection } from "./MenuSection";
import { whatsAppLink, callLink, WHATSAPP_NUMBERS } from "@/lib/contact";
import type { Listing } from "@/lib/listings";

const BRANCH_PREFIX = "Branch: ";

export function SalonSpaDetailPageView({
  listing,
  parentSlug,
  parentName,
}: {
  listing: Listing & { menu_pdf_url: string | null };
  parentSlug: string;
  parentName: string;
}) {
  const phone = WHATSAPP_NUMBERS[listing.contact_type];
  const generalMessage = `Hi Mapscape, I'm interested in ${listing.name}.`;

  // Branch area names only — never the map link that used to sit in
  // `value`, so a customer can't skip straight to the exact spot
  // without booking through us first.
  const branchAreaNames = listing.quick_answers
    .filter((qa) => qa.label.startsWith(BRANCH_PREFIX))
    .map((qa) => qa.label.slice(BRANCH_PREFIX.length));
  const otherAnswers = listing.quick_answers.filter((qa) => !qa.label.startsWith(BRANCH_PREFIX));

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
          <ImageSlider images={listing.photos} alt={listing.name} />
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

        <OverviewPointsCard points={listing.overview_points} />

        <QuickAnswersCard answers={otherAnswers} />

        {branchAreaNames.length > 0 && (
          <div className="mt-6 rounded-2xl border border-amber-950/20 bg-amber-900 p-4 shadow-md">
            <h2 className="font-heading text-lg font-bold text-white">
              {branchAreaNames.length > 1 ? "Locations" : "Location"}
            </h2>
            <div className="mt-3 flex flex-col gap-4">
              {branchAreaNames.map((branch) => (
                <div key={branch}>
                  <p className="text-sm text-amber-100">{branch}</p>
                  <div className="mt-2">
                    <BookNowButton
                      label="Book Appointment"
                      href={whatsAppLink(
                        phone,
                        `Hi Mapscape, I would like to book an appointment at ${listing.name} in ${branch} location.`
                      )}
                    />
                  </div>
                </div>
              ))}
            </div>
          </div>
        )}

        <MenuSection menuPdfUrl={listing.menu_pdf_url} />
      </main>
    </PageShell>
  );
}
