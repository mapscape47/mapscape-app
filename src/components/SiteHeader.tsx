"use client";

import Image from "next/image";

export function SiteHeader() {
  return (
    <header className="flex items-center gap-2 border-b border-stone-200 bg-white px-4 py-3">
      <Image
        src="/mapscape-logo.webp"
        alt="Mapscape"
        width={36}
        height={36}
        priority
        className="shrink-0"
      />

      <div className="flex-1">
        <input
          type="search"
          placeholder="Search activities..."
          className="w-full rounded-full border border-stone-200 bg-stone-50 px-4 py-2 text-sm text-stone-700 placeholder:text-stone-400 focus:outline-none focus:ring-2 focus:ring-emerald-200"
        />
      </div>

      <button
        type="button"
        aria-label="Open menu"
        onClick={() => {
          // Placeholder — will open the settings/navigation drawer later.
          console.log("Menu clicked");
        }}
        className="flex h-9 w-9 shrink-0 items-center justify-center rounded-full text-emerald-800 hover:bg-stone-100"
      >
        <span className="text-xl leading-none">☰</span>
      </button>
    </header>
  );
}
