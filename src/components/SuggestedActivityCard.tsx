"use client";

import { useRef } from "react";
import { useRouter } from "next/navigation";
import { ImageSlider } from "./ImageSlider";

// Threshold (in px) below which a pointer down→up is treated as a tap
// rather than a swipe/drag — lets the slider's own swipe handling and
// this card's tap-to-navigate coexist without either stealing from
// the other.
const TAP_MAX_MOVEMENT = 10;

export function SuggestedActivityCard({
  title,
  tag,
  images,
  linkHref,
}: {
  title: string;
  tag?: string;
  images: string[];
  linkHref: string;
}) {
  const router = useRouter();
  const pointerStart = useRef<{ x: number; y: number } | null>(null);

  function handlePointerDown(e: React.PointerEvent) {
    pointerStart.current = { x: e.clientX, y: e.clientY };
  }

  function handlePointerUp(e: React.PointerEvent) {
    const start = pointerStart.current;
    pointerStart.current = null;
    if (!start) return;
    const dx = Math.abs(e.clientX - start.x);
    const dy = Math.abs(e.clientY - start.y);
    if (dx < TAP_MAX_MOVEMENT && dy < TAP_MAX_MOVEMENT) {
      router.push(linkHref);
    }
  }

  return (
    <div
      role="link"
      tabIndex={0}
      onPointerDown={handlePointerDown}
      onPointerUp={handlePointerUp}
      onKeyDown={(e) => {
        if (e.key === "Enter" || e.key === " ") {
          e.preventDefault();
          router.push(linkHref);
        }
      }}
      className="block w-full cursor-pointer overflow-hidden rounded-2xl border border-amber-950/20 bg-amber-900 shadow-md"
    >
      <div className="relative">
        <ImageSlider images={images} />
        {tag && (
          <span className="pointer-events-none absolute left-4 top-4 inline-block rounded-full bg-white/90 px-2.5 py-0.5 text-xs font-medium text-emerald-700 backdrop-blur">
            {tag}
          </span>
        )}
      </div>
      <div className="p-3">
        <p className="font-semibold text-white">{title}</p>
      </div>
    </div>
  );
}
