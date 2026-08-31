type PriceDisplayProps = {
  originalPrice?: number | null;
  displayPrice: number;
  prefix?: string;
  size?: "sm" | "md" | "lg";
};

const DISPLAY_SIZE: Record<NonNullable<PriceDisplayProps["size"]>, string> = {
  sm: "text-base",
  md: "text-xl",
  lg: "text-2xl",
};

const ORIGINAL_SIZE: Record<NonNullable<PriceDisplayProps["size"]>, string> = {
  sm: "text-xs",
  md: "text-sm",
  lg: "text-base",
};

export function PriceDisplay({ originalPrice, displayPrice, prefix, size = "md" }: PriceDisplayProps) {
  const hasDiscount = originalPrice != null && originalPrice > displayPrice;

  return (
    <p className="flex flex-wrap items-baseline gap-1.5">
      {prefix && <span className="text-sm text-amber-100">{prefix}</span>}
      {hasDiscount && (
        <span className={`${ORIGINAL_SIZE[size]} text-amber-200/70 line-through`}>
          ₹{originalPrice!.toLocaleString("en-IN")}
        </span>
      )}
      <span className={`${DISPLAY_SIZE[size]} font-bold text-white`}>
        ₹{displayPrice.toLocaleString("en-IN")}
      </span>
    </p>
  );
}
