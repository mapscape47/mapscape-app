-- New Waterfall category. Structurally identical to /quad-biking — single
-- price, list -> detail, reusing the shared CategoryPageView/ListingPageView
-- templates unchanged. Currently one year-round listing (Dudhsagar); more
-- seasonal waterfall listings can be added/deactivated later as plain rows,
-- no code changes needed.
--
-- Seeded active so the structure can be reviewed on the live pages first —
-- run supabase/deactivate-waterfall-dudhsagar.sql right after reviewing to
-- take it back to inactive/placeholder status until real content is sent.

insert into public.activities (name, slug, category, description, is_active)
values (
  'Waterfalls',
  'waterfall',
  'water',
  'Chase Goa''s most scenic waterfalls, from the towering Dudhsagar Falls to seasonal monsoon cascades.',
  true
);

insert into public.listings (
  activity_category, slug, name, description, overview_points, quick_answers,
  pricing_type, pricing_data, contact_type, is_active
)
values (
  'waterfall',
  'dudhsagar',
  'Dudhsagar Waterfall',
  'Placeholder description — real content to follow. A trip to one of India''s tallest waterfalls, tucked inside the Bhagwan Mahavir Wildlife Sanctuary.',
  '["Placeholder: trek duration", "Placeholder: difficulty level", "Placeholder: best season to visit", "Placeholder: permit/entry requirements"]'::jsonb,
  '[{"label": "Capacity", "value": "Placeholder"}, {"label": "Group Friendly", "value": "Placeholder"}, {"label": "Photography", "value": "Placeholder"}, {"label": "Language", "value": "Placeholder"}]'::jsonb,
  'single',
  '{"price": {"display_price": 999}}'::jsonb,
  'water',
  true
);
