-- Real Parasailing data import (replaces the placeholder test
-- listing from parasailing-seed.sql). Idempotent: upserts by
-- (activity_category, slug), safe to run twice. No code changes
-- needed — /parasailing and /parasailing/[slug] already render
-- through the standard shared templates, pricing_type "single"
-- producing "Hi Mapscape, I would like to book Calangute
-- Parasailing." with no option suffix. No vendor/operator name in
-- the sheet at all. No discount pricing in the sheet.

update public.activities
set image_urls = array[
  '/activities/parasailing/category-1.webp',
  '/activities/parasailing/category-2.webp',
  '/activities/parasailing/category-3.webp',
  '/activities/parasailing/category-4.webp',
  '/activities/parasailing/category-5.webp'
]
where slug = 'parasailing';

insert into public.listings (
  activity_category, slug, name, description, overview_points, photos,
  area_name, quick_answers, pricing_type, pricing_data, contact_type, is_active
)
values (
  'parasailing', 'calangute-parasailing', 'Calangute Parasailing',
  'Soar high above the sparkling waters of the Arabian Sea with the Calangute Parasailing experience. Towed securely behind a custom-built winch boat, you will experience the ultimate rush of flying while taking in panoramic, bird''s-eye views of Goa''s most famous coastline. Professionally managed with top-tier safety equipment, it is an unforgettable adventure that lets you experience the beach from a completely new perspective.',
  '["Breathtaking aerial views of the Goan coastline", "Thrilling winch-boat parasailing experience", "Safe for beginners and non-swimmers"]'::jsonb,
  array['/activities/parasailing/calangute-parasailing-1.webp', '/activities/parasailing/calangute-parasailing-2.webp', '/activities/parasailing/calangute-parasailing-3.webp', '/activities/parasailing/calangute-parasailing-4.webp', '/activities/parasailing/calangute-parasailing-5.webp'],
  'Calangute',
  '[{"label": "Duration", "value": "3-5 minutes in the air (approx. 20-30 minutes total boat ride)"}, {"label": "Inclusions", "value": "Safety harness, life jacket, and optional ''dip'' in the sea"}]'::jsonb,
  'single',
  '{"price": {"display_price": 2000}}'::jsonb,
  'water', true
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
