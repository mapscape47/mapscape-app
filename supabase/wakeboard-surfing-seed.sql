-- New Wakeboard Surfing category. Structurally identical to /salon-spa —
-- multi_service pricing, reusing the shared CategoryPageView/ListingPageView/
-- PricingSection templates unchanged. The shared multi_service branch in
-- PricingSection.tsx already produces the exact WhatsApp format requested
-- ("Hi Mapscape, I would like to book {service} at {listing}."), so no code
-- changes are needed.
--
-- The shared PriceTierCard has no dedicated location field (same constraint
-- hit building Kayaking), so location is folded into the listing name.

insert into public.activities (name, slug, category, description, is_active)
values (
  'Wakeboard Surfing',
  'wakeboard-surfing',
  'water',
  'Ride the wake — cable wakeboarding, boots and strap boards, and full beginner-to-pro packages on Goa''s backwaters.',
  true
);

insert into public.listings (
  activity_category, slug, name, description, overview_points, quick_answers,
  pricing_type, pricing_data, contact_type, is_active
)
values (
  'wakeboard-surfing',
  'sample-101-wakepark',
  '[TEST] 101 Wakepark - Calangute',
  'A cable wakepark on Goa''s backwaters, with rides and packages for total beginners through to seasoned riders.',
  '["Beginner-friendly, no experience required", "No swimming skills needed — life jackets provided", "Coached sessions with certified instructors"]'::jsonb,
  '[{"label": "Capacity", "value": "Placeholder"}, {"label": "Group Friendly", "value": "Placeholder"}, {"label": "Photography", "value": "Placeholder"}, {"label": "Language", "value": "Placeholder"}]'::jsonb,
  'multi_service',
  '[
    {"service_name": "10-Min Ride (Strap Board)", "price": {"display_price": 800}},
    {"service_name": "10-Min Ride (Boots Board)", "price": {"display_price": 1000}},
    {"service_name": "Fun Body Drag (3 Drags, No Board)", "price": {"display_price": 500, "original_price": 700}},
    {"service_name": "Wakeboarding From Zero (Beginner Package)", "price": {"display_price": 2500}},
    {"service_name": "Multi-Day Bootcamp (3 Day / 2 Night, All-Inclusive)", "price": {"display_price": 12000}}
  ]'::jsonb,
  'water',
  true
);
