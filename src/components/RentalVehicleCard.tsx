import { PriceDisplay } from "./PriceDisplay";
import { BookNowButton } from "./BookNowButton";

type RentalVehicleCardProps = {
  name: string;
  imageUrl?: string;
  placeholderIcon: string;
  transmission: string | null;
  seatingCapacity: string | null;
  originalPrice?: number | null;
  displayPrice?: number;
  priceLabel?: string | null;
  bookNowHref: string;
};

export function RentalVehicleCard({
  name,
  imageUrl,
  placeholderIcon,
  transmission,
  seatingCapacity,
  originalPrice,
  displayPrice,
  priceLabel,
  bookNowHref,
}: RentalVehicleCardProps) {
  return (
    <div className="w-full overflow-hidden rounded-2xl border border-amber-950/20 bg-amber-900 shadow-md">
      <div className="relative h-40 w-full bg-gradient-to-br from-emerald-100 via-stone-100 to-sky-100">
        {imageUrl ? (
          // eslint-disable-next-line @next/next/no-img-element
          <img src={imageUrl} alt={name} loading="lazy" className="h-full w-full object-cover" />
        ) : (
          <div className="flex h-full w-full items-center justify-center text-5xl" aria-hidden="true">
            {placeholderIcon}
          </div>
        )}
      </div>

      <div className="p-4">
        <p className="font-heading text-base font-bold text-white">{name}</p>

        {(transmission || seatingCapacity) && (
          <div className="mt-1 flex flex-wrap gap-x-4 gap-y-1 text-sm text-amber-100">
            {transmission && <span>{transmission}</span>}
            {seatingCapacity && <span>{seatingCapacity}</span>}
          </div>
        )}

        <div className="mt-2 flex items-baseline gap-1.5">
          {displayPrice !== undefined ? (
            <>
              <PriceDisplay originalPrice={originalPrice} displayPrice={displayPrice} size="md" />
              <span className="text-sm text-amber-100">/day</span>
            </>
          ) : (
            priceLabel && <span className="text-xl font-bold text-white">{priceLabel}</span>
          )}
        </div>

        <div className="mt-3">
          <BookNowButton href={bookNowHref} />
        </div>
      </div>
    </div>
  );
}
