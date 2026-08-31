import { DocumentIcon } from "./DocumentIcon";

function filenameFromUrl(url: string) {
  try {
    const path = new URL(url).pathname;
    return decodeURIComponent(path.split("/").pop() || "Menu.pdf");
  } catch {
    return "Menu.pdf";
  }
}

export function MenuSection({ menuPdfUrl }: { menuPdfUrl: string | null }) {
  if (!menuPdfUrl) return null;

  return (
    <div className="mt-6 rounded-2xl border border-amber-950/20 bg-amber-900 p-4 shadow-md">
      <h2 className="font-heading text-lg font-bold text-white">Menu</h2>
      <div className="mt-3 flex items-center gap-3 rounded-2xl bg-amber-950/40 p-3">
        <DocumentIcon className="h-8 w-8 shrink-0 text-emerald-300" />
        <p className="min-w-0 flex-1 truncate text-sm text-amber-100">{filenameFromUrl(menuPdfUrl)}</p>
      </div>
      <a
        href={menuPdfUrl}
        target="_blank"
        rel="noopener noreferrer"
        className="mt-4 flex items-center justify-center gap-2 rounded-full bg-emerald-700 py-3 text-sm font-semibold text-white shadow-md transition-colors hover:bg-emerald-800"
      >
        <DocumentIcon className="h-4 w-4" />
        View Menu
      </a>
    </div>
  );
}
