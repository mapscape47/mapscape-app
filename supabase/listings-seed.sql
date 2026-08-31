-- Level 3 template verification data.
-- Run this in the Supabase SQL Editor after schema.sql has the `listings` table.

-- 1: real content, pricing_type "single" — verifies /scuba/full-day-dive.
-- Scuba deliberately has exactly one listing at one price (no tiers) —
-- overview_points is the optional bullet list shown below the paragraph
-- description; the values here are placeholder copy, flagged for review.
insert into public.listings (
  activity_category, slug, name, description, overview_points, photos,
  location_address, location_lat, location_lng,
  quick_answers, pricing_type, pricing_data, contact_type, is_active
)
values
  (
    'scuba',
    'full-day-dive',
    'Full-Day Dive',
    'A full day of scuba diving with certified instructors, covering multiple dive sites around Grande Island. Includes all gear, lunch, and boat transfers.',
    '[
      "No prior diving experience needed",
      "PADI-certified instructors",
      "Full gear included",
      "Suitable for ages 10+",
      "Multiple dive sites around Grande Island"
    ]'::jsonb,
    '{}',
    'Grande Island Boat Jetty, Vasco da Gama, Goa',
    15.3841,
    73.8283,
    '[
      {"label": "Capacity", "value": "Up to 8 divers per boat"},
      {"label": "Group Friendly", "value": "Yes"},
      {"label": "Photography", "value": "GoPro footage included"},
      {"label": "Language", "value": "English, Hindi"},
      {"label": "Food Included", "value": "Lunch included"}
    ]'::jsonb,
    'single',
    '{"price": {"display_price": 6000}}'::jsonb,
    'water',
    true
  );

-- 3 & 4: placeholder/dummy data to verify the other two pricing_type
-- layouts render correctly. Safe to delete once verified — clearly
-- labeled with a "[TEST]" prefix so they're never mistaken for real
-- content in the admin/dashboard later.
insert into public.listings (
  activity_category, slug, name, description, photos,
  location_address, location_lat, location_lng,
  quick_answers, pricing_type, pricing_data, contact_type, is_active
)
values
  (
    'scuba',
    'template-test-tiered',
    '[TEST] Tiered Pricing Demo',
    'Placeholder listing used to verify the tiered pricing layout renders correctly.',
    '{}',
    'Placeholder Address, Goa',
    15.5,
    73.8,
    '[{"label": "Test Field", "value": "Test Value"}]'::jsonb,
    'tiered',
    '[
      {"tier_name": "Basic", "description": "Entry-level option", "price": {"display_price": 1000}},
      {"tier_name": "Standard", "description": "Most popular option", "price": {"display_price": 2000}},
      {"tier_name": "Premium", "description": "All-inclusive option", "price": {"display_price": 3500}}
    ]'::jsonb,
    'water',
    true
  ),
  (
    'scuba',
    'template-test-multi-service',
    '[TEST] Multi-Service Pricing Demo',
    'Placeholder listing used to verify the multi-service pricing layout renders correctly.',
    '{}',
    'Placeholder Address, Goa',
    15.5,
    73.8,
    '[{"label": "Test Field", "value": "Test Value"}]'::jsonb,
    'multi_service',
    '[
      {"service_name": "Service A", "price": {"display_price": 500}},
      {"service_name": "Service B", "description": "Optional add-on", "price": {"display_price": 800}},
      {"service_name": "Service C", "price": {"display_price": 1200}},
      {"service_name": "Service D", "description": "Premium add-on", "price": {"display_price": 2000}}
    ]'::jsonb,
    'land',
    true
  );
