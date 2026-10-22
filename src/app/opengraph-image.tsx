import { ImageResponse } from "next/og";

export const alt = "Mapscape — Inspiring Travel in Goa";
export const size = { width: 1200, height: 630 };
export const contentType = "image/png";

export default function Image() {
  return new ImageResponse(
    (
      <div
        style={{
          width: "100%",
          height: "100%",
          display: "flex",
          flexDirection: "column",
          alignItems: "center",
          justifyContent: "center",
          background: "#78350f",
        }}
      >
        <div style={{ fontSize: 120, fontWeight: 700, color: "#ffffff", display: "flex" }}>
          Mapscape
        </div>
        <div style={{ marginTop: 20, fontSize: 40, color: "#fde68a", display: "flex" }}>
          Inspiring Travel in Goa
        </div>
      </div>
    ),
    { ...size }
  );
}
