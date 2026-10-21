-- Phase 2 of the location-privacy migration stripped the WHOLE
-- "Branch: <name>" quick_answers entry for Salon & Spa, not just the
-- map link inside it — so the branch names themselves (e.g.
-- "Candolim", "Calangute") are no longer anywhere in the public data.
-- This restores just the name, with no map link, address, or
-- coordinates — those stay only in the private listing_locations
-- table, exactly as agreed.

update public.listings
set quick_answers = quick_answers || '[
  {"label": "Branch: Candolim", "value": "Candolim"},
  {"label": "Branch: Calangute", "value": "Calangute"},
  {"label": "Branch: Arpora", "value": "Arpora"},
  {"label": "Branch: Siolim", "value": "Siolim"}
]'::jsonb
where activity_category = 'salon-spa' and slug = 'anriz-salon-nail-studio';

update public.listings
set quick_answers = quick_answers || '[
  {"label": "Branch: Arpora", "value": "Arpora"},
  {"label": "Branch: Panjim", "value": "Panjim"},
  {"label": "Branch: Margao", "value": "Margao"}
]'::jsonb
where activity_category = 'salon-spa' and slug = 'kns-katusha-nail-studio';
