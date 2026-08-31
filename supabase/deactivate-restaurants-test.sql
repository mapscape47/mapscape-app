update public.listings
set is_active = false
where activity_category = 'restaurants'
  and slug = 'sample-beach-shack';
