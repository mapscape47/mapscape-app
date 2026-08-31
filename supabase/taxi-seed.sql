-- New Taxi category. Single flat list page (no per-car detail page), since
-- there's only one taxi contact who arranges cars anywhere in Goa. Reuses
-- the existing `listings` table with no schema changes — Capacity is
-- carried in the existing quick_answers field and read directly by the
-- new taxi card component.
-- Run this once in the Supabase SQL Editor against the live database.

insert into public.listings (
  activity_category, slug, name, quick_answers, pricing_type, pricing_data, contact_type, is_active
)
values
  (
    'taxi',
    'sample-swift-dzire',
    '[TEST] Swift Dzire',
    '[{"label": "Capacity", "value": "4 Seater"}]'::jsonb,
    'single',
    '{"price": {"display_price": 14}}'::jsonb,
    'land',
    true
  ),
  (
    'taxi',
    'sample-ertiga',
    '[TEST] Ertiga',
    '[{"label": "Capacity", "value": "6 Seater"}]'::jsonb,
    'single',
    '{"price": {"display_price": 17, "original_price": 20}}'::jsonb,
    'land',
    true
  ),
  (
    'taxi',
    'sample-innova',
    '[TEST] Innova',
    '[{"label": "Capacity", "value": "7 Seater"}]'::jsonb,
    'single',
    '{"price": {"display_price": 20}}'::jsonb,
    'land',
    true
  );
