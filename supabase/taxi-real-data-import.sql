-- Real Taxi data import (replaces the placeholder test rows from
-- taxi-seed.sql). Idempotent: upserts by (activity_category, slug),
-- safe to run twice. No code changes needed — /taxi already renders
-- through TaxiPageView/TaxiCarCard, reading a "Capacity" quick_answer
-- and a hardcoded "/km" price suffix. "Type of Vehicle" (MPV/Sedan/
-- Hatchback) has no rendering slot in the current card, so it's
-- omitted (same as noted when this category was first built). No
-- vendor/company name in the sheet, only car model names.

update public.activities
set image_urls = array[
  '/activities/taxi/category-1.webp',
  '/activities/taxi/category-2.webp',
  '/activities/taxi/category-3.webp',
  '/activities/taxi/category-4.webp',
  '/activities/taxi/category-5.webp'
]
where slug = 'taxi';

insert into public.listings (
  activity_category, slug, name, photos, quick_answers, pricing_type, pricing_data, contact_type, is_active
)
values
  (
    'taxi', 'maruti-suzuki-ertiga', 'Maruti Suzuki Ertiga',
    array['/activities/taxi/maruti-suzuki-ertiga-1.webp'],
    '[{"label": "Capacity", "value": "6 Seater"}]'::jsonb,
    'single', '{"price": {"display_price": 55}}'::jsonb, 'land', true
  ),
  (
    'taxi', 'toyota-innova', 'Toyota Innova',
    array['/activities/taxi/toyota-innova-1.webp'],
    '[{"label": "Capacity", "value": "6 Seater"}]'::jsonb,
    'single', '{"price": {"display_price": 65}}'::jsonb, 'land', true
  ),
  (
    'taxi', 'toyota-innova-crysta', 'Toyota Innova Crysta',
    array['/activities/taxi/toyota-innova-crysta-1.webp'],
    '[{"label": "Capacity", "value": "6 Seater"}]'::jsonb,
    'single', '{"price": {"display_price": 75}}'::jsonb, 'land', true
  ),
  (
    'taxi', 'maruti-suzuki-swift-dzire', 'Maruti Suzuki Swift Dzire',
    array['/activities/taxi/maruti-suzuki-swift-dzire-1.webp'],
    '[{"label": "Capacity", "value": "4 Seater"}]'::jsonb,
    'single', '{"price": {"display_price": 50}}'::jsonb, 'land', true
  ),
  (
    'taxi', 'maruti-suzuki-baleno', 'Maruti Suzuki Baleno',
    array['/activities/taxi/maruti-suzuki-baleno-1.webp'],
    '[{"label": "Capacity", "value": "4 Seater"}]'::jsonb,
    'single', '{"price": {"display_price": 40}}'::jsonb, 'land', true
  )
on conflict (activity_category, slug) do update set
  name = excluded.name,
  photos = excluded.photos,
  quick_answers = excluded.quick_answers,
  pricing_type = excluded.pricing_type,
  pricing_data = excluded.pricing_data,
  contact_type = excluded.contact_type,
  is_active = excluded.is_active;
