-- Real Land Casino data import (replaces the placeholder test listing
-- from land-casino-seed.sql). Idempotent: upserts by
-- (activity_category, slug), safe to run twice. No code changes
-- needed — /land-casino and /land-casino/[slug] already render
-- through the standard shared tiered templates, same pattern as Boat
-- Casino, producing "Hi Mapscape, I would like to book [Name] -
-- [Tier]." for each tier's own Book Now button.
--
-- Only one casino in the sheet (Atlantiz Casino), but with 4 named
-- package groups (Diamond/Emerald/Ruby/Non-Gaming) rather than 3 flat
-- packages. Per instruction, all 7 priced items are flattened into 7
-- tiers with the group name folded into each tier's own name, instead
-- of 3 generic tiers — the shared PricingSection has no concept of
-- group headers, so this is the closest faithful representation.
-- "OTPC" (One-Time Play Coupons) is the sheet's own term, kept as-is.
-- No vendor/operator name beyond the casino's own name.

update public.activities
set image_urls = array[
  '/activities/land-casino/category-1.webp',
  '/activities/land-casino/category-2.webp',
  '/activities/land-casino/category-3.webp',
  '/activities/land-casino/category-4.webp',
  '/activities/land-casino/category-5.webp'
]
where slug = 'land-casino';

insert into public.listings (
  activity_category, slug, name, description, overview_points, photos,
  location_address, location_lat, location_lng,
  quick_answers, pricing_type, pricing_data, contact_type, is_active
)
values (
  'land-casino', 'atlantiz-casino', 'Atlantiz Casino',
  'Atlantiz Casino offers a complete nightlife and gaming experience where all standard entry packages include a combination of food, drinks, and live entertainment alongside casino floor access. The venue provides tiered entry options catering to casual visitors, couples, and high-rollers, with One-Time Play Coupons (OTPC) bundled directly into the admission price.',
  '[]'::jsonb,
  array[
    '/activities/land-casino/atlantiz-casino-1.webp',
    '/activities/land-casino/atlantiz-casino-2.webp',
    '/activities/land-casino/atlantiz-casino-3.webp',
    '/activities/land-casino/atlantiz-casino-4.webp',
    '/activities/land-casino/atlantiz-casino-5.webp'
  ],
  'Calangute, Goa', null, null,
  '[]'::jsonb,
  'tiered',
  '[
    {"tier_name": "Diamond - ₹10,000 Tier", "description": "Includes 13,000 OTPC and unlimited premium drinks.", "price": {"display_price": 10000}},
    {"tier_name": "Diamond - ₹7,000 Tier", "description": "Includes 10,000 OTPC and unlimited premium drinks.", "price": {"display_price": 7000}},
    {"tier_name": "Emerald - Stag", "description": "Includes 2,000 OTPC and 6 drink coupons.", "price": {"display_price": 3000}},
    {"tier_name": "Emerald - Couple", "description": "Includes 3,000 OTPC and 8 drink coupons.", "price": {"display_price": 6000}},
    {"tier_name": "Ruby Stag", "description": "Includes 1,000 OTPC and 2 drink coupons.", "price": {"display_price": 2000}},
    {"tier_name": "Youth Package", "description": "Includes food and non-alcoholic beverages.", "price": {"display_price": 1000}},
    {"tier_name": "Kids Entry (7+)", "description": "Restaurant access only, no gaming.", "price": {"display_price": 1000}}
  ]'::jsonb,
  'land', true
)
on conflict (activity_category, slug) do update set
  name = excluded.name,
  description = excluded.description,
  overview_points = excluded.overview_points,
  photos = excluded.photos,
  location_address = excluded.location_address,
  location_lat = excluded.location_lat,
  location_lng = excluded.location_lng,
  quick_answers = excluded.quick_answers,
  pricing_type = excluded.pricing_type,
  pricing_data = excluded.pricing_data,
  contact_type = excluded.contact_type,
  is_active = excluded.is_active;
