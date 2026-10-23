import type { Metadata } from "next";
import { PageShell } from "@/components/PageShell";
import { whatsAppLink, callLink, WHATSAPP_NUMBERS } from "@/lib/contact";

export const metadata: Metadata = {
  title: "Privacy Policy",
  description: "How Mapscape collects, uses, and protects your information.",
};

const GENERAL_PHONE = WHATSAPP_NUMBERS.water;
const LAST_UPDATED = "23 October 2026";

const SECTIONS: { heading: string; paragraphs: string[] }[] = [
  {
    heading: "Who we are",
    paragraphs: [
      "Mapscape (“we”, “us”, “our”) operates mapscape.in, a marketplace that showcases water sports, land activities, rentals, nightlife, dining and other tourism experiences in Goa. Mapscape is based at 1611/100, Orda, Candolim, Bardez, Goa, 403515, India.",
      "This policy explains what information we collect when you use our website, how we use it, and the choices you have.",
    ],
  },
  {
    heading: "Information we collect",
    paragraphs: [
      "Browsing the site: we don't require an account to browse listings, and we don't use cookies. We use Vercel Analytics to understand which pages are popular — this collects aggregated, anonymous usage data (such as page views and general device type) and does not use cookies or track you across other websites.",
      "When you contact us: if you message us on WhatsApp, call, or email us to ask about or book an activity, we receive whatever information you choose to share — typically your name, phone number, and the details of your enquiry. We use this to respond to you and to arrange your booking with the relevant local operator.",
    ],
  },
  {
    heading: "How we use your information",
    paragraphs: [
      "We use the information you share with us to respond to enquiries, confirm bookings, coordinate with the local operator providing the activity, and improve the experiences we list. We do not sell your personal information to third parties, and we do not use it for advertising.",
    ],
  },
  {
    heading: "Sharing with operators",
    paragraphs: [
      "Because every booking on Mapscape is ultimately fulfilled by a local operator (a boat owner, rental company, restaurant, and so on), we share the details necessary to arrange your booking — such as your name, contact number, and preferred date — with that operator. We ask our operators to use this information only to fulfil your booking.",
    ],
  },
  {
    heading: "Data retention",
    paragraphs: [
      "We keep records of bookings and enquiries (including WhatsApp and email conversations) for as long as reasonably needed for business, accounting, and customer service purposes. You can ask us to delete information you've shared with us at any time — see “Contact us” below.",
    ],
  },
  {
    heading: "Security",
    paragraphs: [
      "We take reasonable steps to protect the information you share with us, but no method of transmission or storage is completely secure, and we can't guarantee absolute security.",
    ],
  },
  {
    heading: "Your choices",
    paragraphs: [
      "You can browse mapscape.in without sharing any personal information at all. If you've messaged us and would like us to delete your information, update it, or tell you what we hold, contact us using the details below and we'll action your request.",
    ],
  },
  {
    heading: "Children",
    paragraphs: [
      "Mapscape is intended for adults arranging travel and activities. We don't knowingly collect information from children.",
    ],
  },
  {
    heading: "Changes to this policy",
    paragraphs: [
      "We may update this policy from time to time as our site or services change. The “last updated” date at the top of this page reflects the most recent revision.",
    ],
  },
];

export default function PrivacyPolicyPage() {
  return (
    <PageShell
      footerWhatsAppHref={whatsAppLink(GENERAL_PHONE, "Hi, I'm interested in Mapscape experiences in Goa")}
      footerCallHref={callLink(GENERAL_PHONE)}
    >
      <main className="mx-auto max-w-lg px-4 py-6 sm:max-w-2xl">
        <div className="rounded-2xl border border-amber-950/20 bg-amber-900 p-4 text-center shadow-md">
          <h1 className="font-heading text-2xl font-bold text-white sm:text-3xl">Privacy Policy</h1>
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
              Questions about this policy, or want to access or delete your information? Reach us at{" "}
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
