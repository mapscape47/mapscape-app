-- PHASE 2 (destructive on the PUBLIC columns only — run this ONLY
-- after confirming phase 1's listing_locations table and area_name
-- column look correct). Nothing in listing_locations is touched or
-- lost by this file; it only clears the now-redundant precise fields
-- from the public listings table.
--
-- Restaurants/Cafe are explicitly excluded — their Level 3 page still
-- reads location_address/lat/lng directly (no booking flow to gate
-- the exact place behind), so their data must stay exactly as-is.

-- 1. Clear the precise address/coordinates from every booking-flow
-- listing. Safe for every other category too (Rental/Taxi never had
-- these set; Villa/Parasailing/Clubs/Scuba's test rows have no
-- area_name yet either way and no code path reads this field for them
-- anymore after the Step 1 UI change).
update public.listings
set location_address = null,
    location_lat = null,
    location_lng = null
where activity_category not in ('restaurants', 'cafe');

-- 2. Strip Salon & Spa's "Branch: <name>" map-link entries out of
-- quick_answers (the branch area names themselves are already shown
-- publicly via area_name-style plain text in the UI, derived straight
-- from the label — only the map link in `value` is being removed here).
update public.listings l
set quick_answers = coalesce(
  (
    select jsonb_agg(qa)
    from jsonb_array_elements(l.quick_answers) qa
    where not (qa->>'label' like 'Branch: %')
  ),
  '[]'::jsonb
)
where l.activity_category = 'salon-spa';

-- Verify after running:
-- select activity_category, slug, location_address, location_lat, location_lng from public.listings where activity_category not in ('restaurants','cafe');
-- (every row above should show null/null/null)
-- select activity_category, slug, quick_answers from public.listings where activity_category = 'salon-spa';
-- (quick_answers should have no "Branch: ..." entries left)
