-- Real Wakeboard Surfing data import (replaces the placeholder test
-- listing from wakeboard-surfing-seed.sql). Idempotent: upserts by
-- (activity_category, slug), safe to run twice.
--
-- No code changes required — /wakeboard-surfing and
-- /wakeboard-surfing/[slug] already render through the standard shared
-- CategoryPageView/ListingPageView, and pricing_type "multi_service"
-- already produces "Hi Mapscape, I would like to book [Service] at
-- [Listing]." for each service's own Book Now button (kept as-is, same
-- format already live for Salon & Spa).
--
-- Vendor name removed: the source sheet's description names the real
-- operator ("101 Wakepark in Arambol is Goa's go-to spot...") — reworded
-- below to describe the spot without naming it.
-- No discount pricing in the sheet — every service is a single price.

-- Level 2 category photos (slider on /wakeboard-surfing).
update public.activities
set image_urls = array[
  '/activities/wakeboard-surfing/category-1.webp',
  '/activities/wakeboard-surfing/category-2.webp',
  '/activities/wakeboard-surfing/category-3.webp',
  '/activities/wakeboard-surfing/category-4.webp',
  '/activities/wakeboard-surfing/category-5.webp'
]
where slug = 'wakeboard-surfing';

insert into public.listings (
  activity_category, slug, name, description, overview_points, photos,
  location_address, location_lat, location_lng,
  quick_answers, pricing_type, pricing_data, contact_type, is_active
)
values (
  'wakeboard-surfing',
  'arambol-surfing',
  'Arambol Surfing',
  'A cable wakeboarding spot in Arambol built around a custom lake, offering everything from short joyride sessions to a full beginner-to-pro training bootcamp.',
  '["Beginner-friendly — no swimming experience required", "Coached sessions with structured progression", "Multiple ride formats — casual, strap board, boots board", "Stand up paddleboard rentals also available", "Chill, community vibe with music & bonfire hangouts"]'::jsonb,
  array[
    '/activities/wakeboard-surfing/arambol-surfing-1.webp',
    '/activities/wakeboard-surfing/arambol-surfing-2.webp',
    '/activities/wakeboard-surfing/arambol-surfing-3.webp',
    '/activities/wakeboard-surfing/arambol-surfing-4.webp',
    '/activities/wakeboard-surfing/arambol-surfing-5.webp'
  ],
  'Arambol, Goa', null, null,
  '[{"label": "Group Friendly", "value": "Yes"}, {"label": "Photography & Drone Photography", "value": "Allowed"}, {"label": "Language", "value": "English, Hindi"}]'::jsonb,
  'multi_service',
  '[
    {"service_name": "10-Min Ride (Strap Board)", "price": {"display_price": 700}},
    {"service_name": "10-Min Ride (Boots Board)", "price": {"display_price": 1000}},
    {"service_name": "Fun Body Drag (3 drags, no board)", "price": {"display_price": 300}},
    {"service_name": "Stand Up Paddle Board Rental (30 min)", "price": {"display_price": 300}},
    {"service_name": "Stand Up Paddle Board Rental (60 min)", "price": {"display_price": 500}},
    {"service_name": "Ice Bath / Cold Water Plunge", "price": {"display_price": 2000}},
    {"service_name": "Wakeboarding From Zero (Beginner Package) — per person", "price": {"display_price": 3250}},
    {"service_name": "Wakeboarding Membership (10 x 10-min rides)", "price": {"display_price": 6000}},
    {"service_name": "3-Day Wakeboarding Bootcamp (all-inclusive)", "price": {"display_price": 15000}}
  ]'::jsonb,
  'water', true
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
