-- Real Kayaking data import (replaces the placeholder test listing
-- from kayaking-seed.sql). Idempotent: upserts by
-- (activity_category, slug), safe to run twice.
--
-- No code changes required — /kayaking and /kayaking/[slug] already
-- render through the standard shared CategoryPageView/ListingPageView,
-- and pricing_type "single" already produces "Hi Mapscape, I would
-- like to book [Name]." (no tier suffix, since tier_name is left
-- unset below).
--
-- 3 real listings, not 1 — each at a different location, all ₹500.
-- Unlike the earlier placeholder, no name-folding workaround is
-- needed: each listing's own name already carries its location
-- ("Baga Kayaking" etc.), so the shared Level 2 card's lack of a
-- separate location field is a non-issue here. No discount pricing in
-- the sheet. No vendor/company name beyond each listing's own name.
-- Baga has no stated session duration in the sheet, so no Duration
-- Quick Answer is added for it (Moira and Colva do have one).

update public.activities
set image_urls = array[
  '/activities/kayaking/category-1.webp',
  '/activities/kayaking/category-2.webp',
  '/activities/kayaking/category-3.webp',
  '/activities/kayaking/category-4.webp',
  '/activities/kayaking/category-5.webp'
]
where slug = 'kayaking';

insert into public.listings (
  activity_category, slug, name, description, overview_points, photos,
  location_address, location_lat, location_lng,
  quick_answers, pricing_type, pricing_data, contact_type, is_active
)
values
  (
    'kayaking', 'baga-kayaking', 'Baga Kayaking',
    'A guided kayaking session along the calm backwaters near Baga, perfect for beginners and anyone looking for a peaceful paddle away from the beach crowds.',
    '["Guided tour included", "2-person kayak", "Life jackets provided", "Beginner-friendly, no experience needed", "Scenic backwater views"]'::jsonb,
    array['/activities/kayaking/baga-kayaking-1.webp', '/activities/kayaking/baga-kayaking-2.webp', '/activities/kayaking/baga-kayaking-3.webp', '/activities/kayaking/baga-kayaking-4.webp', '/activities/kayaking/baga-kayaking-5.webp'],
    'Baga, Goa', null, null,
    '[{"label": "Capacity", "value": "2 people per kayak"}, {"label": "Group Friendly", "value": "Yes"}, {"label": "Photography", "value": "Allowed"}, {"label": "Language", "value": "English, Hindi"}]'::jsonb,
    'single',
    '{"price": {"display_price": 500}}'::jsonb,
    'water', true
  ),
  (
    'kayaking', 'moira-kayaking', 'Moira Kayaking',
    'A guided kayaking session through the scenic backwaters of Moira, offering a peaceful paddle through lush greenery away from the busier beach spots.',
    '["Guided tour included", "2-person kayak", "1.5-hour session", "Life jackets provided", "Scenic backwater & village views"]'::jsonb,
    array['/activities/kayaking/moira-kayaking-1.webp', '/activities/kayaking/moira-kayaking-2.webp', '/activities/kayaking/moira-kayaking-3.webp', '/activities/kayaking/moira-kayaking-4.webp', '/activities/kayaking/moira-kayaking-5.webp'],
    'Moira, Goa', null, null,
    '[{"label": "Capacity", "value": "2 people per kayak"}, {"label": "Duration", "value": "1.5-hour session"}, {"label": "Group Friendly", "value": "Yes"}, {"label": "Photography", "value": "Allowed"}, {"label": "Language", "value": "English, Hindi"}]'::jsonb,
    'single',
    '{"price": {"display_price": 500}}'::jsonb,
    'water', true
  ),
  (
    'kayaking', 'colva-kayaking', 'Colva Kayaking',
    'A guided kayaking session near Colva Beach, offering a relaxed paddle through calm waters — a great way to explore the coastline from a different angle.',
    '["Guided tour included", "2-person kayak", "1-hour session", "Life jackets provided", "Coastal & backwater views"]'::jsonb,
    array['/activities/kayaking/colva-kayaking-1.webp', '/activities/kayaking/colva-kayaking-2.webp', '/activities/kayaking/colva-kayaking-3.webp', '/activities/kayaking/colva-kayaking-4.webp', '/activities/kayaking/colva-kayaking-5.webp'],
    'Colva, Goa', null, null,
    '[{"label": "Capacity", "value": "2 people per kayak"}, {"label": "Duration", "value": "1-hour session"}, {"label": "Group Friendly", "value": "Yes"}, {"label": "Photography", "value": "Allowed"}, {"label": "Language", "value": "English, Hindi"}]'::jsonb,
    'single',
    '{"price": {"display_price": 500}}'::jsonb,
    'water', true
  )
on conflict (activity_category, slug) do update set
  name = excluded.name,
  description = excluded.description,
  overview_points = excluded.overview_points,
  photos = excluded.photos,
  location_address = excluded.location_address,
  location_lat = excluded.location_lat,
  location_lng = excluded.location_lng,
  quick_answers = excluded.quick_answers,
  pricing_type = excluded.pricing_type,
  pricing_data = excluded.pricing_data,
  contact_type = excluded.contact_type,
  is_active = excluded.is_active;
