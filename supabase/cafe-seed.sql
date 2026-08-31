-- New Cafe category. Structurally identical to /restaurants — informational
-- only, no pricing/booking, reuses RestaurantListPageView/
-- RestaurantDetailPageView and the existing menu_pdf_url column/MenuSection
-- component (no schema change needed, that column already exists).

-- Level 2 category row (same shape as every other category's activities row).
insert into public.activities (name, slug, category, description, is_active)
values (
  'Cafes',
  'cafe',
  'land',
  'Cozy cafes around Goa for your morning coffee, brunch, or a quiet work session.',
  true
);

-- One test cafe. menu_pdf_url points to a public sample PDF for
-- verification only — swap for a real uploaded menu once real cafe data
-- is ready.
insert into public.listings (
  activity_category, slug, name, description, overview_points, quick_answers,
  pricing_type, pricing_data, contact_type, menu_pdf_url, is_active
)
values (
  'cafe',
  'sample-brew-and-bean',
  '[TEST] Brew & Bean',
  'A cozy, plant-filled cafe serving specialty coffee and all-day brunch, popular with the work-from-cafe crowd.',
  '["Specialty coffee bar", "Vegan-friendly menu", "Free WiFi and workspace seating"]'::jsonb,
  '[{"label": "Cuisine Type", "value": "Cafe, Continental"}, {"label": "Timings", "value": "8 AM - 8 PM"}]'::jsonb,
  'single',
  '{"price": {"display_price": 0}}'::jsonb,
  'land',
  'https://www.w3.org/WAI/ER/tests/xhtml/testfiles/resources/pdf/dummy.pdf',
  true
);
