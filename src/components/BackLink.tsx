import Link from "next/link";

export function BackLink({ href, label }: { href: string; label: string }) {
  return (
    <Link
      href={href}
      className="inline-flex items-center gap-1.5 rounded-full bg-amber-900 px-3 py-1.5 text-sm font-semibold text-white shadow-md transition-colors hover:bg-amber-950"
    >
      <span aria-hidden="true">←</span>
      {label}
    </Link>
  );
}
