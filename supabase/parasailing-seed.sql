-- New Parasailing category, using the existing shared Level 2/Level 3
-- templates unchanged. Only one placeholder test listing — real vendor
-- data (multiple vendors, different locations/prices) to be provided
-- separately once confirmed working.
-- Run this once in the Supabase SQL Editor against the live database.

insert into public.activities (name, slug, category, description, is_active)
values (
  'Parasailing',
  'parasailing',
  'water',
  'Soar above the Goan coastline strapped to a parachute, towed by speedboat — one of the best views the beach has to offer.',
  true
);

insert into public.listings (
  activity_category, slug, name, description, overview_points, photos,
  location_address, location_lat, location_lng,
  quick_answers, pricing_type, pricing_data, contact_type, is_active
)
values (
  'parasailing',
  'sample-parasailing',
  '[TEST] Sample Parasailing Flight',
  'A placeholder parasailing listing used to verify the single-price layout with discount pricing. Replace with real vendor data once confirmed.',
  '[
    "5-8 minute flight time",
    "Flies up to 150 feet above the water",
    "Safety harness and life jacket included",
    "Weight limit: 40-100 kg"
  ]'::jsonb,
  '{}',
  'Baga Beach, Goa',
  15.5552,
  73.7517,
  '[
    {"label": "Capacity", "value": "1 rider per flight"},
    {"label": "Group Friendly", "value": "Yes"},
    {"label": "Photography", "value": "GoPro footage available"},
    {"label": "Language", "value": "English, Hindi"}
  ]'::jsonb,
  'single',
  '{"price": {"display_price": 1699, "original_price": 2000}}'::jsonb,
  'water',
  true
);
