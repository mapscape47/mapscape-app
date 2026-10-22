import Image from "next/image";
import { WhatsAppIcon } from "./WhatsAppIcon";
import { PhoneIcon } from "./PhoneIcon";
import { EmailIcon, InstagramIcon, FacebookIcon, YouTubeIcon, LinkedInIcon } from "./SocialIcons";

// "Blogs" and "Offers" are left out rather than linked to placeholder
// pages — neither feature exists yet, so there's nothing real to link to.
const STATIC_QUICK_LINKS = [
  { label: "Privacy Policy", href: "#" },
  { label: "Terms of Use", href: "#" },
];

const SOCIAL_LINKS = [
  {
    label: "Instagram",
    href: "https://www.instagram.com/map_scape_",
    Icon: InstagramIcon,
  },
  {
    label: "Facebook",
    href: "https://www.facebook.com/share/1BppyfX4RY/?mibextid=wwXIfr",
    Icon: FacebookIcon,
  },
  {
    label: "YouTube",
    href: "https://youtube.com/@mapscape47?si=JcEyFQ6EOkVKCkIn",
    Icon: YouTubeIcon,
  },
  // TODO: no LinkedIn account provided yet — placeholder until one exists
  { label: "LinkedIn", href: "https://linkedin.com", Icon: LinkedInIcon },
];

const CONTACT_NUMBERS = [
  { href: "tel:+917249529389", display: "+91 72495 29389" },
  { href: "tel:+919325427849", display: "+91 93254 27849" },
];

const ADDRESS = "1611/100, Orda, Candolim, Bardez - Goa, Pincode - 403515";

type SiteFooterProps = {
  whatsAppHref: string;
  callHref: string;
  email?: string;
};

export function SiteFooter({
  whatsAppHref,
  callHref,
  email = "mapscape47@gmail.com",
}: SiteFooterProps) {
  // "Contact Us" points at the same WhatsApp conversation as the icon
  // above — the site has no contact form, WhatsApp is the real channel.
  const quickLinks = [
    { label: "About Us", href: "/about" },
    { label: "Contact Us", href: whatsAppHref },
    ...STATIC_QUICK_LINKS,
  ];

  return (
    <footer className="bg-amber-900 px-4 pt-8 pb-8 text-amber-50">
      <div className="mx-auto max-w-lg sm:max-w-2xl">
        <div className="flex items-center gap-2">
          <Image src="/mapscape-logo.webp" alt="Mapscape" width={40} height={40} />
          <span className="font-heading text-lg font-bold text-white">Mapscape</span>
        </div>
        <p className="mt-2 text-sm text-amber-100">Inspiring Travel</p>

        <div className="mt-5 flex gap-3">
          <a
            href={whatsAppHref}
            target="_blank"
            rel="noopener noreferrer"
            aria-label="WhatsApp"
            className="flex h-11 w-11 items-center justify-center rounded-full bg-white/10 text-white transition-colors hover:bg-white/20"
          >
            <WhatsAppIcon />
          </a>
          <a
            href={`mailto:${email}`}
            aria-label="Email"
            className="flex h-11 w-11 items-center justify-center rounded-full bg-white/10 text-white transition-colors hover:bg-white/20"
          >
            <EmailIcon />
          </a>
          <a
            href={callHref}
            aria-label="Call"
            className="flex h-11 w-11 items-center justify-center rounded-full bg-white/10 text-white transition-colors hover:bg-white/20"
          >
            <PhoneIcon />
          </a>
        </div>

        <div className="mt-8">
          <h3 className="text-xs font-semibold uppercase tracking-wider text-emerald-300">
            Contact Details
          </h3>
          <ul className="mt-1 text-sm text-amber-100">
            {CONTACT_NUMBERS.map((contact) => (
              <li key={contact.href}>
                <a href={contact.href} className="inline-block py-3 transition-colors hover:text-white">
                  {contact.display}
                </a>
              </li>
            ))}
            <li>
              <a href={`mailto:${email}`} className="inline-block py-3 transition-colors hover:text-white">
                {email}
              </a>
            </li>
            <li className="py-3">{ADDRESS}</li>
          </ul>
        </div>

        <div className="mt-8 grid grid-cols-2 gap-8">
          <div>
            <h3 className="text-xs font-semibold uppercase tracking-wider text-emerald-300">
              Quick Links
            </h3>
            <ul className="mt-1 text-sm text-amber-100">
              {quickLinks.map((link) => {
                const isExternal = link.href.startsWith("http");
                return (
                  <li key={link.label}>
                    <a
                      href={link.href}
                      target={isExternal ? "_blank" : undefined}
                      rel={isExternal ? "noopener noreferrer" : undefined}
                      className="inline-block py-3 transition-colors hover:text-white"
                    >
                      {link.label}
                    </a>
                  </li>
                );
              })}
            </ul>
          </div>

          <div>
            <h3 className="text-xs font-semibold uppercase tracking-wider text-emerald-300">
              Follow Us
            </h3>
            <div className="mt-3 flex gap-3">
              {SOCIAL_LINKS.map(({ label, href, Icon }) => (
                <a
                  key={label}
                  href={href}
                  target="_blank"
                  rel="noopener noreferrer"
                  aria-label={label}
                  className="flex h-11 w-11 items-center justify-center rounded-full bg-white/10 text-white transition-colors hover:bg-white/20"
                >
                  <Icon className="h-4 w-4" />
                </a>
              ))}
            </div>
          </div>
        </div>

        <div className="mt-8 border-t border-white/10 pt-4">
          <p className="text-center text-xs text-amber-200/85">© 2026 Mapscape. All rights reserved.</p>
        </div>
      </div>
    </footer>
  );
}
