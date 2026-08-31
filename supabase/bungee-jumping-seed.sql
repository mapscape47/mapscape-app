-- New Bungee Jumping category, using the existing shared Level 2/Level 3
-- templates unchanged. Only one placeholder test listing — real vendor
-- data (4 vendors total) to be provided separately once confirmed working.
-- Run this once in the Supabase SQL Editor against the live database.

insert into public.activities (name, slug, category, description, is_active)
values (
  'Bungee Jumping',
  'bungee-jumping',
  'land',
  'Take the leap on Goa''s tallest bungee jump — a quick adrenaline rush with certified safety gear and trained crew.',
  true
);

insert into public.listings (
  activity_category, slug, name, description, overview_points, photos,
  location_address, location_lat, location_lng,
  quick_answers, pricing_type, pricing_data, contact_type, is_active
)
values (
  'bungee-jumping',
  'sample-bungee-jump',
  '[TEST] Sample Bungee Jump',
  'A placeholder bungee jumping listing used to verify the single-price layout with discount pricing. Replace with real vendor data once confirmed.',
  '[
    "55-meter jump height",
    "Certified safety equipment and trained crew",
    "Weight limit: 40-110 kg",
    "Minimum age: 12 years"
  ]'::jsonb,
  '{}',
  'Baga, Goa',
  15.5553,
  73.7517,
  '[
    {"label": "Capacity", "value": "1 jumper at a time"},
    {"label": "Group Friendly", "value": "Yes"},
    {"label": "Photography", "value": "GoPro footage available"},
    {"label": "Language", "value": "English, Hindi"}
  ]'::jsonb,
  'single',
  '{"price": {"display_price": 1999, "original_price": 2500}}'::jsonb,
  'land',
  true
);
