-- One-off migration: adds overview_points and consolidates scuba down to a
-- single ₹6,000 listing (removing the separate 5-Min Intro Dive row).
-- Run this once in the Supabase SQL Editor against the live database.

alter table public.listings add column if not exists overview_points jsonb;

delete from public.listings
where activity_category = 'scuba' and slug = '5-min-intro-dive';

-- Placeholder bullet copy — please review/replace with real copy.
update public.listings
set overview_points = '[
  "No prior diving experience needed",
  "PADI-certified instructors",
  "Full gear included",
  "Suitable for ages 10+",
  "Multiple dive sites around Grande Island"
]'::jsonb
where activity_category = 'scuba' and slug = 'full-day-dive';
