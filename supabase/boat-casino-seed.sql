-- New Boat Casino category, using the existing shared Level 2/Level 3
-- templates unchanged. Only one placeholder test listing — real casino
-- vendor data to be provided separately once this is confirmed working.
-- Run this once in the Supabase SQL Editor against the live database.

insert into public.activities (name, slug, category, description, is_active)
values (
  'Boat Casino',
  'boat-casino',
  'water',
  'Try your luck on a floating casino along the Mandovi River — table games, slots, and a cruise all in one night out.',
  true
);

insert into public.listings (
  activity_category, slug, name, description, overview_points, photos,
  location_address, location_lat, location_lng,
  quick_answers, pricing_type, pricing_data, contact_type, is_active
)
values (
  'boat-casino',
  'sample-boat-casino',
  '[TEST] Sample Boat Casino',
  'A placeholder boat casino listing used to verify the tiered pricing layout with discount pricing. Replace with real vendor data once confirmed.',
  '[
    "Live table games and slot machines onboard",
    "Approx. 2-hour cruise duration",
    "Age requirement: 21+",
    "Smart casual dress code"
  ]'::jsonb,
  '{}',
  'Panjim Jetty, Goa',
  15.4989,
  73.8278,
  '[
    {"label": "Group Friendly", "value": "Yes"},
    {"label": "Language", "value": "English, Hindi"},
    {"label": "Food Included", "value": "Complimentary snacks on Premium and VIP"}
  ]'::jsonb,
  'tiered',
  '[
    {
      "tier_name": "Signature",
      "description": "Entry with welcome chips and access to the main gaming deck.",
      "price": {"display_price": 1800}
    },
    {
      "tier_name": "Premium",
      "description": "Entry with higher welcome chips, complimentary snacks, and a reserved table.",
      "price": {"display_price": 3800, "original_price": 4200}
    },
    {
      "tier_name": "VIP",
      "description": "All-inclusive entry with premium chips, a private gaming lounge, and complimentary drinks & dinner.",
      "price": {"display_price": 7000}
    }
  ]'::jsonb,
  'water',
  true
);
