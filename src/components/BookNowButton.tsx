import { WhatsAppIcon } from "./WhatsAppIcon";

export function BookNowButton({ href, label = "Book Now" }: { href: string; label?: string }) {
  return (
    <a
      href={href}
      target="_blank"
      rel="noopener noreferrer"
      className="flex items-center justify-center gap-2 rounded-full bg-emerald-700 py-2.5 text-sm font-semibold text-white shadow transition-colors hover:bg-emerald-800"
    >
      <WhatsAppIcon className="h-4 w-4" />
      {label}
    </a>
  );
}
