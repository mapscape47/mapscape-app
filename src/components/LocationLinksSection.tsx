import { MapPinIcon } from "./MapPinIcon";

export type BranchLocation = {
  label: string;
  mapLink: string;
};

export function LocationLinksSection({ locations }: { locations: BranchLocation[] }) {
  if (locations.length === 0) return null;

  return (
    <div className="mt-6 rounded-2xl border border-amber-950/20 bg-amber-900 p-4 shadow-md">
      <h2 className="font-heading text-lg font-bold text-white">
        {locations.length > 1 ? "Locations" : "Location"}
      </h2>
      <div className="mt-3 flex flex-col gap-4">
        {locations.map((loc) => (
          <div key={loc.label}>
            <p className="text-sm text-amber-100">{loc.label}</p>
            <a
              href={loc.mapLink}
              target="_blank"
              rel="noopener noreferrer"
              className="mt-2 flex items-center justify-center gap-2 rounded-full bg-emerald-700 py-3 text-sm font-semibold text-white shadow-md transition-colors hover:bg-emerald-800"
            >
              <MapPinIcon />
              Get Directions
            </a>
          </div>
        ))}
      </div>
    </div>
  );
}
