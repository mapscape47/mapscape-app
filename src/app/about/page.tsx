import type { Metadata } from "next";
import { PageShell } from "@/components/PageShell";
import { whatsAppLink, callLink, WHATSAPP_NUMBERS } from "@/lib/contact";

export const metadata: Metadata = {
  title: "About Us",
  description: "Mapscape is a curated marketplace for Goa's water sports, land activities, rentals, nightlife and more — book directly with vetted local operators over WhatsApp.",
};

// Attractions/about have no commission category of their own, so the
// footer falls back to the water-activities line — same convention as
// AttractionPageView.
const GENERAL_PHONE = WHATSAPP_NUMBERS.water;

export default function AboutPage() {
  return (
    <PageShell
      footerWhatsAppHref={whatsAppLink(GENERAL_PHONE, "Hi, I'm interested in Mapscape experiences in Goa")}
      footerCallHref={callLink(GENERAL_PHONE)}
    >
      <main className="mx-auto max-w-lg px-4 py-6 sm:max-w-2xl">
        <div className="rounded-2xl border border-amber-950/20 bg-amber-900 p-4 text-center shadow-md">
          <h1 className="font-heading text-2xl font-bold text-white sm:text-3xl">About Mapscape</h1>
        </div>

        <div className="mt-4 space-y-4 rounded-2xl border border-amber-950/20 bg-amber-900 p-4 shadow-md">
          <p className="text-sm leading-relaxed text-amber-100">
            Mapscape is a curated marketplace for experiencing Goa — water sports, land activities,
            rentals, nightlife, dining, wellness and more, all in one place. We work directly with
            vetted local operators so you can browse real listings, real prices, and real photos
            before you book.
          </p>
          <p className="text-sm leading-relaxed text-amber-100">
            No accounts, no apps to install. When you're ready, every listing connects you straight
            to the operator on WhatsApp to confirm your booking — simple, direct, and personal.
          </p>
          <p className="text-sm leading-relaxed text-amber-100">
            Based in Candolim, Goa, Mapscape is built by people who know the coastline and want
            visitors to experience it the way locals do.
          </p>
        </div>
      </main>
    </PageShell>
  );
}
