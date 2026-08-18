"use client";

import { useEffect, useRef, useState } from "react";

// Placeholder gradient slides in the muted palette — swap for real
// illustrated assets once they're ready by passing an `images` prop.
const PLACEHOLDER_SLIDES = [
  "from-emerald-200 via-emerald-100 to-stone-100",
  "from-sky-100 via-stone-100 to-emerald-100",
  "from-stone-200 via-stone-100 to-sky-100",
  "from-emerald-100 via-sky-100 to-stone-100",
  "from-stone-100 via-emerald-100 to-sky-100",
];

const AUTO_ADVANCE_MS = 4000;
const RESUME_AFTER_MS = 5000;

export function ImageSlider({ images }: { images?: string[] }) {
  const usingRealImages = Boolean(images && images.length > 0);
  const slides = usingRealImages ? (images as string[]) : PLACEHOLDER_SLIDES;

  const [index, setIndex] = useState(0);
  const [paused, setPaused] = useState(false);
  const trackRef = useRef<HTMLDivElement>(null);
  const resumeTimer = useRef<ReturnType<typeof setTimeout> | null>(null);
  const scrollDebounce = useRef<ReturnType<typeof setTimeout> | null>(null);
  const suppressScrollSync = useRef(false);

  useEffect(() => {
    if (paused) return;
    const id = setInterval(() => {
      setIndex((i) => (i + 1) % slides.length);
    }, AUTO_ADVANCE_MS);
    return () => clearInterval(id);
  }, [paused, slides.length]);

  useEffect(() => {
    const el = trackRef.current;
    if (!el) return;
    suppressScrollSync.current = true;
    el.scrollTo({ left: index * el.clientWidth, behavior: "smooth" });
    const t = setTimeout(() => {
      suppressScrollSync.current = false;
    }, 500);
    return () => clearTimeout(t);
  }, [index]);

  function pauseAndScheduleResume() {
    setPaused(true);
    if (resumeTimer.current) clearTimeout(resumeTimer.current);
    resumeTimer.current = setTimeout(() => setPaused(false), RESUME_AFTER_MS);
  }

  function handleScroll() {
    if (suppressScrollSync.current) return;
    if (scrollDebounce.current) clearTimeout(scrollDebounce.current);
    scrollDebounce.current = setTimeout(() => {
      const el = trackRef.current;
      if (!el || el.clientWidth === 0) return;
      const nearest = Math.round(el.scrollLeft / el.clientWidth);
      setIndex(nearest);
    }, 120);
  }

  return (
    <div
      className="relative overflow-hidden rounded-2xl border-[10px] border-amber-900 bg-stone-100"
      onPointerDown={pauseAndScheduleResume}
      onTouchStart={pauseAndScheduleResume}
      onWheel={pauseAndScheduleResume}
    >
      <div
        ref={trackRef}
        onScroll={handleScroll}
        className="flex h-56 w-full snap-x snap-mandatory overflow-x-auto scroll-smooth sm:h-72 [scrollbar-width:none] [&::-webkit-scrollbar]:hidden"
      >
        {slides.map((slide, i) => (
          <div key={i} className="h-full w-full flex-shrink-0 snap-center">
            {usingRealImages ? (
              // eslint-disable-next-line @next/next/no-img-element
              <img src={slide} alt="" className="h-full w-full object-cover" />
            ) : (
              <div className={`h-full w-full bg-gradient-to-br ${slide}`} />
            )}
          </div>
        ))}
      </div>

      <div className="absolute bottom-3 left-1/2 flex -translate-x-1/2 gap-1.5">
        {slides.map((_, i) => (
          <span
            key={i}
            className={`h-1.5 w-1.5 rounded-full transition-colors ${
              i === index ? "bg-white" : "bg-white/50"
            }`}
          />
        ))}
      </div>
    </div>
  );
}
