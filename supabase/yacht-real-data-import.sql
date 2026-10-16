-- Real Yacht data import (replaces/extends the placeholder from
-- yacht-and-discount-pricing.sql). Idempotent: upserts by
-- (activity_category, slug), so running this twice is safe.
--
-- No code changes required — /yacht and /yacht/[slug] already render
-- through the standard shared CategoryPageView/ListingPageView, and
-- pricing_type "tiered" already produces the exact
-- "Hi Mapscape, I would like to book [Name] - [Tier]." WhatsApp message.
--
-- Pricing note: the source sheet has no discount/original price for any
-- yacht tier — every tier is a single price, so original_price is simply
-- omitted everywhere below (no strikethrough anywhere, matching the sheet).
-- Location note: the sheet only gives "Panjim" as a city, no address/lat-
-- long, so location_address is set to "Panjim, Goa" with lat/lng left null
-- (falls back to an address-based Maps search link).

-- Level 2 category photos (slider on /yacht).
update public.activities
set image_urls = array[
  '/activities/yachts/category-1.webp',
  '/activities/yachts/category-2.webp',
  '/activities/yachts/category-3.webp',
  '/activities/yachts/category-4.webp',
  '/activities/yachts/category-5.webp'
]
where slug = 'yacht';

insert into public.listings (
  activity_category, slug, name, description, overview_points, photos,
  location_address, location_lat, location_lng,
  quick_answers, pricing_type, pricing_data, contact_type, is_active
)
values
  (
    'yacht', 'wave-rider', 'Wave Rider',
    'The Wave Rider offers an intimate, luxurious sailing experience for up to six guests. Enjoy sun-drenched decks, premium comfort, and unforgettable sunset cruises along Goa''s spectacular coastline.',
    '["Spacious sun deck seating", "Premium comfort & finishes", "2 package options — short sail or extended trip with a stop", "Great for small groups & couples", "Scenic views along Goa''s coastline"]'::jsonb,
    array['/activities/yachts/wave-rider-1.webp', '/activities/yachts/wave-rider-2.webp', '/activities/yachts/wave-rider-3.webp', '/activities/yachts/wave-rider-4.webp', '/activities/yachts/wave-rider-5.webp'],
    'Panjim, Goa', null, null,
    '[{"label": "Capacity", "value": "6 guests max"}, {"label": "Group Friendly", "value": "Yes"}, {"label": "Photography", "value": "Allowed"}, {"label": "Language", "value": "English, Hindi"}]'::jsonb,
    'tiered',
    '[
      {"tier_name": "2hr Package", "description": "1 hour of sailing plus a 1-hour stop along the way.", "price": {"display_price": 11000}},
      {"tier_name": "1hr Package", "description": "A straight 1-hour sailing trip, no stop.", "price": {"display_price": 8000}}
    ]'::jsonb,
    'water', true
  ),
  (
    'yacht', 'blue-fin', 'Blue Fin',
    'The Blue Fin provides a premier yachting experience for up to six guests. Discover hidden coves, relax on spacious decks, and enjoy tailored, world-class service on the sea.',
    '["Discover hidden coves along the coastline", "Spacious deck seating", "2 package options — short sail or extended trip with a stop", "Comfortable, relaxed yachting experience", "Great for small groups & couples"]'::jsonb,
    array['/activities/yachts/blue-fin-1.webp', '/activities/yachts/blue-fin-2.webp', '/activities/yachts/blue-fin-3.webp', '/activities/yachts/blue-fin-4.webp', '/activities/yachts/blue-fin-5.webp'],
    'Panjim, Goa', null, null,
    '[{"label": "Capacity", "value": "6 guests max"}, {"label": "Group Friendly", "value": "Yes"}, {"label": "Photography", "value": "Allowed"}, {"label": "Language", "value": "English, Hindi"}]'::jsonb,
    'tiered',
    '[
      {"tier_name": "2hr Package", "description": "1 hour of sailing plus a 1-hour stop along the way.", "price": {"display_price": 12000}},
      {"tier_name": "1hr Package", "description": "A straight 1-hour sailing trip, no stop.", "price": {"display_price": 9000}}
    ]'::jsonb,
    'water', true
  ),
  (
    'yacht', 'mandovi-lounge', 'Mandovi Lounge',
    'Glide along the scenic Mandovi River aboard the Mandovi Lounge Boat. Designed for six guests, it offers plush seating, relaxed vibes, and an unforgettable, intimate river cruising experience.',
    '["Sailing along the scenic Mandovi River", "Plush seating & relaxed vibe", "2 package options — short sail or extended trip with a stop", "Comfortable ride for small groups", "Great river & city skyline views"]'::jsonb,
    array['/activities/yachts/mandovi-lounge-1.webp', '/activities/yachts/mandovi-lounge-2.webp', '/activities/yachts/mandovi-lounge-3.webp', '/activities/yachts/mandovi-lounge-4.webp', '/activities/yachts/mandovi-lounge-5.webp'],
    'Panjim, Goa', null, null,
    '[{"label": "Capacity", "value": "6 guests max"}, {"label": "Group Friendly", "value": "Yes"}, {"label": "Photography & Drone Photography", "value": "Allowed"}, {"label": "Language", "value": "English, Hindi"}]'::jsonb,
    'tiered',
    '[
      {"tier_name": "2hr Package", "description": "1 hour of sailing plus a 1-hour stop along the way.", "price": {"display_price": 9500}},
      {"tier_name": "1hr Package", "description": "A straight 1-hour sailing trip, no stop.", "price": {"display_price": 8000}}
    ]'::jsonb,
    'water', true
  ),
  (
    'yacht', 'manta-ray', 'Manta Ray',
    'Step aboard the luxurious Manta Ray, a premium yacht perfectly designed to accommodate up to eight guests. Enjoy spacious sun decks, a modern sound system, and spectacular sunsets on the Arabian Sea.',
    '["Premium yacht built for comfort", "Spacious sun deck seating", "2 package options — short sail or extended trip with a stop", "Tailored, relaxed onboard experience", "Great for small to mid-sized groups"]'::jsonb,
    array['/activities/yachts/manta-ray-1.webp', '/activities/yachts/manta-ray-2.webp', '/activities/yachts/manta-ray-3.webp', '/activities/yachts/manta-ray-4.webp', '/activities/yachts/manta-ray-5.webp'],
    'Panjim, Goa', null, null,
    '[{"label": "Capacity", "value": "8 guests max"}, {"label": "Group Friendly", "value": "Yes"}, {"label": "Photography & Drone Photography", "value": "Allowed"}, {"label": "Language", "value": "English, Hindi"}]'::jsonb,
    'tiered',
    '[
      {"tier_name": "2hr Package", "description": "1 hour of sailing plus a 1-hour stop along the way.", "price": {"display_price": 14500}},
      {"tier_name": "1hr Package", "description": "A straight 1-hour sailing trip, no stop.", "price": {"display_price": 11500}}
    ]'::jsonb,
    'water', true
  ),
  (
    'yacht', 'sea-ray', 'Sea Ray',
    'Designed for unforgettable celebrations, the luxurious Sea Ray comfortably hosts ten passengers. Experience seamless sailing along the Arabian Sea with plush lounging areas, an air-conditioned cabin, and breathtaking panoramic coastal views.',
    '["Spacious sun deck seating", "Relaxed, tailored sailing experience", "2 package options — short sail or extended trip with a stop", "Comfortable for mid-sized groups", "Seamless sailing along the coastline"]'::jsonb,
    array['/activities/yachts/sea-ray-1.webp', '/activities/yachts/sea-ray-2.webp', '/activities/yachts/sea-ray-3.webp', '/activities/yachts/sea-ray-4.webp', '/activities/yachts/sea-ray-5.webp'],
    'Panjim, Goa', null, null,
    '[{"label": "Capacity", "value": "10 guests max"}, {"label": "Group Friendly", "value": "Yes"}, {"label": "Photography & Drone Photography", "value": "Allowed"}, {"label": "Language", "value": "English, Hindi"}]'::jsonb,
    'tiered',
    '[
      {"tier_name": "2hr Package", "description": "1 hour of sailing plus a 1-hour stop along the way.", "price": {"display_price": 16000}},
      {"tier_name": "1hr Package", "description": "A straight 1-hour sailing trip, no stop.", "price": {"display_price": 13000}}
    ]'::jsonb,
    'water', true
  ),
  (
    'yacht', 'prestige', 'Prestige',
    'Experience unparalleled luxury aboard the Prestige, a beautifully crafted private yacht for up to eight passengers. Sail the serene Goan waters while enjoying panoramic views, personalized service, and a fully air-conditioned cabin.',
    '["Beautifully crafted private yacht", "Spacious deck seating", "2 package options — short sail or extended trip with a stop", "Serene sailing along Goa''s coastline", "Great for private group outings"]'::jsonb,
    array['/activities/yachts/prestige-1.webp', '/activities/yachts/prestige-2.webp', '/activities/yachts/prestige-3.webp', '/activities/yachts/prestige-4.webp', '/activities/yachts/prestige-5.webp'],
    'Panjim, Goa', null, null,
    '[{"label": "Capacity", "value": "8 guests max"}, {"label": "Group Friendly", "value": "Yes"}, {"label": "Photography & Drone Photography", "value": "Allowed"}, {"label": "Language", "value": "English, Hindi"}]'::jsonb,
    'tiered',
    '[
      {"tier_name": "2hr Package", "description": "1 hour of sailing plus a 1-hour stop along the way.", "price": {"display_price": 17000}},
      {"tier_name": "1hr Package", "description": "A straight 1-hour sailing trip, no stop.", "price": {"display_price": 14000}}
    ]'::jsonb,
    'water', true
  ),
  (
    'yacht', 'funliner', 'FunLiner',
    'Get ready for the ultimate party on the Funliner, perfectly designed to host up to twelve guests. Enjoy expansive decks, a great sound system, and spectacular ocean views along the Goan coast.',
    '["Ideal for parties & celebrations", "Expansive deck space", "Great sound system onboard", "2 package options — short sail or extended trip with a stop", "Fits larger groups comfortably"]'::jsonb,
    array['/activities/yachts/funliner-1.webp', '/activities/yachts/funliner-2.webp', '/activities/yachts/funliner-3.webp', '/activities/yachts/funliner-4.webp', '/activities/yachts/funliner-5.webp'],
    'Panjim, Goa', null, null,
    '[{"label": "Capacity", "value": "12 guests max"}, {"label": "Group Friendly", "value": "Yes"}, {"label": "Photography & Drone Photography", "value": "Allowed"}, {"label": "Language", "value": "English, Hindi"}]'::jsonb,
    'tiered',
    '[
      {"tier_name": "2hr Package", "description": "1 hour of sailing plus a 1-hour stop along the way.", "price": {"display_price": 16000}},
      {"tier_name": "1hr Package", "description": "A straight 1-hour sailing trip, no stop.", "price": {"display_price": 13000}}
    ]'::jsonb,
    'water', true
  ),
  (
    'yacht', 'sunset-42', 'Sunset 42',
    'Step aboard the stunning Sunset 42, a magnificent luxury yacht crafted for up to fifteen guests. Sail Goa''s waters in style with spacious open decks, premium comfort, and unforgettable sunset views.',
    '["Sail Goa''s waters in style", "Spacious open deck areas", "2 package options — short sail or extended trip with a stop", "Comfortable for larger groups", "Great for sunset cruising & photos"]'::jsonb,
    array['/activities/yachts/sunset-42-1.webp', '/activities/yachts/sunset-42-2.webp', '/activities/yachts/sunset-42-3.webp', '/activities/yachts/sunset-42-4.webp', '/activities/yachts/sunset-42-5.webp'],
    'Panjim, Goa', null, null,
    '[{"label": "Capacity", "value": "15 guests max"}, {"label": "Group Friendly", "value": "Yes"}, {"label": "Photography & Drone Photography", "value": "Allowed"}, {"label": "Language", "value": "English, Hindi"}]'::jsonb,
    'tiered',
    '[
      {"tier_name": "2hr Package", "description": "1 hour of sailing plus a 1-hour stop along the way.", "price": {"display_price": 26000}},
      {"tier_name": "1hr Package", "description": "A straight 1-hour sailing trip, no stop.", "price": {"display_price": 23000}}
    ]'::jsonb,
    'water', true
  ),
  (
    'yacht', 'orca', 'Orca',
    'Celebrate your special moments on the stunning Orca, perfectly accommodating sixteen passengers. This premium yacht features a beautiful front deck, plush seating, and uninterrupted panoramic views of Goa''s spectacular coastal waters.',
    '["Perfect for special celebrations", "Premium onboard features", "2 package options — short sail or extended trip with a stop", "Spacious layout for larger groups", "Comfortable, stylish sailing experience"]'::jsonb,
    array['/activities/yachts/orca-1.webp', '/activities/yachts/orca-2.webp', '/activities/yachts/orca-3.webp', '/activities/yachts/orca-4.webp', '/activities/yachts/orca-5.webp'],
    'Panjim, Goa', null, null,
    '[{"label": "Capacity", "value": "16 guests max"}, {"label": "Group Friendly", "value": "Yes"}, {"label": "Photography & Drone Photography", "value": "Allowed"}, {"label": "Language", "value": "English, Hindi"}]'::jsonb,
    'tiered',
    '[
      {"tier_name": "2hr Package", "description": "1 hour of sailing plus a 1-hour stop along the way.", "price": {"display_price": 20000}},
      {"tier_name": "1hr Package", "description": "A straight 1-hour sailing trip, no stop.", "price": {"display_price": 17000}}
    ]'::jsonb,
    'water', true
  ),
  (
    'yacht', 'polaris', 'Polaris',
    'Host your grandest coastal celebrations aboard the magnificent Polaris. Comfortably accommodating twenty passengers, this massive luxury yacht offers stunning panoramic views, spacious lounging areas, and top-tier service across the beautiful Arabian Sea.',
    '["Built for grand coastal celebrations", "Massive luxury interior & deck space", "2 package options — short sail or extended trip with a stop", "Comfortably fits large groups", "Premium onboard experience"]'::jsonb,
    array['/activities/yachts/polaris-1.webp', '/activities/yachts/polaris-2.webp', '/activities/yachts/polaris-3.webp', '/activities/yachts/polaris-4.webp', '/activities/yachts/polaris-5.webp'],
    'Panjim, Goa', null, null,
    '[{"label": "Capacity", "value": "20 guests max"}, {"label": "Group Friendly", "value": "Yes"}, {"label": "Photography & Drone Photography", "value": "Allowed"}, {"label": "Language", "value": "English, Hindi"}]'::jsonb,
    'tiered',
    '[
      {"tier_name": "2hr Package", "description": "1 hour of sailing plus a 1-hour stop along the way.", "price": {"display_price": 33000}},
      {"tier_name": "1hr Package", "description": "A straight 1-hour sailing trip, no stop.", "price": {"display_price": 30000}}
    ]'::jsonb,
    'water', true
  ),
  (
    'yacht', 'shantam-luxury', 'Shantam Luxury',
    'Step aboard the magnificent Shantam Luxury yacht, perfectly crafted to host up to twenty-five guests. Enjoy lavish entertainment spaces, expansive open decks, and ultimate premium comfort while cruising Goa''s spectacular Arabian Sea.',
    '["Lavish entertainment spaces onboard", "Crafted for large group experiences", "2 package options — short sail or extended trip with a stop", "Fits big groups comfortably", "Premium luxury finish throughout"]'::jsonb,
    array['/activities/yachts/shantam-luxury-1.webp', '/activities/yachts/shantam-luxury-2.webp', '/activities/yachts/shantam-luxury-3.webp', '/activities/yachts/shantam-luxury-4.webp', '/activities/yachts/shantam-luxury-5.webp'],
    'Panjim, Goa', null, null,
    '[{"label": "Capacity", "value": "25 guests max"}, {"label": "Group Friendly", "value": "Yes"}, {"label": "Photography & Drone Photography", "value": "Allowed"}, {"label": "Language", "value": "English, Hindi"}]'::jsonb,
    'tiered',
    '[
      {"tier_name": "2hr Package", "description": "1 hour of sailing plus a 1-hour stop along the way.", "price": {"display_price": 31000}},
      {"tier_name": "1hr Package", "description": "A straight 1-hour sailing trip, no stop.", "price": {"display_price": 28000}}
    ]'::jsonb,
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
