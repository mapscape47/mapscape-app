-- Real Boat Casino data import (replaces the placeholder test listing
-- from boat-casino-seed.sql). Idempotent: upserts by
-- (activity_category, slug), safe to run twice.
--
-- No code changes required — /boat-casino and /boat-casino/[slug]
-- already render through the standard shared
-- CategoryPageView/ListingPageView, same tiered pattern as Land
-- Casino, and pricing_type "tiered" already produces
-- "Hi Mapscape, I would like to book [Name] - [Tier]." for each tier's
-- own Book Now button.
--
-- Only the 2 partnered casinos from the sheet are imported (Big Daddy,
-- Deltin Royale). The sheet's "Deltin Royale/Deltin Jaqk" name is
-- shortened to "Deltin Royale". No other casino appears in the sheet,
-- so nothing else was considered. No vendor/operator name beyond each
-- casino's own name appears in any description or highlight.

update public.activities
set image_urls = array[
  '/activities/boat-casino/category-1.webp',
  '/activities/boat-casino/category-2.webp',
  '/activities/boat-casino/category-3.webp',
  '/activities/boat-casino/category-4.webp',
  '/activities/boat-casino/category-5.webp'
]
where slug = 'boat-casino';

insert into public.listings (
  activity_category, slug, name, description, overview_points, photos,
  location_address, location_lat, location_lng,
  quick_answers, pricing_type, pricing_data, contact_type, is_active
)
values
  (
    'boat-casino', 'big-daddy', 'Big Daddy',
    'A high-energy floating casino on the Mandovi River, offering gaming tables, live entertainment, and dining across multiple decks — one of Goa''s most popular offshore nightlife experiences.',
    '["3 gaming levels with 100+ tables and 900+ gaming positions", "VIP and high-stakes zones available", "Live music, dance performances, and DJ sets", "Multi-cuisine buffet and bar included in packages", "Kids'' zone available for families"]'::jsonb,
    array['/activities/boat-casino/big-daddy-1.webp', '/activities/boat-casino/big-daddy-2.webp', '/activities/boat-casino/big-daddy-3.webp', '/activities/boat-casino/big-daddy-4.webp', '/activities/boat-casino/big-daddy-5.webp'],
    'Panjim, Goa (boarding via jetty)', null, null,
    '[{"label": "Group Friendly", "value": "Yes"}, {"label": "Photography", "value": "Allowed (check onboard restrictions in gaming areas)"}, {"label": "Language", "value": "English, Hindi"}, {"label": "Age Requirement", "value": "21+"}, {"label": "Timings", "value": "Open 24 hours"}]'::jsonb,
    'tiered',
    '[
      {"tier_name": "Signature", "description": "Standard gaming chips, main floor access, buffet included.", "price": {"display_price": 4000}},
      {"tier_name": "Premium", "description": "Higher chip value, premium table access, select drinks included.", "price": {"display_price": 5000}},
      {"tier_name": "VIP", "description": "Top chip value, VIP zone access, premium dining & drinks.", "price": {"display_price": 6000}}
    ]'::jsonb,
    'water', true
  ),
  (
    'boat-casino', 'deltin-royale', 'Deltin Royale',
    'Asia''s largest offshore casino, spread across multiple decks on the Mandovi River. Deltin Royale combines premium gaming with live entertainment and fine dining for a complete night out.',
    '["50,000+ sq ft gaming floor, 900+ gaming positions", "Live Bollywood & international entertainment nightly", "Dinner included in every package", "Games include Roulette, Blackjack, Baccarat, Poker & more", "Operates 24 hours"]'::jsonb,
    array['/activities/boat-casino/deltin-royale-1.webp', '/activities/boat-casino/deltin-royale-2.webp', '/activities/boat-casino/deltin-royale-3.webp', '/activities/boat-casino/deltin-royale-4.webp', '/activities/boat-casino/deltin-royale-5.webp'],
    'Panjim, Goa (boarding via Fisheries Jetty)', null, null,
    '[{"label": "Group Friendly", "value": "Yes"}, {"label": "Photography", "value": "Allowed"}, {"label": "Language", "value": "English, Hindi"}, {"label": "Age Requirement", "value": "21+"}, {"label": "Timings", "value": "Open 24 hours"}]'::jsonb,
    'tiered',
    '[
      {"tier_name": "Classic", "description": "House-brand drinks, dinner included.", "price": {"display_price": 4400}},
      {"tier_name": "Premium", "description": "Premium drinks, dinner + ₹2,000 gaming tokens.", "price": {"display_price": 4900}},
      {"tier_name": "Elite", "description": "Top-shelf drinks, dinner + ₹2,000 gaming tokens.", "price": {"display_price": 5900}}
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
