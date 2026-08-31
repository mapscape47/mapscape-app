update public.listings
set is_active = false
where activity_category = 'taxi'
  and slug in ('sample-swift-dzire', 'sample-ertiga', 'sample-innova');
