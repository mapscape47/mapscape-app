-- Real Jet Ski data import (replaces the placeholder test listing
-- from jet-ski-seed.sql). Idempotent: upserts by (activity_category,
-- slug), safe to run twice. No code changes needed — /jet-ski and
-- /jet-ski/[slug] already render through the standard shared
-- templates, pricing_type "single" producing "Hi Mapscape, I would
-- like to book Calangute Jet Ski." with no option suffix.
--
-- Name capitalized from the sheet's "Calangute jet ski" to
-- "Calangute Jet Ski" for title-case consistency with every other
-- listing. No vendor/operator name in the sheet at all.

update public.activities
set image_urls = array[
  '/activities/jet-ski/category-1.webp',
  '/activities/jet-ski/category-2.webp',
  '/activities/jet-ski/category-3.webp',
  '/activities/jet-ski/category-4.webp',
  '/activities/jet-ski/category-5.webp'
]
where slug = 'jet-ski';

insert into public.listings (
  activity_category, slug, name, description, overview_points, photos,
  location_address, location_lat, location_lng,
  quick_answers, pricing_type, pricing_data, contact_type, is_active
)
values (
  'jet-ski', 'calangute-jet-ski', 'Calangute Jet Ski',
  'Experience the ultimate adrenaline rush with our Calangute Jet Ski ride. Zip across the vibrant coastal waters on high-powered watercraft under the strict supervision of trained professionals. Perfect for both beginners and experienced riders looking for an unforgettable, fast-paced ocean adventure.',
  '["High-speed thrill on the Arabian Sea, safe for beginners, guided by certified water sports instructors."]'::jsonb,
  array['/activities/jet-ski/calangute-jet-ski-1.webp', '/activities/jet-ski/calangute-jet-ski-2.webp', '/activities/jet-ski/calangute-jet-ski-3.webp', '/activities/jet-ski/calangute-jet-ski-4.webp', '/activities/jet-ski/calangute-jet-ski-5.webp'],
  'Calangute, Goa', null, null,
  '[{"label": "Duration", "value": "10-15 minutes"}, {"label": "Inclusions", "value": "Mandatory life jacket and safety briefing"}, {"label": "Best Time", "value": "Early morning or late afternoon"}]'::jsonb,
  'single',
  '{"price": {"display_price": 600}}'::jsonb,
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
