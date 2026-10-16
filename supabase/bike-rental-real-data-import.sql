-- Real Bike Rental data import (replaces the placeholder test bike
-- rows from rental-seed.sql). Idempotent: upserts by
-- (activity_category, slug), safe to run twice. Only touches
-- activity_category = 'rental-bike' rows — car rows ('rental-car')
-- are untouched.
--
-- "Geared"/"Non Geared" mapped to Manual/Automatic per confirmed
-- convention: scooters (Fascino, Activa) are Non Geared -> Automatic;
-- the Royal Enfield Classic 350 is Geared -> Manual. No Seating
-- Capacity quick_answer for bikes (RentalVehicleCard already excludes
-- it for vehicleType "bike" by design). No vendor/company name in any
-- bike's name. No code changes needed — pure data, same shared
-- RentalListPageView/RentalVehicleCard already used for cars.

insert into public.listings (
  activity_category, slug, name, photos, quick_answers, pricing_type, pricing_data, contact_type, is_active
)
values
  (
    'rental-bike', 'yamaha-fascino', 'Yamaha Fascino',
    array['/activities/bike-rental/yamaha-fascino-1.webp'],
    '[{"label": "Transmission", "value": "Automatic"}]'::jsonb,
    'single', '{"price": {"display_price": 500}}'::jsonb, 'land', true
  ),
  (
    'rental-bike', 'royal-enfield-classic-350', 'Royal Enfield Classic 350',
    array['/activities/bike-rental/royal-enfield-classic-350-1.webp'],
    '[{"label": "Transmission", "value": "Manual"}]'::jsonb,
    'single', '{"price": {"display_price": 1500}}'::jsonb, 'land', true
  ),
  (
    'rental-bike', 'honda-activa', 'Honda Activa',
    array['/activities/bike-rental/honda-activa-1.webp'],
    '[{"label": "Transmission", "value": "Automatic"}]'::jsonb,
    'single', '{"price": {"display_price": 500}}'::jsonb, 'land', true
  )
on conflict (activity_category, slug) do update set
  name = excluded.name,
  photos = excluded.photos,
  quick_answers = excluded.quick_answers,
  pricing_type = excluded.pricing_type,
  pricing_data = excluded.pricing_data,
  contact_type = excluded.contact_type,
  is_active = excluded.is_active;
