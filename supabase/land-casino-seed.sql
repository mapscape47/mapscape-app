-- New Land Casino category, using the existing shared Level 2/Level 3
-- templates unchanged. Only one placeholder test listing — real casino
-- vendor data to be provided separately once this is confirmed working.
-- Run this once in the Supabase SQL Editor against the live database.

insert into public.activities (name, slug, category, description, is_active)
values (
  'Land Casino',
  'land-casino',
  'land',
  'Try your luck at Goa''s land-based casinos — table games, slots, and a night of entertainment away from the beach.',
  true
);

insert into public.listings (
  activity_category, slug, name, description, overview_points, photos,
  location_address, location_lat, location_lng,
  quick_answers, pricing_type, pricing_data, contact_type, is_active
)
values (
  'land-casino',
  'sample-land-casino',
  '[TEST] Sample Land Casino',
  'A placeholder land casino listing used to verify the tiered pricing layout with discount pricing. Replace with real vendor data once confirmed.',
  '[
    "Live table games and slot machines",
    "Entry to gaming floor included",
    "Age requirement: 21+",
    "Smart casual dress code"
  ]'::jsonb,
  '{}',
  'Bambolim, Tiswadi, Goa',
  15.4487,
  73.8567,
  '[
    {"label": "Group Friendly", "value": "Yes"},
    {"label": "Language", "value": "English, Hindi"},
    {"label": "Food Included", "value": "Complimentary snacks on Premium and VIP"}
  ]'::jsonb,
  'tiered',
  '[
    {
      "tier_name": "Signature",
      "description": "Entry with welcome chips and access to the main gaming floor.",
      "price": {"display_price": 1500}
    },
    {
      "tier_name": "Premium",
      "description": "Entry with higher welcome chips, complimentary snacks, and a reserved table.",
      "price": {"display_price": 3000, "original_price": 3500}
    },
    {
      "tier_name": "VIP",
      "description": "All-inclusive entry with premium chips, a private gaming area, and complimentary drinks & dinner.",
      "price": {"display_price": 6000}
    }
  ]'::jsonb,
  'land',
  true
);
