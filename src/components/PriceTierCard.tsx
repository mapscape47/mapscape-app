"use client";

import { useState } from "react";
import { WhatsAppIcon } from "./WhatsAppIcon";

type PriceTierCardProps = {
  title: string;
  price: number;
  tag: string;
  imageUrl?: string;
  ctaHref: string;
  ctaLabel?: string;
};

export function PriceTierCard({
  title,
  price,
  tag,
  imageUrl,
  ctaHref,
  ctaLabel = "Book on WhatsApp",
}: PriceTierCardProps) {
  const [expanded, setExpanded] = useState(false);

  return (
    <div className="w-full overflow-hidden rounded-2xl border border-amber-950/20 bg-amber-900 shadow-md">
      <button
        type="button"
        onClick={() => setExpanded((v) => !v)}
        aria-expanded={expanded}
        className="block w-full text-left"
      >
        <div className="relative h-40 w-full bg-gradient-to-br from-emerald-100 via-stone-100 to-sky-100">
          {imageUrl && (
            // eslint-disable-next-line @next/next/no-img-element
            <img src={imageUrl} alt={title} className="h-full w-full object-cover" />
          )}
          <span className="absolute left-3 top-3 inline-block rounded-full bg-white/90 px-2.5 py-0.5 text-xs font-medium text-emerald-700 backdrop-blur">
            {tag}
          </span>
        </div>
        <div className="p-3">
          <p className="font-semibold text-white">{title}</p>
          <p className="text-sm text-amber-100">
            From{" "}
            <span className="font-semibold text-white">
              ₹{price.toLocaleString("en-IN")}
            </span>
          </p>
        </div>
      </button>

      {expanded && (
        <div className="border-t border-amber-950/30 p-3">
          <a
            href={ctaHref}
            target="_blank"
            rel="noopener noreferrer"
            className="flex items-center justify-center gap-2 rounded-full bg-emerald-700 px-4 py-2.5 text-sm font-semibold text-white transition-colors hover:bg-emerald-800"
          >
            <WhatsAppIcon />
            {ctaLabel}
          </a>
        </div>
      )}
    </div>
  );
}
