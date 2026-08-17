import { WhatsAppIcon } from "./WhatsAppIcon";
import { PhoneIcon } from "./PhoneIcon";

type StickyContactBarProps = {
  whatsAppHref: string;
  whatsAppLabel: string;
  callHref: string;
  callLabel: string;
};

export function StickyContactBar({
  whatsAppHref,
  whatsAppLabel,
  callHref,
  callLabel,
}: StickyContactBarProps) {
  return (
    <div className="fixed inset-x-0 bottom-0 z-30 border-t border-stone-200 bg-white px-4 py-3">
      <div className="flex flex-col gap-2">
        <a
          href={whatsAppHref}
          target="_blank"
          rel="noopener noreferrer"
          className="flex items-center justify-center gap-2 rounded-full bg-emerald-700 py-3 text-sm font-semibold text-white shadow-md transition-colors hover:bg-emerald-800"
        >
          <WhatsAppIcon />
          {whatsAppLabel}
        </a>
        <a
          href={callHref}
          className="flex items-center justify-center gap-2 rounded-full bg-amber-900 py-3 text-sm font-semibold text-white shadow-sm transition-colors hover:bg-amber-950"
        >
          <PhoneIcon />
          {callLabel}
        </a>
      </div>
    </div>
  );
}
