import type { Metadata } from "next";
import { Bitter, Nunito } from "next/font/google";
import { Analytics } from "@vercel/analytics/next";
import "./globals.css";

const bitter = Bitter({
  variable: "--font-bitter",
  subsets: ["latin"],
});

const nunito = Nunito({
  variable: "--font-nunito",
  subsets: ["latin"],
});

export const metadata: Metadata = {
  metadataBase: new URL("https://www.mapscape.in"),
  title: {
    default: "Mapscape — Inspiring Travel in Goa",
    template: "%s | Mapscape",
  },
  description:
    "Discover and book Goa's best water sports, land activities, rentals, nightlife, dining and more — all through Mapscape.",
  robots: { index: true, follow: true },
  openGraph: {
    siteName: "Mapscape",
    type: "website",
    locale: "en_IN",
  },
  twitter: {
    card: "summary_large_image",
  },
};

export default function RootLayout({ children }: LayoutProps<"/">) {
  return (
    <html
      lang="en"
      className={`${bitter.variable} ${nunito.variable} h-full antialiased`}
    >
      <body className="min-h-full flex flex-col">
        {children}
        <Analytics />
      </body>
    </html>
  );
}
