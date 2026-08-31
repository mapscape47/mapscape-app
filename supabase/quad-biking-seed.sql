-- New Quad Biking category, using the existing shared Level 2/Level 3
-- templates unchanged. Only one placeholder test listing — real vendor
-- data to be provided separately once this is confirmed working.
-- Run this once in the Supabase SQL Editor against the live database.

insert into public.activities (name, slug, category, description, is_active)
values (
  'Quad Biking',
  'quad-biking',
  'land',
  'Tear through Goa''s red-dirt trails on a quad bike — an adrenaline-packed way to explore the countryside, no experience needed.',
  true
);

insert into public.listings (
  activity_category, slug, name, description, overview_points, photos,
  location_address, location_lat, location_lng,
  quick_answers, pricing_type, pricing_data, contact_type, is_active
)
values (
  'quad-biking',
  'sample-quad-trail',
  '[TEST] Sample Quad Trail',
  'A placeholder quad biking listing used to verify the single-price layout with discount pricing. Replace with real vendor data once confirmed.',
  '[
    "Guided trail ride, approx. 45 minutes",
    "Helmet and safety gear included",
    "Minimum age: 12 years",
    "No prior riding experience needed"
  ]'::jsonb,
  '{}',
  'Quad Bike Trail, Moira, Goa',
  15.5613,
  73.8102,
  '[
    {"label": "Capacity", "value": "1 or 2-seater quads available"},
    {"label": "Group Friendly", "value": "Yes"},
    {"label": "Photography", "value": "Available on request"},
    {"label": "Language", "value": "English, Hindi"}
  ]'::jsonb,
  'single',
  '{"price": {"display_price": 1500, "original_price": 2000}}'::jsonb,
  'land',
  true
);
