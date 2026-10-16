-- Real Waterfall data import (replaces the placeholder test listing
-- from waterfall-seed.sql). Idempotent: upserts by
-- (activity_category, slug), safe to run twice.
--
-- No code changes required — /waterfall and /waterfall/dudhsagar
-- already render through the standard shared
-- CategoryPageView/ListingPageView, and pricing_type "single" already
-- produces "Hi Mapscape, I would like to book [Name]." (no tier
-- suffix, since tier_name is left unset below).
--
-- No discount pricing in the sheet — one flat price. Name normalized
-- from the sheet's "DudhSagar Waterfall" to "Dudhsagar Waterfall" to
-- match the existing category description text. The "per person" /
-- "includes all travel expenses" price notes have nowhere to render
-- inside the single-price Pricing & Booking card, so they're folded
-- into a Quick Answer instead of being dropped. This single listing's
-- 5 photos also serve as the Level 2 category slider (no separate
-- generic photo set exists for this category, same as Boat Trip).

update public.activities
set image_urls = array[
  '/activities/waterfall/dudhsagar-1.webp',
  '/activities/waterfall/dudhsagar-2.webp',
  '/activities/waterfall/dudhsagar-3.webp',
  '/activities/waterfall/dudhsagar-4.webp',
  '/activities/waterfall/dudhsagar-5.webp'
]
where slug = 'waterfall';

insert into public.listings (
  activity_category, slug, name, description, overview_points, photos,
  location_address, location_lat, location_lng,
  quick_answers, pricing_type, pricing_data, contact_type, is_active
)
values (
  'waterfall',
  'dudhsagar',
  'Dudhsagar Waterfall',
  'Dudhsagar Waterfall is one of India''s tallest waterfalls, cascading nearly 320 meters through the forests of Mollem. A jeep safari takes you to its base, where you can swim in the natural pools below.',
  '["Approx. 320m tall — one of India''s highest waterfalls", "Jeep safari through Bhagwan Mahavir Wildlife Sanctuary included", "Swimming at the base pool (season permitting)", "Best visited November to June", "Located inside Mollem National Park"]'::jsonb,
  array[
    '/activities/waterfall/dudhsagar-1.webp',
    '/activities/waterfall/dudhsagar-2.webp',
    '/activities/waterfall/dudhsagar-3.webp',
    '/activities/waterfall/dudhsagar-4.webp',
    '/activities/waterfall/dudhsagar-5.webp'
  ],
  'Mollem, Goa', null, null,
  '[{"label": "Group Friendly", "value": "Yes"}, {"label": "Photography", "value": "Allowed"}, {"label": "Language", "value": "English, Hindi"}, {"label": "Best Season", "value": "November to June"}, {"label": "Price Note", "value": "₹2,000 per person, includes all travel expenses"}]'::jsonb,
  'single',
  '{"price": {"display_price": 2000}}'::jsonb,
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
