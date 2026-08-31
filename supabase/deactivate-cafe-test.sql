update public.listings
set is_active = false
where activity_category = 'cafe'
  and slug = 'sample-brew-and-bean';
