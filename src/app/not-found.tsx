import Link from "next/link";
import { PageShell } from "@/components/PageShell";
import { whatsAppLink, callLink, WHATSAPP_NUMBERS } from "@/lib/contact";

const GENERAL_PHONE = WHATSAPP_NUMBERS.water;

export default function NotFound() {
  return (
    <PageShell
      footerWhatsAppHref={whatsAppLink(GENERAL_PHONE, "Hi, I'm interested in Mapscape experiences in Goa")}
      footerCallHref={callLink(GENERAL_PHONE)}
    >
      <main className="mx-auto flex max-w-lg flex-col items-center px-4 py-16 text-center sm:max-w-2xl">
        <div className="w-full rounded-2xl border border-amber-950/20 bg-amber-900 p-8 shadow-md">
          <p className="font-heading text-5xl font-bold text-white">404</p>
          <h1 className="mt-2 font-heading text-xl font-bold text-white">Page Not Found</h1>
          <p className="mt-3 text-sm leading-relaxed text-amber-100">
            This page doesn&apos;t exist, or the listing may no longer be active.
          </p>
          <Link
            href="/"
            className="mt-6 inline-flex items-center justify-center rounded-full bg-emerald-700 px-6 py-3 text-sm font-semibold text-white shadow-md transition-colors hover:bg-emerald-800"
          >
            Return Home
          </Link>
        </div>
      </main>
    </PageShell>
  );
}
