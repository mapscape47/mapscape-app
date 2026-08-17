-- Test data for local/dev verification of the activity landing page template.
insert into public.activities (name, slug, category, description, price_tiers, image_url, is_active)
values (
  'Scuba Diving',
  'scuba',
  'water',
  'Explore Goa''s reefs with certified instructors. No prior experience needed for the intro dive — full gear included.',
  '[
    {"name": "5-Min Intro Dive", "price": 1500},
    {"name": "Full-Day Dive", "price": 6000}
  ]'::jsonb,
  null,
  true
);
