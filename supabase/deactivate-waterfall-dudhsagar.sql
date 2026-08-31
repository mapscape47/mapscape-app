update public.listings
set is_active = false
where activity_category = 'waterfall'
  and slug = 'dudhsagar';
