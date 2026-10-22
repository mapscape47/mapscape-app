import { ImageSlider } from "./ImageSlider";
import { PageShell } from "./PageShell";
import { StickyContactBar } from "./StickyContactBar";
import { RestaurantCard } from "./RestaurantCard";
import { whatsAppLink, callLink, WHATSAPP_NUMBERS, type Category } from "@/lib/contact";
import type { Listing, QuickAnswer } from "@/lib/listings";

type CategorySummary = {
  name: string;
  slug: string;
  category: Category;
  description: string | null;
  image_urls: string[];
};

function findAnswer(quickAnswers: QuickAnswer[], label: string) {
  return quickAnswers.find((qa) => qa.label === label)?.value ?? null;
}

export function RestaurantListPageView({
  category,
  listings,
}: {
  category: CategorySummary;
  listings: Listing[];
}) {
  const phone = WHATSAPP_NUMBERS[category.category];
  const generalMessage = `Hi Mapscape, I'm interested in ${category.name}.`;

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
        <ImageSlider images={category.image_urls} alt={category.name} />
      </div>

      <main className="mx-auto max-w-lg px-4 py-6 sm:max-w-2xl">
        <div className="rounded-2xl border border-amber-950/20 bg-amber-900 p-4 text-center shadow-md">
          <h1 className="font-heading text-2xl font-bold text-white sm:text-3xl">{category.name}</h1>
        </div>

        {category.description && (
          <div className="mt-4 rounded-2xl border border-amber-950/20 bg-amber-900 p-4 text-center shadow-md">
            <p className="text-sm leading-relaxed text-amber-100">{category.description}</p>
          </div>
        )}

        <div className="mt-6 flex flex-col gap-4">
          {listings.map((listing) => (
            <RestaurantCard
              key={listing.slug}
              name={listing.name}
              imageUrl={listing.photos[0]}
              cuisine={findAnswer(listing.quick_answers, "Cuisine Type")}
              timings={findAnswer(listing.quick_answers, "Timings")}
              linkHref={`/${category.slug}/${listing.slug}`}
            />
          ))}
        </div>
      </main>
    </PageShell>
  );
}
