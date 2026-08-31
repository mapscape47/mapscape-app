-- New Boat Trip category. Structurally identical to /waterfall — single
-- price, list -> detail, reusing the shared CategoryPageView/ListingPageView
-- templates unchanged. Currently one listing (Dolphin Trip); more boat trip
-- types can be added later as plain rows, no code changes needed.
--
-- Seeded active so the structure can be reviewed on the live pages first —
-- run supabase/deactivate-boat-trip-dolphin-trip.sql right after reviewing
-- to take it back to inactive/placeholder status until real content is sent.

insert into public.activities (name, slug, category, description, is_active)
values (
  'Boat Trip',
  'boat-trip',
  'water',
  'Head out on the water for a scenic boat trip around Goa''s coastline.',
  true
);

insert into public.listings (
  activity_category, slug, name, description, overview_points, quick_answers,
  pricing_type, pricing_data, contact_type, is_active
)
values (
  'boat-trip',
  'dolphin-trip',
  'Dolphin Trip',
  'Placeholder description — real content to follow. A boat ride out to Goa''s coastal waters for a chance to spot dolphins in their natural habitat.',
  '["Placeholder: trip duration", "Placeholder: best time to spot dolphins", "Placeholder: boat type", "Placeholder: life jackets included"]'::jsonb,
  '[{"label": "Capacity", "value": "Placeholder"}, {"label": "Group Friendly", "value": "Placeholder"}, {"label": "Photography", "value": "Placeholder"}, {"label": "Language", "value": "Placeholder"}]'::jsonb,
  'single',
  '{"price": {"display_price": 999}}'::jsonb,
  'water',
  true
);
