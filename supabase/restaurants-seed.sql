-- New Restaurants category. Informational only — no pricing/booking, so
-- the Level 2 cards omit price and the Level 3 page omits the Pricing &
-- Booking section in favor of a Menu section (PDF link). Requires the new
-- menu_pdf_url column below (run once against the live database; it's
-- also reflected in schema.sql for future reference).

alter table public.listings
  add column if not exists menu_pdf_url text;

-- Level 2 category row (same shape as every other category's activities row).
insert into public.activities (name, slug, category, description, is_active)
values (
  'Restaurants',
  'restaurants',
  'land',
  'Handpicked places to eat around Goa, from beach shacks to fine dining.',
  true
);

-- One test restaurant. menu_pdf_url points to a public sample PDF for
-- verification only — swap for a real uploaded menu (e.g. via Supabase
-- Storage) once real restaurant data is ready.
insert into public.listings (
  activity_category, slug, name, description, overview_points, quick_answers,
  pricing_type, pricing_data, contact_type, menu_pdf_url, is_active
)
values (
  'restaurants',
  'sample-beach-shack',
  '[TEST] Beach Shack',
  'A relaxed beachfront spot serving fresh seafood and classic Goan dishes with your toes in the sand.',
  '["Beachfront seating", "Fresh catch of the day", "Live music on weekends"]'::jsonb,
  '[{"label": "Cuisine Type", "value": "Goan, Seafood"}, {"label": "Timings", "value": "11 AM - 11 PM"}]'::jsonb,
  'single',
  '{"price": {"display_price": 0}}'::jsonb,
  'land',
  'https://www.w3.org/WAI/ER/tests/xhtml/testfiles/resources/pdf/dummy.pdf',
  true
);
