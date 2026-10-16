-- Real Salon & Spa data import (replaces the placeholder test listing
-- from salon-spa-seed.sql). Idempotent: upserts by
-- (activity_category, slug), safe to run twice.
--
-- Structurally different from how this category was originally built:
-- per instruction, there is no pricing (no priced service menu exists
-- yet — a PDF will be uploaded later, menu_pdf_url is left null for
-- now and the Menu section simply won't render until it's set). This
-- reuses the Restaurants/Cafe "informational, no pricing" pattern
-- (RestaurantListPageView for the Level 2 cards) plus a new
-- SalonSpaDetailPageView for Level 3, which shows one Location card
-- per real-world branch (4 for Anriz, 3 for KNS) instead of a single
-- address, since one listing covers several branches. Branch map
-- links are carried as quick_answers entries labeled "Branch: <name>"
-- (filtered out of the normal Quick Answers display and rendered as
-- Get Directions buttons instead) — see SalonSpaDetailPageView.tsx.
--
-- Names: "Anriz Salon &  Nail Studio" (double space in the sheet)
-- cleaned to "Anriz Salon & Nail Studio". "KNS | Katusha Nail Studio"
-- kept exactly as the sheet has it, per instruction. No vendor name
-- beyond each salon's own brand name.

update public.activities
set image_urls = array[
  '/activities/salon-spa/category-1.webp',
  '/activities/salon-spa/category-2.webp',
  '/activities/salon-spa/category-3.webp',
  '/activities/salon-spa/category-4.webp',
  '/activities/salon-spa/category-5.webp'
]
where slug = 'salon-spa';

insert into public.listings (
  activity_category, slug, name, description, overview_points, photos,
  quick_answers, pricing_type, pricing_data, contact_type, is_active
)
values
  (
    'salon-spa', 'anriz-salon-nail-studio', 'Anriz Salon & Nail Studio',
    'A premium beauty and nail care destination offering professional salon services and expert nail artistry. With convenient branches across Candolim, Calangute, Arpora, and Siolim, it provides an accessible spot for travelers looking to refresh and unwind during their trip.',
    '["Comprehensive Beauty Hub: Serves as a full-service premium salon offering everything from basic manicures and beard styling to advanced treatments like Nanoplastia hair restoration and Microblading.", "Premium Nail Spa: Features dedicated nail aesthetics, including premium manicures, spa pedicures, and custom nail extensions.", "Accessibility: With multiple branches across North Goa''s most popular tourist belts, it provides an easily accessible luxury grooming experience for travelers wanting to freshen up during their vacation."]'::jsonb,
    array[
      '/activities/salon-spa/anriz-salon-nail-studio-1.webp',
      '/activities/salon-spa/anriz-salon-nail-studio-2.webp',
      '/activities/salon-spa/anriz-salon-nail-studio-3.webp',
      '/activities/salon-spa/anriz-salon-nail-studio-4.webp',
      '/activities/salon-spa/anriz-salon-nail-studio-5.webp'
    ],
    '[
      {"label": "Timings", "value": "10:00 AM to 10:00 PM daily (select branches open until 11:00 PM)"},
      {"label": "Services", "value": "Advanced Hair Care, Nail Extensions, Skin Treatments, and Bridal Grooming"},
      {"label": "Branch: Candolim", "value": "https://maps.app.goo.gl/ZCxP21HpjwyBoi1o8"},
      {"label": "Branch: Calangute", "value": "https://maps.app.goo.gl/HjipbRAw8wiryCuK8"},
      {"label": "Branch: Arpora", "value": "https://maps.app.goo.gl/6itZgoznrpf3XS4u5"},
      {"label": "Branch: Siolim", "value": "https://maps.app.goo.gl/RkLvy35mBMG3zFtbA"}
    ]'::jsonb,
    'single', '{"price": {"display_price": 0}}'::jsonb, 'land', true
  ),
  (
    'salon-spa', 'kns-katusha-nail-studio', 'KNS | Katusha Nail Studio',
    'Specializing in high-quality nail aesthetics, KNS provides detailed nail art, extensions, and premium grooming services for a polished vacation look. They operate multiple studios to serve tourists and locals alike, with locations in Arpora, Panjim, and Margao.',
    '["Specialized Nail Artistry: Focuses heavily on high-end, detailed nail art, offering advanced techniques like Airbrush Nail Art and textured 3D Nail Art designs.", "Nail Health & Repair: Goes beyond basic aesthetics by providing dedicated nail repair treatments, acrylic fills, broken nail fixes, and UV protection therapy.", "Professional Care: Known for highly skilled technicians offering meticulous cuticle care, shaping, and buffing, ensuring a flawless and long-lasting vacation look."]'::jsonb,
    array[
      '/activities/salon-spa/kns-katusha-nail-studio-1.webp',
      '/activities/salon-spa/kns-katusha-nail-studio-2.webp',
      '/activities/salon-spa/kns-katusha-nail-studio-3.webp',
      '/activities/salon-spa/kns-katusha-nail-studio-4.webp',
      '/activities/salon-spa/kns-katusha-nail-studio-5.webp'
    ],
    '[
      {"label": "Timings", "value": "10:00 AM to 9:00 PM"},
      {"label": "Services", "value": "Specialized Nail Aesthetics, Acrylic Extensions, and Nail Health Therapy"},
      {"label": "Branch: Arpora", "value": "https://maps.app.goo.gl/vKHncEvkNBP87XEQ7"},
      {"label": "Branch: Panjim", "value": "https://maps.app.goo.gl/iiFdBHK1mLGV9mkD9"},
      {"label": "Branch: Margao", "value": "https://maps.app.goo.gl/KWqjrf4XFT5GMwhv6"}
    ]'::jsonb,
    'single', '{"price": {"display_price": 0}}'::jsonb, 'land', true
  )
on conflict (activity_category, slug) do update set
  name = excluded.name,
  description = excluded.description,
  overview_points = excluded.overview_points,
  photos = excluded.photos,
  quick_answers = excluded.quick_answers,
  pricing_type = excluded.pricing_type,
  pricing_data = excluded.pricing_data,
  contact_type = excluded.contact_type,
  is_active = excluded.is_active;
