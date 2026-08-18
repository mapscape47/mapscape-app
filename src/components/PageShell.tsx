import type { ReactNode } from "react";
import { SiteHeader } from "./SiteHeader";
import { SiteFooter } from "./SiteFooter";

type PageShellProps = {
  children: ReactNode;
  footerWhatsAppHref: string;
  footerCallHref: string;
  stickyBar?: ReactNode;
};

export function PageShell({
  children,
  footerWhatsAppHref,
  footerCallHref,
  stickyBar,
}: PageShellProps) {
  return (
    <div
      className="relative min-h-screen bg-stone-50 bg-top bg-repeat-y"
      style={{
        backgroundImage: "url('/backgrounds/beach-illustration.webp')",
        backgroundSize: "100% auto",
      }}
    >
      <SiteHeader />
      {children}
      <SiteFooter whatsAppHref={footerWhatsAppHref} callHref={footerCallHref} />
      {/* Clearance so the fixed sticky bar doesn't cover the footer's own content — only needed on pages that render one. */}
      {stickyBar && <div className="h-32 bg-amber-900" aria-hidden="true" />}
      {stickyBar}
    </div>
  );
}
