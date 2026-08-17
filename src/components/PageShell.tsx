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
      style={{ backgroundImage: "url('/backgrounds/beach-illustration.webp')" }}
    >
      <SiteHeader />
      {children}
      <SiteFooter whatsAppHref={footerWhatsAppHref} callHref={footerCallHref} />
      {stickyBar}
    </div>
  );
}
