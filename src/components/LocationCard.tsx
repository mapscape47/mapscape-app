import { MapPinIcon } from "./MapPinIcon";

function directionsHref(address: string | null, lat: number | null, lng: number | null) {
  if (lat != null && lng != null) {
    return `https://www.google.com/maps/dir/?api=1&destination=${lat},${lng}`;
  }
  if (address) {
    return `https://www.google.com/maps/search/?api=1&query=${encodeURIComponent(address)}`;
  }
  return "https://www.google.com/maps";
}

export function LocationCard({
  address,
  lat,
  lng,
}: {
  address: string | null;
  lat: number | null;
  lng: number | null;
}) {
  return (
    <div className="mt-6 rounded-2xl border border-amber-950/20 bg-amber-900 p-4 shadow-md">
      <h2 className="font-heading text-lg font-bold text-white">Location</h2>
      {address && <p className="mt-2 text-sm text-amber-100">{address}</p>}
      <a
        href={directionsHref(address, lat, lng)}
        target="_blank"
        rel="noopener noreferrer"
        className="mt-4 flex items-center justify-center gap-2 rounded-full bg-emerald-700 py-3 text-sm font-semibold text-white shadow-md transition-colors hover:bg-emerald-800"
      >
        <MapPinIcon />
        Get Directions
      </a>
    </div>
  );
}
