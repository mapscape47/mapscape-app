-- Real Quad Biking data import (replaces the placeholder test listing
-- from quad-biking-seed.sql). Idempotent: upserts by
-- (activity_category, slug), safe to run twice.
--
-- No code changes required — /quad-biking and /quad-biking/[slug]
-- already render through the standard shared tiered templates.
-- pricing_type "tiered" is used for both listings (not multi_service)
-- specifically because its message format already matches what was
-- requested exactly: "Hi Mapscape, I would like to book [Name] -
-- [Option]." — multi_service would have produced "...book [Option] at
-- [Name]." instead.
--
-- Public listing names are "Bicholim ATV" and "Bogmalo ATV" (the
-- sheet's own names), not the vendor/operator brand names
-- ("Reem Adventures", "The ATV Club") that only appear in the source
-- photo filenames — those vendor names are never shown anywhere in
-- the UI. Bicholim ATV's description had its vendor name and an
-- affiliated training-institute name removed.

update public.activities
set image_urls = array[
  '/activities/quad-biking/category-1.webp',
  '/activities/quad-biking/category-2.webp',
  '/activities/quad-biking/category-3.webp',
  '/activities/quad-biking/category-4.webp',
  '/activities/quad-biking/category-5.webp'
]
where slug = 'quad-biking';

insert into public.listings (
  activity_category, slug, name, description, overview_points, photos,
  location_address, location_lat, location_lng,
  quick_answers, pricing_type, pricing_data, contact_type, is_active
)
values
  (
    'quad-biking', 'bicholim-atv', 'Bicholim ATV',
    'An off-road ATV adventure through the hillside forests and lakeside landscapes of Bicholim, with scenic trail views perfect for photos.',
    '["40-minute guided trail ride", "Complimentary archery session included", "Safety gear provided", "Guide assistance throughout the trail", "Scenic lakeside & forest views along the route"]'::jsonb,
    array['/activities/quad-biking/bicholim-atv-1.webp', '/activities/quad-biking/bicholim-atv-2.webp', '/activities/quad-biking/bicholim-atv-3.webp', '/activities/quad-biking/bicholim-atv-4.webp', '/activities/quad-biking/bicholim-atv-5.webp'],
    'Dewoolwada, Vadawal, Latambarcem, Bicholim, Goa', null, null,
    '[{"label": "Group Friendly", "value": "Yes"}, {"label": "Photography & Drone Photography", "value": "Allowed"}, {"label": "Language", "value": "English, Hindi"}, {"label": "Timings", "value": "10:30 AM - 6:00 PM"}]'::jsonb,
    'tiered',
    '[
      {"tier_name": "Single Seater", "description": "A 40-minute guided ATV trail ride for one rider.", "price": {"display_price": 1799}},
      {"tier_name": "Double Seater", "description": "A 40-minute guided ATV trail ride for two riders.", "price": {"display_price": 2799}}
    ]'::jsonb,
    'land', true
  ),
  (
    'quad-biking', 'bogmalo-atv', 'Bogmalo ATV',
    'An ATV riding experience on a 2.1 km farm track in Bogmalo, with multiple ATV sizes to choose from — suitable for both first-timers and experienced riders looking for a longer thrill.',
    '["5 rounds per ride, ~25-30 minutes, 2.1 km total distance", "Choice of Small, Medium, or Big ATVs", "Training/trial rounds included", "Guide along the track with photo/video assistance", "Washroom, changing room & monsoon rainwear provided"]'::jsonb,
    array['/activities/quad-biking/bogmalo-atv-1.webp', '/activities/quad-biking/bogmalo-atv-2.webp', '/activities/quad-biking/bogmalo-atv-3.webp', '/activities/quad-biking/bogmalo-atv-4.webp', '/activities/quad-biking/bogmalo-atv-5.webp'],
    'Bogmalo, Goa', null, null,
    '[{"label": "Group Friendly", "value": "Yes"}, {"label": "Photography & Drone Photography", "value": "Allowed (guide assists with photos/videos)"}, {"label": "Language", "value": "English, Hindi"}, {"label": "Duration", "value": "25-30 minutes"}]'::jsonb,
    'tiered',
    '[
      {"tier_name": "Small ATV (110cc), Single Rider", "description": "A 2.1 km farm-track ride on a small ATV, single rider.", "price": {"display_price": 700}},
      {"tier_name": "Medium ATV (135cc), Single Rider", "description": "A 2.1 km farm-track ride on a medium ATV, single rider.", "price": {"display_price": 900}},
      {"tier_name": "Big ATV (200-250cc), Single Rider", "description": "A 2.1 km farm-track ride on a big ATV, single rider.", "price": {"display_price": 1100}},
      {"tier_name": "Big ATV (200-250cc), Double Seat", "description": "A 2.1 km farm-track ride on a big ATV, two riders.", "price": {"display_price": 1600}}
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
