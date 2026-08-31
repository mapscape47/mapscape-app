export function OverviewPointsCard({ points }: { points: string[] | null }) {
  if (!points || points.length === 0) return null;

  return (
    <div className="mt-4 rounded-2xl border border-amber-950/20 bg-amber-900 p-4 shadow-md">
      <ul className="space-y-2 text-sm text-amber-100">
        {points.map((point) => (
          <li key={point} className="flex items-start gap-2">
            <span aria-hidden="true" className="mt-1.5 h-1.5 w-1.5 shrink-0 rounded-full bg-emerald-300" />
            <span>{point}</span>
          </li>
        ))}
      </ul>
    </div>
  );
}
