export function MapPinIcon({ className = "h-5 w-5" }: { className?: string }) {
  return (
    <svg viewBox="0 0 24 24" className={`${className} fill-current`}>
      <path d="M12 2c-4.42 0-8 3.58-8 8 0 5.5 7 12 7.3 12.27a1 1 0 0 0 1.4 0C13 22 20 15.5 20 10c0-4.42-3.58-8-8-8Zm0 11a3 3 0 1 1 0-6 3 3 0 0 1 0 6Z" />
    </svg>
  );
}
