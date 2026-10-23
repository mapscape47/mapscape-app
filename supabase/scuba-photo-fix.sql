-- Fixes the 3 of 4 scuba listings that were missing photos. Root cause:
-- the original scuba import converted and matched photos for only
-- Scuba Evolution India. "Goa Aquatics" and "Dive Goa" had exact-name
-- source photos that were simply never converted/assigned. "Goa
-- Diving"'s own source photos were named "Scuba Diving" (matching the
-- category, not the operator) and got used for the category-level
-- header slider instead — so Goa Diving's photos here are copies of
-- that same already-converted set, kept under their own filenames so
-- editing the category header later doesn't also change this listing.
-- Only updates these 3 rows in the scuba category — no other
-- category or table touched.

update public.listings
set photos = array[
  '/activities/scuba/goa-diving-1.webp',
  '/activities/scuba/goa-diving-2.webp',
  '/activities/scuba/goa-diving-3.webp',
  '/activities/scuba/goa-diving-4.webp',
  '/activities/scuba/goa-diving-5.webp'
]
where activity_category = 'scuba' and slug = 'goa-diving';

update public.listings
set photos = array[
  '/activities/scuba/goa-aquatics-1.webp',
  '/activities/scuba/goa-aquatics-2.webp',
  '/activities/scuba/goa-aquatics-3.webp',
  '/activities/scuba/goa-aquatics-4.webp',
  '/activities/scuba/goa-aquatics-5.webp'
]
where activity_category = 'scuba' and slug = 'goa-aquatics';

update public.listings
set photos = array[
  '/activities/scuba/dive-goa-1.webp',
  '/activities/scuba/dive-goa-2.webp',
  '/activities/scuba/dive-goa-3.webp',
  '/activities/scuba/dive-goa-4.webp',
  '/activities/scuba/dive-goa-5.webp'
]
where activity_category = 'scuba' and slug = 'dive-goa';
