import Link from "next/link";

type RestaurantCardProps = {
  name: string;
  imageUrl?: string;
  cuisine: string | null;
  timings: string | null;
  linkHref: string;
};

export function RestaurantCard({ name, imageUrl, cuisine, timings, linkHref }: RestaurantCardProps) {
  return (
    <Link
      href={linkHref}
      className="block w-full overflow-hidden rounded-2xl border border-amber-950/20 bg-amber-900 shadow-md"
    >
      <div className="relative h-40 w-full bg-gradient-to-br from-emerald-100 via-stone-100 to-sky-100">
        {imageUrl && (
          // eslint-disable-next-line @next/next/no-img-element
          <img src={imageUrl} alt={name} className="h-full w-full object-cover" />
        )}
      </div>
      <div className="p-3">
        <p className="font-semibold text-white">{name}</p>
        {(cuisine || timings) && (
          <div className="mt-1 flex flex-wrap gap-x-4 gap-y-1 text-sm text-amber-100">
            {cuisine && <span>{cuisine}</span>}
            {timings && <span>{timings}</span>}
          </div>
        )}
      </div>
    </Link>
  );
}
