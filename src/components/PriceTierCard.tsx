import Link from "next/link";
import { PriceDisplay } from "./PriceDisplay";

type PriceTierCardProps = {
  title: string;
  tag?: string;
  imageUrl?: string;
  linkHref: string;
  originalPrice?: number | null;
  displayPrice?: number;
  pricePrefix?: string;
};

export function PriceTierCard({
  title,
  tag,
  imageUrl,
  linkHref,
  originalPrice,
  displayPrice,
  pricePrefix,
}: PriceTierCardProps) {
  return (
    <Link
      href={linkHref}
      className="block w-full overflow-hidden rounded-2xl border border-amber-950/20 bg-amber-900 shadow-md"
    >
      <div className="relative h-40 w-full bg-gradient-to-br from-emerald-100 via-stone-100 to-sky-100">
        {imageUrl && (
          // eslint-disable-next-line @next/next/no-img-element
          <img src={imageUrl} alt={title} className="h-full w-full object-cover" />
        )}
        {tag && (
          <span className="absolute left-3 top-3 inline-block rounded-full bg-white/90 px-2.5 py-0.5 text-xs font-medium text-emerald-700 backdrop-blur">
            {tag}
          </span>
        )}
      </div>
      <div className="p-3">
        <p className="font-semibold text-white">{title}</p>
        {displayPrice !== undefined && (
          <div className="mt-1">
            <PriceDisplay originalPrice={originalPrice} displayPrice={displayPrice} prefix={pricePrefix} size="sm" />
          </div>
        )}
      </div>
    </Link>
  );
}
