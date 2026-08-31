import { PriceDisplay } from "./PriceDisplay";
import { BookNowButton } from "./BookNowButton";

type TaxiCarCardProps = {
  name: string;
  imageUrl?: string;
  capacity: string | null;
  originalPrice?: number | null;
  displayPrice: number;
  bookNowHref: string;
};

export function TaxiCarCard({
  name,
  imageUrl,
  capacity,
  originalPrice,
  displayPrice,
  bookNowHref,
}: TaxiCarCardProps) {
  return (
    <div className="w-full overflow-hidden rounded-2xl border border-amber-950/20 bg-amber-900 shadow-md">
      <div className="relative h-40 w-full bg-gradient-to-br from-emerald-100 via-stone-100 to-sky-100">
        {imageUrl ? (
          // eslint-disable-next-line @next/next/no-img-element
          <img src={imageUrl} alt={name} className="h-full w-full object-cover" />
        ) : (
          <div className="flex h-full w-full items-center justify-center text-5xl" aria-hidden="true">
            🚕
          </div>
        )}
      </div>

      <div className="p-4">
        <p className="font-heading text-base font-bold text-white">{name}</p>

        {capacity && (
          <div className="mt-1 flex flex-wrap gap-x-4 gap-y-1 text-sm text-amber-100">
            <span>{capacity}</span>
          </div>
        )}

        <div className="mt-2 flex items-baseline gap-1.5">
          <PriceDisplay originalPrice={originalPrice} displayPrice={displayPrice} size="md" />
          <span className="text-sm text-amber-100">/km</span>
        </div>

        <div className="mt-3">
          <BookNowButton href={bookNowHref} />
        </div>
      </div>
    </div>
  );
}
