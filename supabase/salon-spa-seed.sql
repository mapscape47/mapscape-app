-- New Salon & Spa category, using the existing shared Level 2/Level 3
-- templates unchanged. Only one placeholder test listing — real salon/spa
-- vendor data and service menus to be provided separately once confirmed.
-- Run this once in the Supabase SQL Editor against the live database.

insert into public.activities (name, slug, category, description, is_active)
values (
  'Salon & Spa',
  'salon-spa',
  'land',
  'Unwind with a massage, facial, or full spa day at Goa''s best salons — a relaxed way to recharge between beach days.',
  true
);

insert into public.listings (
  activity_category, slug, name, description, overview_points, photos,
  location_address, location_lat, location_lng,
  quick_answers, pricing_type, pricing_data, contact_type, is_active
)
values (
  'salon-spa',
  'sample-salon-spa',
  '[TEST] Sample Salon & Spa',
  'A placeholder salon & spa listing used to verify the multi-service pricing layout with discount pricing. Replace with real vendor data and service menu once confirmed.',
  '[
    "Calm, air-conditioned ambience",
    "Trained, experienced therapists",
    "High hygiene standards — fresh linens per session",
    "Walk-ins welcome, appointments recommended"
  ]'::jsonb,
  '{}',
  'Calangute Main Road, Goa',
  15.5438,
  73.7553,
  '[
    {"label": "Group Friendly", "value": "Yes"},
    {"label": "Language", "value": "English, Hindi"}
  ]'::jsonb,
  'multi_service',
  '[
    {
      "service_name": "Swedish Massage (60 min)",
      "price": {"display_price": 2500, "original_price": 3000}
    },
    {
      "service_name": "Classic Manicure",
      "price": {"display_price": 800}
    },
    {
      "service_name": "Classic Pedicure",
      "price": {"display_price": 900}
    },
    {
      "service_name": "Facial Cleanup",
      "price": {"display_price": 1200}
    }
  ]'::jsonb,
  'land',
  true
);
