-- New Kayaking category, using the existing shared Level 2/Level 3 templates
-- unchanged. Only one placeholder test listing — real spot/vendor data
-- (multiple spots, different locations/prices) to be provided separately
-- once confirmed working. The listing name folds in the location (e.g.
-- "at Chapora River") since the shared Level 2 card has no separate
-- location field and the task requires no template changes.
-- Run this once in the Supabase SQL Editor against the live database.

insert into public.activities (name, slug, category, description, is_active)
values (
  'Kayaking',
  'kayaking',
  'water',
  'Paddle through Goa''s calm rivers and backwaters — a peaceful way to explore mangroves and wildlife at your own pace.',
  true
);

insert into public.listings (
  activity_category, slug, name, description, overview_points, photos,
  location_address, location_lat, location_lng,
  quick_answers, pricing_type, pricing_data, contact_type, is_active
)
values (
  'kayaking',
  'sample-kayaking',
  '[TEST] Sample Kayaking at Chapora River',
  'A placeholder kayaking listing used to verify the single-price layout with discount pricing. Replace with real spot/vendor data once confirmed.',
  '[
    "Approx. 5 km route, 1.5 hour paddle",
    "Guided tour or self-paddle available",
    "Life jackets included",
    "Minimum age: 10 years"
  ]'::jsonb,
  '{}',
  'Chapora River, Goa',
  15.6046,
  73.7480,
  '[
    {"label": "Capacity", "value": "Single or double kayaks available"},
    {"label": "Group Friendly", "value": "Yes"},
    {"label": "Photography", "value": "Not included"},
    {"label": "Language", "value": "English, Hindi"}
  ]'::jsonb,
  'single',
  '{"price": {"display_price": 999, "original_price": 1200}}'::jsonb,
  'water',
  true
);
