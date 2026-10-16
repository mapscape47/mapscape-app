-- The real car rows use different slugs than the original placeholder
-- test rows, so the placeholders need explicit deactivation or they'd
-- keep showing up alongside the real cars. Bike placeholders
-- (sample-honda-activa, sample-royal-enfield-classic-350) are untouched.
update public.listings
set is_active = false
where activity_category = 'rental-car'
  and slug in ('sample-maruti-swift', 'sample-toyota-innova');
