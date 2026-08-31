update public.listings
set is_active = false
where activity_category = 'clubs'
  and slug = 'sample-club-nova';
