-- Mapscape CRM schema
-- Run this in the Supabase SQL Editor (see AGENTS.md / project chat history for the walkthrough).

create table public.vendors (
  id uuid primary key default gen_random_uuid(),
  name text not null,
  contact_phone text,
  commission_type text not null check (commission_type in ('percentage', 'fixed')),
  commission_value numeric not null,
  notes text
);

create table public.activities (
  id uuid primary key default gen_random_uuid(),
  name text not null,
  slug text not null unique,
  category text not null check (category in ('water', 'land', 'nature')),
  description text,
  price_tiers jsonb not null default '[]'::jsonb,
  vendor_id uuid references public.vendors(id) on delete set null,
  image_url text,
  image_urls text[] not null default '{}',
  is_active boolean not null default true
);

create table public.leads (
  id uuid primary key default gen_random_uuid(),
  activity_id uuid not null references public.activities(id) on delete restrict,
  status text not null default 'New' check (status in ('New', 'Contacted', 'Booked', 'Completed', 'Paid Out')),
  source_location text,
  scanned_at timestamptz,
  customer_name text,
  customer_phone text,
  notes text,
  created_at timestamptz not null default now()
);

create table public.bookings (
  id uuid primary key default gen_random_uuid(),
  lead_id uuid not null references public.leads(id) on delete restrict,
  amount_total numeric not null,
  amount_collected_upfront numeric not null default 0,
  amount_due_at_venue numeric not null default 0,
  vendor_commission_amount numeric not null default 0,
  vendor_payout_status text not null default 'Pending' check (vendor_payout_status in ('Pending', 'Paid')),
  invoice_number text unique,
  booking_date date,
  created_at timestamptz not null default now()
);

create table public.scans (
  id uuid primary key default gen_random_uuid(),
  activity_id uuid not null references public.activities(id) on delete restrict,
  source_location text,
  scanned_at timestamptz not null default now()
);

-- Non-commission tourist spots (forts, waterfalls, viewpoints). Separate
-- from activities since they carry no pricing/vendor/booking data — just
-- enough to render a landing page with a "Get Directions" link.
create table public.attractions (
  id uuid primary key default gen_random_uuid(),
  name text not null,
  slug text not null unique,
  description text,
  latitude double precision not null,
  longitude double precision not null,
  image_urls text[] not null default '{}',
  is_active boolean not null default true
);

-- Level 3 detail pages nested under a Level 2 activity/attraction page
-- (e.g. /scuba/full-day-dive). One reusable template drives all of these
-- regardless of category — pricing_type picks which of the three booking
-- layouts renders, and quick_answers is free-form so each category can
-- show whatever fields make sense for it (capacity/language for tours,
-- bedrooms/bathrooms for villas, etc.) with no schema change.
create table public.listings (
  id uuid primary key default gen_random_uuid(),
  activity_category text not null,
  slug text not null,
  name text not null,
  description text,
  overview_points jsonb,
  photos text[] not null default '{}',
  location_address text,
  location_lat double precision,
  location_lng double precision,
  quick_answers jsonb not null default '[]'::jsonb,
  pricing_type text not null check (pricing_type in ('single', 'tiered', 'multi_service')),
  -- pricing_data shape depends on pricing_type. Every price is always an
  -- object { display_price, original_price? } — when original_price is
  -- present and greater than display_price, the UI shows it struck
  -- through next to display_price.
  --   single:        { price: PriceObject, tier_name? }
  --   tiered:        [{ tier_name, description?, price: PriceObject }]
  --   multi_service: [{ service_name, description?, price: PriceObject }]
  pricing_data jsonb not null,
  contact_type text not null check (contact_type in ('water', 'land')),
  is_active boolean not null default true,
  unique (activity_category, slug)
);

-- Row Level Security: enabled with no policies, so the public/publishable
-- key has zero access via the REST API. All access goes through the
-- service_role (secret) key from trusted server-side code, which bypasses
-- RLS entirely. Add scoped policies later if the client ever needs to
-- query these tables directly with a logged-in admin session.
alter table public.vendors enable row level security;
alter table public.activities enable row level security;
alter table public.leads enable row level security;
alter table public.bookings enable row level security;
alter table public.scans enable row level security;
alter table public.attractions enable row level security;
alter table public.listings enable row level security;

-- The public QR-code landing pages (mapscape.app/<slug>) need to read
-- activity/attraction/listing details with no logged-in user, so these
-- narrow policies open read access to just the active rows via the
-- publishable key. vendors/leads/bookings/scans stay fully locked to the
-- service_role key.
create policy "Public can view active activities"
on public.activities
for select
to anon, authenticated
using (is_active = true);

create policy "Public can view active attractions"
on public.attractions
for select
to anon, authenticated
using (is_active = true);

create policy "Public can view active listings"
on public.listings
for select
to anon, authenticated
using (is_active = true);
