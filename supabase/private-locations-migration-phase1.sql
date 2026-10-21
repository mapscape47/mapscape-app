-- PHASE 1 (additive, non-destructive): creates the private location
-- table, copies every listing's current precise address/coordinates
-- into it, copies Salon & Spa's branch map links out of quick_answers
-- into it too, and adds a new PUBLIC area_name column populated for
-- every currently-real-data bookable listing.
--
-- Nothing is removed or cleared from `listings` in this file — run it,
-- confirm the data looks right (see the SELECT at the bottom), then a
-- separate phase 2 file will clear the precise public columns once
-- you confirm this worked. Restaurants/Cafe are untouched throughout
-- (their location_address stays exactly as-is, per instruction).

-- 1. Private table. RLS enabled with ZERO policies for anon/
-- authenticated = default deny. Only the service_role key (Supabase
-- Studio / SQL Editor, or a trusted backend later) can read this.
create table public.listing_locations (
  id uuid primary key default gen_random_uuid(),
  listing_id uuid not null references public.listings(id) on delete cascade,
  branch_label text,        -- null for single-location listings; set per branch for Salon & Spa
  address text,
  lat double precision,
  lng double precision,
  map_link text,
  created_at timestamptz not null default now()
);

alter table public.listing_locations enable row level security;

-- 2. Copy every listing's current address/coordinates in as-is (safe
-- to include restaurants/cafe too — this table isn't read by the
-- public site, it's just an archival copy; their public columns are
-- untouched either way).
insert into public.listing_locations (listing_id, address, lat, lng)
select id, location_address, location_lat, location_lng
from public.listings
where location_address is not null;

-- 3. Copy Salon & Spa's branch map links out of quick_answers (the
-- quick_answers entries themselves are left in place for now — removed
-- only in phase 2).
insert into public.listing_locations (listing_id, branch_label, map_link)
select l.id, substring(qa->>'label' from 9), qa->>'value'
from public.listings l, jsonb_array_elements(l.quick_answers) qa
where l.activity_category = 'salon-spa'
  and qa->>'label' like 'Branch: %';

-- 4. New public column: just a short, already-vague locality name.
alter table public.listings add column if not exists area_name text;

-- 5. Populate area_name for every listing from a real data import so
-- far (booking-flow categories only — restaurants/cafe/salon-spa don't
-- use this field in the UI and are left null; anything not listed
-- here, e.g. Villa/Parasailing/Clubs placeholders, simply shows no
-- Location section until their own real-data import sets it).
update public.listings set area_name = 'Panjim' where activity_category = 'yacht';
update public.listings set area_name = 'Bicholim' where activity_category = 'quad-biking' and slug = 'bicholim-atv';
update public.listings set area_name = 'Bogmalo' where activity_category = 'quad-biking' and slug = 'bogmalo-atv';
update public.listings set area_name = 'Panjim' where activity_category = 'boat-cruise';
update public.listings set area_name = 'Calangute' where activity_category = 'land-casino' and slug = 'atlantiz-casino';
update public.listings set area_name = 'Panjim' where activity_category = 'boat-casino';
update public.listings set area_name = 'Vadaval' where activity_category = 'bungee-jumping' and slug = 'latambarcem-bungee-jumping';
update public.listings set area_name = 'Mayem' where activity_category = 'bungee-jumping' and slug = 'mayem-bungee-jumping';
update public.listings set area_name = 'Calangute' where activity_category = 'jet-ski' and slug = 'calangute-jet-ski';
update public.listings set area_name = 'Baga' where activity_category = 'kayaking' and slug = 'baga-kayaking';
update public.listings set area_name = 'Moira' where activity_category = 'kayaking' and slug = 'moira-kayaking';
update public.listings set area_name = 'Colva' where activity_category = 'kayaking' and slug = 'colva-kayaking';
update public.listings set area_name = 'Mollem' where activity_category = 'waterfall' and slug = 'dudhsagar';
update public.listings set area_name = 'Siquerim' where activity_category = 'boat-trip' and slug = 'dolphin-trip';
update public.listings set area_name = 'Arambol' where activity_category = 'wakeboard-surfing' and slug = 'arambol-surfing';
update public.listings set area_name = 'Vasco da Gama' where activity_category = 'scuba' and slug = 'full-day-dive';

-- Review before approving phase 2:
-- select id, listing_id, branch_label, address, lat, lng, map_link from public.listing_locations order by listing_id;
-- select activity_category, slug, name, area_name, location_address from public.listings where area_name is not null order by activity_category, slug;
