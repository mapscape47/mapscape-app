-- Real Scuba data import. Idempotent: upserts by (activity_category,
-- slug), safe to run twice. No code changes needed — /scuba and
-- /scuba/[slug] already render through the standard shared
-- CategoryPageView/ListingPageView with single pricing, already
-- producing "Hi Mapscape, I would like to book [Name]." with no tier
-- suffix.
--
-- These 4 rows are separate dive operators, not tiers of one listing
-- (same pattern as Kayaking's 3 spots or Quad Biking's 2). Only one
-- (Scuba Evolution India) has real photos in the source — the other 3
-- have none, so their slider falls back to the placeholder gradient
-- until real photos are provided, same as any listing without photos.
-- "Scuba Evolution India" used as the full name (not the sheet's
-- shorter "Scuba Evolution") per your confirmation. "Details at a
-- Glance" in the sheet is prose, not label/value pairs, so each is
-- folded into a single "What's Included" Quick Answer rather than
-- inventing structure that isn't there. No discount pricing anywhere.
-- PADI/Scubapro mentions are third-party certification/equipment
-- brands (not a hidden operator), left as-is.
--
-- The old placeholder "Full-Day Dive" listing doesn't match any real
-- operator here and is deactivated per your confirmation.

update public.activities
set image_urls = array[
  '/activities/scuba/category-1.webp',
  '/activities/scuba/category-2.webp',
  '/activities/scuba/category-3.webp',
  '/activities/scuba/category-4.webp',
  '/activities/scuba/category-5.webp'
]
where slug = 'scuba';

update public.listings
set is_active = false
where activity_category = 'scuba' and slug = 'full-day-dive';

insert into public.listings (
  activity_category, slug, name, description, overview_points, photos,
  area_name,
  quick_answers, pricing_type, pricing_data, contact_type, is_active
)
values
  (
    'scuba', 'goa-diving', 'Goa Diving',
    'Operating since the 1990s, Goa Diving is a pioneer of scuba in the region. Located on the quiet Bogmalo beach, this center offers a highly authentic, no-frills diving experience to nearby dive sites like Grande Island and local shipwrecks, making it an excellent budget-friendly choice guided by local veterans.',
    '["One of the oldest and most established dive centers in Goa", "Operates directly from Bogmalo beach", "Explores local shipwrecks and coral patches"]'::jsonb,
    array[]::text[],
    'Bogmalo',
    '[{"label": "What''s Included", "value": "Basic equipment and a quick shallow-water briefing — a great entry-level option for budget-conscious travelers wanting a straightforward island dive"}]'::jsonb,
    'single',
    '{"price": {"display_price": 2500}}'::jsonb,
    'water', true
  ),
  (
    'scuba', 'goa-aquatics', 'Goa Aquatics',
    'Situated conveniently in Calangute, Goa Aquatics is a highly reliable mid-tier PADI dive center. They focus heavily on beginner safety and provide a seamless full-day island excursion. With their own fleet of boats and dedicated underwater cameras, guests get a fantastic, professionally guided experience and high-quality memories to take home.',
    '["PADI-certified instructors", "High-quality underwater photography and videography included", "Operates its own well-maintained boats"]'::jsonb,
    array[]::text[],
    'Calangute',
    '[{"label": "What''s Included", "value": "Full-day trip (usually 8:00 AM to 3:00 PM) including boat transit to Grande Island, snacks, and a 20-minute ocean dive"}]'::jsonb,
    'single',
    '{"price": {"display_price": 3000}}'::jsonb,
    'water', true
  ),
  (
    'scuba', 'dive-goa', 'Dive Goa',
    'Dive Goa is widely considered one of the most professional dive operations in the state. By strictly enforcing a 1:1 instructor ratio and requiring beginners to master breathing in a swimming pool before hitting the ocean, they offer a premium, anxiety-free experience perfect for first-timers who prioritize safety and personalized attention over large crowds.',
    '["PADI 5-Star Instructor Development Center", "Strict 1:1 instructor-to-diver ratio for beginners", "Mandates pool training prior to the ocean dive"]'::jsonb,
    array[]::text[],
    'Odxel',
    '[{"label": "What''s Included", "value": "Premium safety standards, including a confined water (pool) skill session before heading out to the ocean to ensure complete comfort and panic-free diving"}]'::jsonb,
    'single',
    '{"price": {"display_price": 4000}}'::jsonb,
    'water', true
  ),
  (
    'scuba', 'scuba-evolution-india', 'Scuba Evolution India',
    'Scuba Evolution India offers a truly elite diving experience. As a PADI 5-Star Dive Resort, they don''t just take you underwater; they provide the official Discover Scuba Diving program. Featuring custom-built luxury dive boats, top-of-the-line Scubapro equipment, and highly experienced instructors, this is the ultimate choice for tourists wanting a high-end, world-class diving introduction.',
    '["Premier PADI 5-Star Dive Resort", "Utilizes luxury dive boats", "Offers the official PADI Discover Scuba Diving (DSD) program"]'::jsonb,
    array['/activities/scuba/scuba-evolution-india-1.webp', '/activities/scuba/scuba-evolution-india-2.webp', '/activities/scuba/scuba-evolution-india-3.webp', '/activities/scuba/scuba-evolution-india-4.webp', '/activities/scuba/scuba-evolution-india-5.webp'],
    'Candolim',
    '[{"label": "What''s Included", "value": "The most premium beginner dive experience available — full PADI registration, comprehensive classroom briefing, pool session, and a longer, deeper ocean dive"}]'::jsonb,
    'single',
    '{"price": {"display_price": 4500}}'::jsonb,
    'water', true
  )
on conflict (activity_category, slug) do update set
  name = excluded.name,
  description = excluded.description,
  overview_points = excluded.overview_points,
  photos = excluded.photos,
  area_name = excluded.area_name,
  quick_answers = excluded.quick_answers,
  pricing_type = excluded.pricing_type,
  pricing_data = excluded.pricing_data,
  contact_type = excluded.contact_type,
  is_active = excluded.is_active;
