export function DocumentIcon({ className = "h-5 w-5" }: { className?: string }) {
  return (
    <svg viewBox="0 0 24 24" className={`${className} fill-current`}>
      <path d="M6 2a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V8l-6-6H6Zm7 1.5L18.5 9H13V3.5ZM8 13h8v1.5H8V13Zm0 3.5h8V18H8v-1.5ZM8 9.5h3V11H8V9.5Z" />
    </svg>
  );
}
