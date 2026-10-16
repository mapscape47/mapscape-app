-- Real Boat Cruise data import (replaces the placeholder test listing
-- from boat-cruise-seed.sql). Idempotent: upserts by
-- (activity_category, slug), safe to run twice.
--
-- No code changes required — /boat-cruise and /boat-cruise/[slug]
-- already render through the standard shared
-- CategoryPageView/ListingPageView, the identical tiered pattern used
-- by Yacht/Boat Casino/Land Casino, and pricing_type "tiered" already
-- produces "Hi Mapscape, I would like to book [Name] - [Tier]." for
-- each tier's own Book Now button.
--
-- "Nirvana Dinner cruise" / "Swastik Dinner cruise" normalized to
-- "...Dinner Cruise" for consistent capitalization with the other 3.
-- location_address uses "Panjim Jetty, Goa" for all 5 (the shared
-- boarding point from Details at a Glance), including Swastik, whose
-- own home base (Betim) differs from where passengers board.
-- No discount pricing in the sheet (each tier is a flat price). No
-- Capacity field exists in the sheet, so nothing of the sort is
-- rendered. No vendor/operator name beyond each cruise's own name.

update public.activities
set image_urls = array[
  '/activities/boat-cruise/category-1.webp',
  '/activities/boat-cruise/category-2.webp',
  '/activities/boat-cruise/category-3.webp',
  '/activities/boat-cruise/category-4.webp',
  '/activities/boat-cruise/category-5.webp'
]
where slug = 'boat-cruise';

insert into public.listings (
  activity_category, slug, name, description, overview_points, photos,
  location_address, location_lat, location_lng,
  quick_answers, pricing_type, pricing_data, contact_type, is_active
)
values
  (
    'boat-cruise', 'coral-queen', 'Coral Queen Dinner Cruise',
    'An evening cruise on the Mandovi River featuring a full dinner buffet, unlimited drinks, and live music with dance performances — a complete night out on the water in Goa''s capital.',
    '["Hotel pickup & drop included", "Full dinner buffet + unlimited beer, whiskey, rum & soft drinks", "Live DJ music & dance floor", "Live Goan/Bollywood dance performances", "River views of Panjim''s skyline"]'::jsonb,
    array['/activities/boat-cruise/coral-queen-1.webp', '/activities/boat-cruise/coral-queen-2.webp', '/activities/boat-cruise/coral-queen-3.webp', '/activities/boat-cruise/coral-queen-4.webp', '/activities/boat-cruise/coral-queen-5.webp'],
    'Panjim Jetty, Goa', null, null,
    '[{"label": "Group Friendly", "value": "Yes"}, {"label": "Photography", "value": "Allowed"}, {"label": "Language", "value": "English, Hindi"}, {"label": "Facilities", "value": "Separate washrooms, open deck seating"}]'::jsonb,
    'tiered',
    '[
      {"tier_name": "Evening Cruise", "description": "A relaxed river cruise with music, dance, and live performances.", "price": {"display_price": 600}},
      {"tier_name": "Dinner Cruise", "description": "Everything in the Evening Cruise, plus a full dinner buffet, unlimited drinks, and hotel pickup & drop.", "price": {"display_price": 1600}}
    ]'::jsonb,
    'water', true
  ),
  (
    'boat-cruise', 'nirvana', 'Nirvana Dinner Cruise',
    'An evening cruise on the Mandovi River with a full dinner buffet, unlimited drinks, and live music with dance performances — a relaxed night out on the water in Goa''s capital.',
    '["Hotel pickup & drop included", "Full dinner buffet + unlimited beer, whiskey, rum & soft drinks", "Live DJ music & dance floor", "Live Goan/Bollywood dance performances", "River views of Panjim''s skyline"]'::jsonb,
    array['/activities/boat-cruise/nirvana-1.webp', '/activities/boat-cruise/nirvana-2.webp', '/activities/boat-cruise/nirvana-3.webp', '/activities/boat-cruise/nirvana-4.webp', '/activities/boat-cruise/nirvana-5.webp'],
    'Panjim Jetty, Goa', null, null,
    '[{"label": "Group Friendly", "value": "Yes"}, {"label": "Photography", "value": "Allowed"}, {"label": "Language", "value": "English, Hindi"}]'::jsonb,
    'tiered',
    '[
      {"tier_name": "Evening Cruise", "description": "A relaxed river cruise with music, dance, and live performances.", "price": {"display_price": 600}},
      {"tier_name": "Dinner Cruise", "description": "Everything in the Evening Cruise, plus a full dinner buffet, unlimited drinks, and hotel pickup & drop.", "price": {"display_price": 1700}}
    ]'::jsonb,
    'water', true
  ),
  (
    'boat-cruise', 'princesca', 'Princesca Dinner Cruise',
    'An evening cruise on the Mandovi River with a full dinner buffet, unlimited drinks, and live music with dance performances — a relaxed night out on the water in Goa''s capital.',
    '["Hotel pickup & drop included", "Full dinner buffet + unlimited beer, whiskey, rum & soft drinks", "Live DJ music & dance floor", "Live Goan/Bollywood dance performances", "River views of Panjim''s skyline"]'::jsonb,
    array['/activities/boat-cruise/princesca-1.webp', '/activities/boat-cruise/princesca-2.webp', '/activities/boat-cruise/princesca-3.webp', '/activities/boat-cruise/princesca-4.webp', '/activities/boat-cruise/princesca-5.webp'],
    'Panjim Jetty, Goa', null, null,
    '[{"label": "Group Friendly", "value": "Yes"}, {"label": "Photography", "value": "Allowed"}, {"label": "Language", "value": "English, Hindi"}]'::jsonb,
    'tiered',
    '[
      {"tier_name": "Evening Cruise", "description": "A relaxed river cruise with music, dance, and live performances.", "price": {"display_price": 600}},
      {"tier_name": "Dinner Cruise", "description": "Everything in the Evening Cruise, plus a full dinner buffet, unlimited drinks, and hotel pickup & drop.", "price": {"display_price": 1900}}
    ]'::jsonb,
    'water', true
  ),
  (
    'boat-cruise', 'paradise', 'Paradise Dinner Cruise',
    'An evening cruise on the Mandovi River with a full dinner buffet, unlimited drinks, and live music with dance performances — a relaxed night out on the water in Goa''s capital.',
    '["Hotel pickup & drop included", "Full dinner buffet + unlimited beer, whiskey, rum & soft drinks", "Live DJ music & dance floor", "Live Goan/Bollywood dance performances", "River views of Panjim''s skyline"]'::jsonb,
    array['/activities/boat-cruise/paradise-1.webp', '/activities/boat-cruise/paradise-2.webp', '/activities/boat-cruise/paradise-3.webp', '/activities/boat-cruise/paradise-4.webp', '/activities/boat-cruise/paradise-5.webp'],
    'Panjim Jetty, Goa', null, null,
    '[{"label": "Group Friendly", "value": "Yes"}, {"label": "Photography", "value": "Allowed"}, {"label": "Language", "value": "English, Hindi"}]'::jsonb,
    'tiered',
    '[
      {"tier_name": "Evening Cruise", "description": "A relaxed river cruise with music, dance, and live performances.", "price": {"display_price": 600}},
      {"tier_name": "Dinner Cruise", "description": "Everything in the Evening Cruise, plus a full dinner buffet, unlimited drinks, and hotel pickup & drop.", "price": {"display_price": 1800}}
    ]'::jsonb,
    'water', true
  ),
  (
    'boat-cruise', 'swastik', 'Swastik Dinner Cruise',
    'An evening cruise on the Mandovi River with a full dinner buffet, unlimited drinks, and live music with dance performances — a relaxed night out on the water in Goa''s capital.',
    '["Hotel pickup & drop included", "Full dinner buffet + unlimited beer, whiskey, rum & soft drinks", "Live DJ music & dance floor", "Live Goan/Bollywood dance performances", "River views of Panjim''s skyline"]'::jsonb,
    array['/activities/boat-cruise/swastik-1.webp', '/activities/boat-cruise/swastik-2.webp', '/activities/boat-cruise/swastik-3.webp', '/activities/boat-cruise/swastik-4.webp', '/activities/boat-cruise/swastik-5.webp'],
    'Panjim Jetty, Goa', null, null,
    '[{"label": "Group Friendly", "value": "Yes"}, {"label": "Photography", "value": "Allowed"}, {"label": "Language", "value": "English, Hindi"}]'::jsonb,
    'tiered',
    '[
      {"tier_name": "Evening Cruise", "description": "A relaxed river cruise with music, dance, and live performances.", "price": {"display_price": 500}},
      {"tier_name": "Dinner Cruise", "description": "Everything in the Evening Cruise, plus a full dinner buffet, unlimited drinks, and hotel pickup & drop.", "price": {"display_price": 1000}}
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
