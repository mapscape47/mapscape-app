update public.listings
set is_active = false
where activity_category = 'boat-trip'
  and slug = 'dolphin-trip';
