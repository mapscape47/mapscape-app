-- Real Boat Trip data import (replaces the placeholder test listing
-- from boat-trip-seed.sql). Idempotent: upserts by
-- (activity_category, slug), safe to run twice.
--
-- No code changes required — /boat-trip and /boat-trip/dolphin-trip
-- already render through the standard shared
-- CategoryPageView/ListingPageView, and pricing_type "single" already
-- produces "Hi Mapscape, I would like to book Dolphin Trip." (no tier
-- suffix, since tier_name is left unset below).
--
-- No discount pricing in the sheet — one flat price. The duration
-- ("45-60 minute boat ride") is folded into the description rather
-- than kept as a highlight bullet, per instruction; "Best Time" stays
-- a Quick Answer. This listing's photos also serve as the Level 2
-- category slider (no separate generic photo set exists for this
-- category, same as Waterfall).

update public.activities
set image_urls = array[
  '/activities/boat-trip/dolphin-trip-1.webp',
  '/activities/boat-trip/dolphin-trip-2.webp',
  '/activities/boat-trip/dolphin-trip-3.webp',
  '/activities/boat-trip/dolphin-trip-4.webp',
  '/activities/boat-trip/dolphin-trip-5.webp'
]
where slug = 'boat-trip';

insert into public.listings (
  activity_category, slug, name, description, overview_points, photos,
  location_address, location_lat, location_lng,
  quick_answers, pricing_type, pricing_data, contact_type, is_active
)
values (
  'boat-trip',
  'dolphin-trip',
  'Dolphin Trip',
  'A short, 45-60 minute boat ride from Siquerim into the Arabian Sea, with a good chance of spotting Goa''s wild dolphin pods along the way. Relaxed and family-friendly, no experience needed.',
  '["High chance of spotting wild dolphins in their natural habitat", "Life jackets provided for all passengers", "Great for families and first-time sea-goers", "Scenic views of the Goan coastline along the way"]'::jsonb,
  array[
    '/activities/boat-trip/dolphin-trip-1.webp',
    '/activities/boat-trip/dolphin-trip-2.webp',
    '/activities/boat-trip/dolphin-trip-3.webp',
    '/activities/boat-trip/dolphin-trip-4.webp',
    '/activities/boat-trip/dolphin-trip-5.webp'
  ],
  'Siquerim, Goa', null, null,
  '[{"label": "Group Friendly", "value": "Yes"}, {"label": "Photography", "value": "Allowed"}, {"label": "Language", "value": "English, Hindi"}, {"label": "Best Time", "value": "Early morning (higher dolphin activity)"}]'::jsonb,
  'single',
  '{"price": {"display_price": 400}}'::jsonb,
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
