-- Real Bungee Jumping data import (replaces the placeholder test
-- listing from bungee-jumping-seed.sql). Idempotent: upserts by
-- (activity_category, slug), safe to run twice.
--
-- No code changes required — /bungee-jumping and
-- /bungee-jumping/[slug] already render through the standard shared
-- templates. Latambarcem uses pricing_type "single" (one core jump
-- price; the Drone Video Add-on is folded into a Quick Answer since
-- it's an optional extra, not a separate bookable experience), giving
-- "Hi Mapscape, I would like to book Latambarcem Bungee Jumping."
-- Mayem uses "tiered" (Solo/Tandem are both independently bookable),
-- giving "...book Mayem Bungee Jumping - Solo Bungy." / "- Tandem
-- Bungy." No discount pricing anywhere in the sheet.
--
-- Public listing names are the sheet's own location-based names
-- ("Latambarcem Bungee Jumping", "Mayem Bungee Jumping"), not the
-- vendor/operator brand names ("Indya Bungy", "Jumping Heights") that
-- only appeared in the original description text — those vendor
-- names, plus an "ex-Army officers" operator-identifying detail for
-- Mayem, have been removed from the descriptions below.

update public.activities
set image_urls = array[
  '/activities/bungee-jumping/category-1.webp',
  '/activities/bungee-jumping/category-2.webp',
  '/activities/bungee-jumping/category-3.webp',
  '/activities/bungee-jumping/category-4.webp',
  '/activities/bungee-jumping/category-5.webp'
]
where slug = 'bungee-jumping';

insert into public.listings (
  activity_category, slug, name, description, overview_points, photos,
  location_address, location_lat, location_lng,
  quick_answers, pricing_type, pricing_data, contact_type, is_active
)
values
  (
    'bungee-jumping', 'latambarcem-bungee-jumping', 'Latambarcem Bungee Jumping',
    'Experience India''s highest inclined bungee jump, soaring 61 meters above the ground. A thrilling, professionally run adventure with international safety standards, perfect for first-timers and adrenaline seekers alike.',
    '["61-meter inclined bungee jump — highest in India", "Professional safety crew & equipment", "Free video of your jump included", "Optional drone video for extra angles", "Suitable for first-time jumpers"]'::jsonb,
    array['/activities/bungee-jumping/latambarcem-bungee-jumping-1.webp', '/activities/bungee-jumping/latambarcem-bungee-jumping-2.webp', '/activities/bungee-jumping/latambarcem-bungee-jumping-3.webp', '/activities/bungee-jumping/latambarcem-bungee-jumping-4.webp', '/activities/bungee-jumping/latambarcem-bungee-jumping-5.webp'],
    'Vadaval, North Goa', null, null,
    '[{"label": "Group Friendly", "value": "Yes"}, {"label": "Photography & Drone Photography", "value": "Allowed (drone video available as add-on)"}, {"label": "Language", "value": "English, Hindi"}, {"label": "Minimum Age", "value": "Typically 12+, subject to weight/fitness criteria"}, {"label": "Drone Video Add-on", "value": "+₹1,000 (optional, for extra footage angles)"}]'::jsonb,
    'single',
    '{"price": {"display_price": 3750}}'::jsonb,
    'land', true
  ),
  (
    'bungee-jumping', 'mayem-bungee-jumping', 'Mayem Bungee Jumping',
    'India''s only bungy jump over a lake, set on the scenic Mayem Lake in North Goa, with internationally trained jump masters and an experienced, safety-focused team.',
    '["India''s only bungy jump over a lake", "55-meter jump height", "Trained by New Zealand safety experts", "Free jump video included", "Tandem bungy option available for couples"]'::jsonb,
    array['/activities/bungee-jumping/mayem-bungee-jumping-1.webp', '/activities/bungee-jumping/mayem-bungee-jumping-2.webp', '/activities/bungee-jumping/mayem-bungee-jumping-3.webp', '/activities/bungee-jumping/mayem-bungee-jumping-4.webp', '/activities/bungee-jumping/mayem-bungee-jumping-5.webp'],
    'Mayem Lake, Bicholim, North Goa', null, null,
    '[{"label": "Group Friendly", "value": "Yes"}, {"label": "Photography & Drone Photography", "value": "Allowed"}, {"label": "Language", "value": "English, Hindi"}, {"label": "Timings", "value": "9:00 AM - 6:00 PM (closed Tuesdays)"}, {"label": "Note", "value": "Closed during peak monsoon (mid-June to mid-August)"}]'::jsonb,
    'tiered',
    '[
      {"tier_name": "Solo Bungy", "description": "A solo jump, includes free jump video.", "price": {"display_price": 4850}},
      {"tier_name": "Tandem Bungy", "description": "Jump with a partner, includes free jump video.", "price": {"display_price": 8000}}
    ]'::jsonb,
    'land', true
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
