import type { NextConfig } from "next";

const STATIC_IMAGE_CACHE_HEADERS = [
  { key: "Cache-Control", value: "public, max-age=31536000, immutable" },
];

const nextConfig: NextConfig = {
  async headers() {
    return [
      { source: "/attractions/:path*", headers: STATIC_IMAGE_CACHE_HEADERS },
      { source: "/backgrounds/:path*", headers: STATIC_IMAGE_CACHE_HEADERS },
    ];
  },
};

export default nextConfig;
