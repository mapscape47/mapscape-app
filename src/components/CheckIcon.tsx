export function CheckIcon({ className = "h-5 w-5" }: { className?: string }) {
  return (
    <svg viewBox="0 0 24 24" className={`${className} fill-current`}>
      <path d="M9.55 17.6 4.8 12.85l1.4-1.4 3.35 3.35 8.25-8.25 1.4 1.4Z" />
    </svg>
  );
}
