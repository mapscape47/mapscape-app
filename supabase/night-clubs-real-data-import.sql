-- Real Night Clubs data import (replaces the placeholder test
-- listing from clubs-seed.sql). Idempotent: upserts by
-- (activity_category, slug), safe to run twice.
--
-- No code changes needed — /clubs and /clubs/[slug] already render
-- through the standard shared tiered templates (same as Yacht/Quad
-- Biking), already producing "Hi Mapscape, I would like to book
-- [Name] - [Tier]." for each tier's own Book Now button, and already
-- showing only area_name + Book Now where a map link would be (the
-- same location-privacy fix applied to every other booking-flow
-- category). No PDF menu section — never had one.
--
-- Prices for HillTop, SinQ, Hammerzz, and Las Olas were ranges or
-- missing a couple/stag split in the source sheet — the four numbers
-- below for those clubs were given directly by you, not derived from
-- the sheet. Tito's Nightclub's two prices came straight from the
-- sheet as-is. No discount pricing anywhere (no original_price given
-- for any tier). The sheet has no map link or precise address for any
-- club — just a locality name — so there is nothing to store in the
-- private listing_locations table for this category; area_name is
-- simply the sheet's own Location value. No vendor/operator name
-- beyond each club's own name.

update public.activities
set image_urls = array[
  '/activities/night-clubs/category-1.webp',
  '/activities/night-clubs/category-2.webp',
  '/activities/night-clubs/category-3.webp',
  '/activities/night-clubs/category-4.webp',
  '/activities/night-clubs/category-5.webp'
]
where slug = 'clubs';

insert into public.listings (
  activity_category, slug, name, description, overview_points, photos,
  area_name, quick_answers, pricing_type, pricing_data, contact_type, is_active
)
values
  (
    'clubs', 'titos-nightclub', 'Tito''s Nightclub',
    'As one of the most popular and recognized nightclubs in Goa, Tito''s is the ultimate destination for commercial and Bollywood music lovers. Located right next to Baga Beach, it offers massive crowds, unlimited drink packages, and an unforgettable, classic Goan party experience.',
    '["Features multiple dance floors, including a dedicated Bollywood Discotheque", "One of the most iconic, high-energy party destinations in Goa", "Open until 3:00 AM", "Frequently organizes themed nights, including vintage Bollywood parties"]'::jsonb,
    array['/activities/night-clubs/titos-nightclub-1.webp', '/activities/night-clubs/titos-nightclub-2.webp', '/activities/night-clubs/titos-nightclub-3.webp', '/activities/night-clubs/titos-nightclub-4.webp', '/activities/night-clubs/titos-nightclub-5.webp'],
    'Baga',
    '[{"label": "Timings", "value": "Open until 3:00 AM"}]'::jsonb,
    'tiered',
    '[
      {"tier_name": "Couple Entry", "description": "Includes unlimited drinks.", "price": {"display_price": 2100}},
      {"tier_name": "Stag Entry", "description": "Includes unlimited drinks.", "price": {"display_price": 2500}}
    ]'::jsonb,
    'land', true
  ),
  (
    'clubs', 'hilltop', 'HillTop',
    'HillTop is the undisputed global epicenter of Goa''s psytrance and electronic music scene. This iconic open-air arena draws an international crowd who come to dance under glowing art and neon spirals, making it a must-visit destination for true music and festival lovers.',
    '["A massive open-air dance floor surrounded by neon-lit palm trees", "World-renowned for its psychedelic trance, techno, and EDM tracks", "Peak hours are Friday and Sunday from 4:00 PM to 3:00 AM", "Most famous for its legendary Sunday evening parties running from 5:00 PM to 10:00 PM"]'::jsonb,
    array['/activities/night-clubs/hilltop-1.webp', '/activities/night-clubs/hilltop-2.webp', '/activities/night-clubs/hilltop-3.webp', '/activities/night-clubs/hilltop-4.webp', '/activities/night-clubs/hilltop-5.webp'],
    'Vagator',
    '[]'::jsonb,
    'tiered',
    '[
      {"tier_name": "Couple Entry", "price": {"display_price": 2000}},
      {"tier_name": "Stag Entry", "price": {"display_price": 3000}}
    ]'::jsonb,
    'land', true
  ),
  (
    'clubs', 'sinq-nightclub', 'SinQ Nightclub',
    'SinQ is Goa''s trendiest mid-premium poolside party destination. Blending modern, Instagram-worthy aesthetics with commercial and Bollywood beats, it provides an upscale, chic clubbing experience that peaks in energy between 11:00 PM and 2:00 AM.',
    '["Famous for its legendary poolside parties where guests can swim, socialize, and dance under the stars", "Features modern interiors and highly sought-after poolside VIP tables", "Open from 10:00 PM to 5:00 AM", "Enforces a smart casual dress code and attracts a young, trendy crowd"]'::jsonb,
    array['/activities/night-clubs/sinq-nightclub-1.webp', '/activities/night-clubs/sinq-nightclub-2.webp', '/activities/night-clubs/sinq-nightclub-3.webp', '/activities/night-clubs/sinq-nightclub-4.webp', '/activities/night-clubs/sinq-nightclub-5.webp'],
    'Candolim',
    '[{"label": "Dress Code", "value": "Smart casual"}, {"label": "Timings", "value": "10:00 PM - 5:00 AM"}]'::jsonb,
    'tiered',
    '[
      {"tier_name": "Couple Entry", "price": {"display_price": 2500}},
      {"tier_name": "Stag Entry", "price": {"display_price": 3500}}
    ]'::jsonb,
    'land', true
  ),
  (
    'clubs', 'hammerzz-nightclub', 'Hammerzz Nightclub',
    'Hammerzz is Baga''s premier luxury indoor nightclub, designed to deliver a festival-like party experience. Catering to a premium crowd, it features sleek interiors, an expansive dance floor, and a highly sought-after VIP section, making it the perfect destination for high-energy, sophisticated clubbing.',
    '["Renowned for its massive indoor dance floor, state-of-the-art LED lighting, and high-end sound system", "Frequently hosts BollyTech, commercial, and EDM nights with top-tier DJs", "Open from 9:00 PM to 3:30 AM", "Enforces a strict smart-casual dress code (no beachwear or flip-flops)"]'::jsonb,
    array['/activities/night-clubs/hammerzz-nightclub-1.webp', '/activities/night-clubs/hammerzz-nightclub-2.webp', '/activities/night-clubs/hammerzz-nightclub-3.webp', '/activities/night-clubs/hammerzz-nightclub-4.webp', '/activities/night-clubs/hammerzz-nightclub-5.webp'],
    'Baga',
    '[{"label": "Dress Code", "value": "Smart-casual (no beachwear or flip-flops)"}, {"label": "Timings", "value": "9:00 PM - 3:30 AM"}]'::jsonb,
    'tiered',
    '[
      {"tier_name": "Couple Entry", "price": {"display_price": 4000}},
      {"tier_name": "Stag Entry", "price": {"display_price": 6000}}
    ]'::jsonb,
    'land', true
  ),
  (
    'clubs', 'las-olas-beach-club', 'Las Olas Beach Club',
    'Las Olas offers an unforgettable, quintessential Goa beach party right on the sands of Baga. Blending spectacular sunset views with an electric, open-air Bollywood party vibe, this venue provides a casual, high-energy environment where you can dance under the stars until the sun comes up.',
    '["Offers a legendary open-air beachfront clubbing experience where you can literally dance barefoot on the sand", "Particularly famous for its high-energy Bollywood music nights", "The party peaks from 10:00 PM to 6:00 AM, though guests often arrive around 5:30 PM to catch the sunset", "Has a very relaxed, casual beach dress code"]'::jsonb,
    array['/activities/night-clubs/las-olas-beach-club-1.webp', '/activities/night-clubs/las-olas-beach-club-2.webp', '/activities/night-clubs/las-olas-beach-club-3.webp', '/activities/night-clubs/las-olas-beach-club-4.webp', '/activities/night-clubs/las-olas-beach-club-5.webp'],
    'Baga',
    '[{"label": "Dress Code", "value": "Casual beach"}, {"label": "Timings", "value": "10:00 PM - 6:00 AM"}]'::jsonb,
    'tiered',
    '[
      {"tier_name": "Couple Entry", "price": {"display_price": 2000}},
      {"tier_name": "Stag Entry", "price": {"display_price": 3000}}
    ]'::jsonb,
    'land', true
  )
on conflict (activity_category, slug) do update set
  name = excluded.name,
  description = excluded.description,
  overview_points = excluded.overview_points,
  photos = excluded.photos,
  area_name = excluded.area_name,
  quick_answers = excluded.quick_answers,
  pricing_type = excluded.pricing_type,
  pricing_data = excluded.pricing_data,
  contact_type = excluded.contact_type,
  is_active = excluded.is_active;
