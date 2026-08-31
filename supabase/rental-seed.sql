-- New Rental category (Bike + Car). Structurally different from every other
-- category: /rental is a binary-choice landing page (no DB row needed), and
-- /rental/bike and /rental/car are self-contained card lists with no
-- per-vehicle detail page — so these reuse the existing `listings` table
-- with no schema changes. Transmission/Seating Capacity are carried in the
-- existing quick_answers field and read directly by the new rental card
-- component (not rendered via the standard Quick Answers block, since
-- rental cards aren't full Level 3 detail pages).
-- Run this once in the Supabase SQL Editor against the live database.

insert into public.listings (
  activity_category, slug, name, quick_answers, pricing_type, pricing_data, contact_type, is_active
)
values
  (
    'rental-bike',
    'sample-honda-activa',
    '[TEST] Honda Activa',
    '[{"label": "Transmission", "value": "Automatic"}]'::jsonb,
    'single',
    '{"price": {"display_price": 400}}'::jsonb,
    'land',
    true
  ),
  (
    'rental-bike',
    'sample-royal-enfield-classic-350',
    '[TEST] Royal Enfield Classic 350',
    '[{"label": "Transmission", "value": "Manual"}]'::jsonb,
    'single',
    '{"price": {"display_price": 900, "original_price": 1100}}'::jsonb,
    'land',
    true
  ),
  (
    'rental-car',
    'sample-maruti-swift',
    '[TEST] Maruti Swift',
    '[{"label": "Transmission", "value": "Automatic"}, {"label": "Seating Capacity", "value": "5 Seater"}]'::jsonb,
    'single',
    '{"price": {"display_price": 1500, "original_price": 1800}}'::jsonb,
    'land',
    true
  ),
  (
    'rental-car',
    'sample-toyota-innova',
    '[TEST] Toyota Innova',
    '[{"label": "Transmission", "value": "Manual"}, {"label": "Seating Capacity", "value": "7 Seater"}]'::jsonb,
    'single',
    '{"price": {"display_price": 2500}}'::jsonb,
    'land',
    true
  );
