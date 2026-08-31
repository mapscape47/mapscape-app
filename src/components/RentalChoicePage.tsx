import Link from "next/link";
import { PageShell } from "./PageShell";
import { whatsAppLink, callLink, WHATSAPP_NUMBERS } from "@/lib/contact";

export function RentalChoicePage() {
  const phone = WHATSAPP_NUMBERS.land;
  const generalMessage = "Hi Mapscape, I'm interested in vehicle rentals.";

  return (
    <PageShell
      footerWhatsAppHref={whatsAppLink(phone, generalMessage)}
      footerCallHref={callLink(phone)}
    >
      <main className="mx-auto max-w-lg px-4 py-10 sm:max-w-2xl">
        <div className="rounded-2xl border border-amber-950/20 bg-amber-900 p-4 text-center shadow-md">
          <h1 className="font-heading text-2xl font-bold text-white sm:text-3xl">Rentals</h1>
        </div>

        <div className="mt-6 flex flex-col gap-4">
          <Link
            href="/rental/bike"
            className="block overflow-hidden rounded-2xl border border-amber-950/20 bg-amber-900 shadow-md transition-colors hover:bg-amber-950"
          >
            <div
              className="flex h-40 w-full items-center justify-center bg-gradient-to-br from-emerald-100 via-stone-100 to-sky-100 text-6xl"
              aria-hidden="true"
            >
              🏍️
            </div>
            <div className="p-4 text-center">
              <span className="font-heading text-xl font-bold text-white">Bike Rental</span>
            </div>
          </Link>
          <Link
            href="/rental/car"
            className="block overflow-hidden rounded-2xl border border-amber-950/20 bg-amber-900 shadow-md transition-colors hover:bg-amber-950"
          >
            <div
              className="flex h-40 w-full items-center justify-center bg-gradient-to-br from-emerald-100 via-stone-100 to-sky-100 text-6xl"
              aria-hidden="true"
            >
              🚗
            </div>
            <div className="p-4 text-center">
              <span className="font-heading text-xl font-bold text-white">Car Rental</span>
            </div>
          </Link>
        </div>
      </main>
    </PageShell>
  );
}
