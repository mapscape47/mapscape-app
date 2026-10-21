import { DocumentIcon } from "./DocumentIcon";

function filenameFromUrl(url: string) {
  try {
    const path = new URL(url).pathname;
    return decodeURIComponent(path.split("/").pop() || "Menu.pdf");
  } catch {
    return "Menu.pdf";
  }
}

export type MenuItem = { label: string; url: string };

export function MenuSection({
  menuPdfUrl,
  menus,
}: {
  menuPdfUrl?: string | null;
  menus?: MenuItem[] | null;
}) {
  if (menus && menus.length > 0) {
    return (
      <div className="mt-6 rounded-2xl border border-amber-950/20 bg-amber-900 p-4 shadow-md">
        <h2 className="font-heading text-lg font-bold text-white">Menu</h2>
        <div className="mt-3 flex flex-col gap-3">
          {menus.map((item) => (
            <div key={item.url}>
              <div className="flex items-center gap-3 rounded-2xl bg-amber-950/40 p-3">
                <DocumentIcon className="h-8 w-8 shrink-0 text-emerald-300" />
                <p className="min-w-0 flex-1 truncate text-sm text-amber-100">{item.label}</p>
              </div>
              <a
                href={item.url}
                target="_blank"
                rel="noopener noreferrer"
                className="mt-3 flex items-center justify-center gap-2 rounded-full bg-emerald-700 py-3 text-sm font-semibold text-white shadow-md transition-colors hover:bg-emerald-800"
              >
                <DocumentIcon className="h-4 w-4" />
                View {item.label}
              </a>
            </div>
          ))}
        </div>
      </div>
    );
  }

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
