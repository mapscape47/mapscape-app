update public.listings
set is_active = false
where activity_category in ('rental-bike', 'rental-car')
  and slug in (
    'sample-honda-activa',
    'sample-royal-enfield-classic-350',
    'sample-maruti-swift',
    'sample-toyota-innova'
  );
