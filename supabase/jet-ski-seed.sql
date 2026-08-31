-- New Jet Ski category, using the existing shared Level 2/Level 3 templates
-- unchanged. Only one placeholder test listing — real vendor data (multiple
-- vendors, different locations/prices) to be provided separately once
-- confirmed working.
-- Run this once in the Supabase SQL Editor against the live database.

insert into public.activities (name, slug, category, description, is_active)
values (
  'Jet Ski',
  'jet-ski',
  'water',
  'Race across the waves on a jet ski — a quick, high-energy way to get out on the water in Goa.',
  true
);

insert into public.listings (
  activity_category, slug, name, description, overview_points, photos,
  location_address, location_lat, location_lng,
  quick_answers, pricing_type, pricing_data, contact_type, is_active
)
values (
  'jet-ski',
  'sample-jet-ski',
  '[TEST] Sample Jet Ski Ride',
  'A placeholder jet ski listing used to verify the single-price layout with discount pricing. Replace with real vendor data once confirmed.',
  '[
    "15-minute ride",
    "Life jacket and safety briefing included",
    "Minimum age: 8 years (with an adult)",
    "Solo or tandem (2 riders) available"
  ]'::jsonb,
  '{}',
  'Calangute Beach, Goa',
  15.5494,
  73.7535,
  '[
    {"label": "Capacity", "value": "Solo or tandem (2 riders)"},
    {"label": "Group Friendly", "value": "Yes"},
    {"label": "Photography", "value": "GoPro footage available"},
    {"label": "Language", "value": "English, Hindi"}
  ]'::jsonb,
  'single',
  '{"price": {"display_price": 1500, "original_price": 1800}}'::jsonb,
  'water',
  true
);
