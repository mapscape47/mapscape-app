-- New Boat & Dinner Cruise category, using the existing shared Level 2/Level 3
-- templates unchanged. Only one placeholder test listing — real vendor
-- data to be provided separately once this is confirmed working.
-- Run this once in the Supabase SQL Editor against the live database.

insert into public.activities (name, slug, category, description, is_active)
values (
  'Boat & Dinner Cruises',
  'boat-cruise',
  'water',
  'Drift along the Mandovi River at sunset or enjoy a full dinner cruise with live music — a relaxed way to see Goa from the water.',
  true
);

insert into public.listings (
  activity_category, slug, name, description, overview_points, photos,
  location_address, location_lat, location_lng,
  quick_answers, pricing_type, pricing_data, contact_type, is_active
)
values (
  'boat-cruise',
  'sample-boat-cruise',
  '[TEST] Sample Boat Cruise',
  'A placeholder boat cruise listing used to verify the tiered pricing layout with discount pricing. Replace with real vendor data once confirmed.',
  '[
    "Live music on board",
    "Sunset views over the Mandovi River",
    "Approx. 2-hour duration",
    "Onboard bar available on the Dinner Cruise"
  ]'::jsonb,
  '{}',
  'Santa Monica Jetty, Panjim, Goa',
  15.4989,
  73.8278,
  '[
    {"label": "Group Friendly", "value": "Yes"},
    {"label": "Photography", "value": "Photographer available on request"},
    {"label": "Language", "value": "English, Hindi"},
    {"label": "Food Included", "value": "Included on Dinner Cruise only"}
  ]'::jsonb,
  'tiered',
  '[
    {
      "tier_name": "Evening Cruise",
      "description": "A relaxed sunset ride along the river, no dinner included.",
      "price": {"display_price": 1800}
    },
    {
      "tier_name": "Dinner Cruise",
      "description": "The full experience — dinner, live music, and sunset views.",
      "price": {"display_price": 2999, "original_price": 3500}
    }
  ]'::jsonb,
  'water',
  true
);
