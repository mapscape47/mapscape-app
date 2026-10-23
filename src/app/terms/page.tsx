import type { Metadata } from "next";
import { PageShell } from "@/components/PageShell";
import { whatsAppLink, callLink, WHATSAPP_NUMBERS } from "@/lib/contact";

export const metadata: Metadata = {
  title: "Terms of Use",
  description: "The terms that apply when you use Mapscape to browse and book activities in Goa.",
};

const GENERAL_PHONE = WHATSAPP_NUMBERS.water;
const LAST_UPDATED = "23 October 2026";

const SECTIONS: { heading: string; paragraphs: string[] }[] = [
  {
    heading: "Agreement to terms",
    paragraphs: [
      "By using mapscape.in (“Mapscape”, “we”, “us”), you agree to these Terms of Use. If you don't agree, please don't use the site.",
    ],
  },
  {
    heading: "What Mapscape is",
    paragraphs: [
      "Mapscape is a marketplace that showcases water sports, land activities, rentals, nightlife, dining and other tourism experiences in Goa. The activities, rentals and services listed are provided by independent, third-party local operators — Mapscape is not itself a dive school, boat owner, car rental company, restaurant, or nightclub.",
      "When you message us to book, Mapscape acts as the point of contact to arrange your booking with the relevant operator. This keeps the process simple and lets us stand behind the listings we feature.",
    ],
  },
  {
    heading: "Bookings and pricing",
    paragraphs: [
      "Prices shown on Mapscape are indicative and set by the operator; they may change, and final pricing, availability, and booking terms are confirmed directly with you over WhatsApp or phone before you commit. Payment is arranged directly with Mapscape or the operator at the time of booking — Mapscape does not process payments on this website.",
    ],
  },
  {
    heading: "Third-party activities and your own risk",
    paragraphs: [
      "Many activities listed on Mapscape — water sports, adventure activities, and similar — carry inherent risk. We feature operators we believe are reputable, but we don't own, run, or directly supervise their operations. Participation in any activity is at your own risk and subject to the operator's own safety practices, instructions, and terms. Please follow all safety guidance given on-site by the operator.",
      "Mapscape is not liable for the acts, omissions, quality of service, or safety practices of any third-party operator. Any dispute about the activity itself should be raised with the operator; if you'd like help, let us know and we'll do what we can to assist.",
    ],
  },
  {
    heading: "Using the site",
    paragraphs: [
      "You agree to use Mapscape only for lawful purposes — to browse listings and make genuine enquiries or bookings. Please don't misuse the site (for example, by attempting to disrupt it, scrape it at scale, or impersonate someone else).",
    ],
  },
  {
    heading: "Content and intellectual property",
    paragraphs: [
      "Text, photos, and design on mapscape.in belong to Mapscape or are used with the relevant operator's permission, unless otherwise noted. Please don't reproduce or redistribute our content without asking first.",
    ],
  },
  {
    heading: "No warranty",
    paragraphs: [
      "We do our best to keep listings, prices, and photos accurate and up to date, but we can't guarantee the site is always error-free, uninterrupted, or perfectly current. The site and its listings are provided “as is.”",
    ],
  },
  {
    heading: "Limitation of liability",
    paragraphs: [
      "To the extent permitted by law, Mapscape is not liable for indirect or consequential losses arising from your use of the site or participation in a listed activity. Nothing in these terms limits liability that can't be limited under Indian law.",
    ],
  },
  {
    heading: "Changes to these terms",
    paragraphs: [
      "We may update these terms from time to time as our site or services change. The “last updated” date at the top of this page reflects the most recent revision. Continuing to use Mapscape after a change means you accept the updated terms.",
    ],
  },
  {
    heading: "Governing law",
    paragraphs: ["These terms are governed by the laws of India, and disputes are subject to the jurisdiction of the courts in Goa."],
  },
];

export default function TermsOfUsePage() {
  return (
    <PageShell
      footerWhatsAppHref={whatsAppLink(GENERAL_PHONE, "Hi, I'm interested in Mapscape experiences in Goa")}
      footerCallHref={callLink(GENERAL_PHONE)}
    >
      <main className="mx-auto max-w-lg px-4 py-6 sm:max-w-2xl">
        <div className="rounded-2xl border border-amber-950/20 bg-amber-900 p-4 text-center shadow-md">
          <h1 className="font-heading text-2xl font-bold text-white sm:text-3xl">Terms of Use</h1>
          <p className="mt-1 text-xs text-amber-200/85">Last updated {LAST_UPDATED}</p>
        </div>

        <div className="mt-4 flex flex-col gap-4">
          {SECTIONS.map((section) => (
            <div
              key={section.heading}
              className="space-y-3 rounded-2xl border border-amber-950/20 bg-amber-900 p-4 shadow-md"
            >
              <h2 className="font-heading text-base font-bold text-white">{section.heading}</h2>
              {section.paragraphs.map((paragraph, i) => (
                <p key={i} className="text-sm leading-relaxed text-amber-100">
                  {paragraph}
                </p>
              ))}
            </div>
          ))}

          <div className="space-y-2 rounded-2xl border border-amber-950/20 bg-amber-900 p-4 shadow-md">
            <h2 className="font-heading text-base font-bold text-white">Contact us</h2>
            <p className="text-sm leading-relaxed text-amber-100">
              Questions about these terms? Reach us at{" "}
              <a href="mailto:mapscape47@gmail.com" className="underline hover:text-white">
                mapscape47@gmail.com
              </a>{" "}
              or message us on WhatsApp.
            </p>
          </div>
        </div>
      </main>
    </PageShell>
  );
}
