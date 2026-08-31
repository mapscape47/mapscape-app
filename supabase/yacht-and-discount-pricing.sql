-- Migration: adds activities.image_urls (Level 2 category slider), migrates
-- all existing listings.pricing_data to the new discount-aware price shape
-- ({ display_price, original_price? } instead of a flat number), and adds
-- the new Yacht category + one placeholder test boat listing.
-- Run this once in the Supabase SQL Editor against the live database.

alter table public.activities add column if not exists image_urls text[] not null default '{}';

-- 1. Migrate existing listings' pricing_data to the new price object shape.
-- Written as full literal replacements (not jsonb_set/operators) so the
-- exact resulting JSON can be verified by reading this file directly.
update public.listings
set pricing_data = '{"price": {"display_price": 6000}}'::jsonb
where activity_category = 'scuba' and slug = 'full-day-dive';

update public.listings
set pricing_data = '[
  {"tier_name": "Basic", "description": "Entry-level option", "price": {"display_price": 1000}},
  {"tier_name": "Standard", "description": "Most popular option", "price": {"display_price": 2000}},
  {"tier_name": "Premium", "description": "All-inclusive option", "price": {"display_price": 3500}}
]'::jsonb
where activity_category = 'scuba' and slug = 'template-test-tiered';

update public.listings
set pricing_data = '[
  {"service_name": "Service A", "price": {"display_price": 500}},
  {"service_name": "Service B", "description": "Optional add-on", "price": {"display_price": 800}},
  {"service_name": "Service C", "price": {"display_price": 1200}},
  {"service_name": "Service D", "description": "Premium add-on", "price": {"display_price": 2000}}
]'::jsonb
where activity_category = 'scuba' and slug = 'template-test-multi-service';

-- 2. New Yacht category (Level 2 page).
insert into public.activities (name, slug, category, description, is_active)
values (
  'Yacht',
  'yacht',
  'water',
  'Cruise the Goan coastline in style aboard a private yacht — perfect for sunset views, celebrations, or a relaxed day on the water.',
  true
);

-- 3. One placeholder test boat (Level 3 page) — pricing_type "tiered" with
-- discount pricing on one tier. Real boat data to be provided separately.
insert into public.listings (
  activity_category, slug, name, description, overview_points, photos,
  location_address, location_lat, location_lng,
  quick_answers, pricing_type, pricing_data, contact_type, is_active
)
values (
  'yacht',
  'sample-yacht',
  '[TEST] Sample Yacht',
  'A placeholder yacht listing used to verify the tiered pricing layout with discount pricing. Replace with real boat data once confirmed.',
  '[
    "Life jackets and safety gear provided",
    "Onboard music system",
    "Complimentary soft drinks",
    "Experienced skipper included"
  ]'::jsonb,
  '{}',
  'Britona Jetty, Goa',
  15.5389,
  73.8281,
  '[
    {"label": "Capacity", "value": "Up to 12 guests"},
    {"label": "Group Friendly", "value": "Yes"},
    {"label": "Duration Options", "value": "2 hours or half-day"}
  ]'::jsonb,
  'tiered',
  '[
    {
      "tier_name": "2-Hour Sunset Cruise",
      "description": "A relaxed evening cruise along the coast, timed for golden-hour views.",
      "price": {"display_price": 6500, "original_price": 8000}
    },
    {
      "tier_name": "Half-Day Charter",
      "description": "A full half-day aboard the yacht, ideal for celebrations or longer outings.",
      "price": {"display_price": 15000}
    }
  ]'::jsonb,
  'water',
  true
);
