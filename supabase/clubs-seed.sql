-- New Clubs category. Reuses the plain shared CategoryPageView/
-- ListingPageView templates unchanged — tiered pricing (2 tiers), same
-- pattern as /scuba or /yacht. No PDF menu section, since that's only
-- ever rendered for Restaurants/Cafe via their own dedicated components.
-- bookingMessage() already produces the exact "... - [Tier Name]." format
-- requested, so no code changes are needed.

insert into public.activities (name, slug, category, description, is_active)
values (
  'Clubs',
  'clubs',
  'land',
  'Goa''s best nightlife — dance floors, live DJs, and late-night entry to the clubs everyone''s talking about.',
  true
);

insert into public.listings (
  activity_category, slug, name, description, overview_points, quick_answers,
  pricing_type, pricing_data, contact_type, is_active
)
values (
  'clubs',
  'sample-club-nova',
  '[TEST] Club Nova',
  'A high-energy club with a full sound system, resident DJs, and a dance floor that stays packed till close.',
  '["Music: House, EDM, Bollywood", "Smart casual dress code", "Age requirement: 21+", "Open till 4 AM"]'::jsonb,
  '[{"label": "Timings", "value": "9 PM - 4 AM"}, {"label": "Group Friendly", "value": "Yes"}, {"label": "Photography", "value": "Allowed"}, {"label": "Language", "value": "English, Hindi"}]'::jsonb,
  'tiered',
  '[
    {"tier_name": "Couple Entry", "price": {"display_price": 1500, "original_price": 2000}},
    {"tier_name": "Stag Entry", "price": {"display_price": 2500}}
  ]'::jsonb,
  'land',
  true
);
