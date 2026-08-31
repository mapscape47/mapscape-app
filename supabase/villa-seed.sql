-- New Villa category, using the existing shared Level 2/Level 3 templates
-- unchanged. Only one placeholder test listing — real villa data to be
-- provided separately once this is confirmed working.
-- Run this once in the Supabase SQL Editor against the live database.

insert into public.activities (name, slug, category, description, is_active)
values (
  'Villas',
  'villa',
  'land',
  'Private pool villas across Goa for a stay that feels like your own home away from home — space, privacy, and comfort for the whole group.',
  true
);

insert into public.listings (
  activity_category, slug, name, description, overview_points, photos,
  location_address, location_lat, location_lng,
  quick_answers, pricing_type, pricing_data, contact_type, is_active
)
values (
  'villa',
  'sample-villa',
  '[TEST] Sample Villa',
  'A placeholder villa listing used to verify the single-price-per-night layout with discount pricing. Replace with real villa data once confirmed.',
  '[
    "3 Bedrooms",
    "3 Bathrooms",
    "Sleeps up to 6 guests",
    "Private swimming pool",
    "Air conditioning in all rooms",
    "Free WiFi",
    "Fully equipped kitchen",
    "Private parking"
  ]'::jsonb,
  '{}',
  'Assagao, Bardez, Goa',
  15.5928,
  73.7830,
  '[
    {"label": "Group Friendly", "value": "Yes"},
    {"label": "Photography", "value": "Available on request"},
    {"label": "Language", "value": "English, Hindi"},
    {"label": "Food Included", "value": "Not included (self-catered kitchen)"}
  ]'::jsonb,
  'single',
  '{"price": {"display_price": 9500, "original_price": 12000}}'::jsonb,
  'land',
  true
);
