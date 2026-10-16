-- Real Car Rental data import (replaces the placeholder test car rows
-- from rental-seed.sql). Idempotent: upserts by (activity_category,
-- slug), safe to run twice. Only touches activity_category =
-- 'rental-car' rows — bike rows ('rental-bike') are untouched.
--
-- Per your instructions: transmission is kept as the sheet's literal
-- "Automatic/Manual" text (not split into one value), and the 4 cars
-- with a price range (Baleno, Swift, I20, I10) show that range as
-- text via a new "Price Range" quick_answer rather than a single
-- invented number — RentalVehicleCard/RentalListPageView were updated
-- (see that commit) to render this text in place of the numeric price
-- when a "Price Range" quick_answer is present, falling back to the
-- normal numeric price display for every other listing (all bikes,
-- and the other 7 cars). pricing_data.price.display_price is still
-- set to a real number from the sheet (the low end) purely to satisfy
-- the NOT NULL schema constraint — it is never shown for these 4 cars
-- since the Price Range text takes precedence.
--
-- No vendor/company name in the sheet, only car model names.

insert into public.listings (
  activity_category, slug, name, photos, quick_answers, pricing_type, pricing_data, contact_type, is_active
)
values
  (
    'rental-car', 'maruti-suzuki-baleno', 'Maruti Suzuki Baleno',
    array['/activities/car-rental/maruti-suzuki-baleno-1.webp'],
    '[{"label": "Transmission", "value": "Automatic/Manual"}, {"label": "Seating Capacity", "value": "5 Seater"}, {"label": "Price Range", "value": "₹1,200 - 1,600/day"}]'::jsonb,
    'single', '{"price": {"display_price": 1200}}'::jsonb, 'land', true
  ),
  (
    'rental-car', 'maruti-suzuki-swift', 'Maruti Suzuki Swift',
    array['/activities/car-rental/maruti-suzuki-swift-1.webp'],
    '[{"label": "Transmission", "value": "Automatic/Manual"}, {"label": "Seating Capacity", "value": "5 Seater"}, {"label": "Price Range", "value": "₹1,200 - 1,600/day"}]'::jsonb,
    'single', '{"price": {"display_price": 1200}}'::jsonb, 'land', true
  ),
  (
    'rental-car', 'hyundai-i20', 'Hyundai I20',
    array['/activities/car-rental/hyundai-i20-1.webp'],
    '[{"label": "Transmission", "value": "Automatic/Manual"}, {"label": "Seating Capacity", "value": "5 Seater"}, {"label": "Price Range", "value": "₹1,200 - 1,600/day"}]'::jsonb,
    'single', '{"price": {"display_price": 1200}}'::jsonb, 'land', true
  ),
  (
    'rental-car', 'hyundai-i10', 'Hyundai I10',
    array['/activities/car-rental/hyundai-i10-1.webp'],
    '[{"label": "Transmission", "value": "Automatic/Manual"}, {"label": "Seating Capacity", "value": "5 Seater"}, {"label": "Price Range", "value": "₹1,200 - 1,600/day"}]'::jsonb,
    'single', '{"price": {"display_price": 1200}}'::jsonb, 'land', true
  ),
  (
    'rental-car', 'hyundai-creta', 'Hyundai Creta',
    array['/activities/car-rental/hyundai-creta-1.webp'],
    '[{"label": "Transmission", "value": "Automatic/Manual"}, {"label": "Seating Capacity", "value": "5 Seater"}]'::jsonb,
    'single', '{"price": {"display_price": 2200}}'::jsonb, 'land', true
  ),
  (
    'rental-car', 'mahindra-thar', 'Mahindra Thar',
    array['/activities/car-rental/mahindra-thar-1.webp'],
    '[{"label": "Transmission", "value": "Automatic/Manual"}, {"label": "Seating Capacity", "value": "4 Seater"}]'::jsonb,
    'single', '{"price": {"display_price": 2500}}'::jsonb, 'land', true
  ),
  (
    'rental-car', 'toyota-innova-crysta', 'Toyota Innova Crysta',
    array['/activities/car-rental/toyota-innova-crysta-1.webp'],
    '[{"label": "Transmission", "value": "Automatic/Manual"}, {"label": "Seating Capacity", "value": "7 Seater"}]'::jsonb,
    'single', '{"price": {"display_price": 3000}}'::jsonb, 'land', true
  ),
  (
    'rental-car', 'maruti-suzuki-ertiga', 'Maruti Suzuki Ertiga',
    array['/activities/car-rental/maruti-suzuki-ertiga-1.webp'],
    '[{"label": "Transmission", "value": "Automatic/Manual"}, {"label": "Seating Capacity", "value": "7 Seater"}]'::jsonb,
    'single', '{"price": {"display_price": 2500}}'::jsonb, 'land', true
  ),
  (
    'rental-car', 'toyota-fortuner', 'Toyota Fortuner',
    array['/activities/car-rental/toyota-fortuner-1.webp'],
    '[{"label": "Transmission", "value": "Automatic/Manual"}, {"label": "Seating Capacity", "value": "7 Seater"}]'::jsonb,
    'single', '{"price": {"display_price": 4000}}'::jsonb, 'land', true
  ),
  (
    'rental-car', 'maruti-suzuki-jimny', 'Maruti Suzuki Jimny',
    array['/activities/car-rental/maruti-suzuki-jimny-1.webp'],
    '[{"label": "Transmission", "value": "Automatic/Manual"}, {"label": "Seating Capacity", "value": "5 Seater"}]'::jsonb,
    'single', '{"price": {"display_price": 2500}}'::jsonb, 'land', true
  ),
  (
    'rental-car', 'mahindra-thar-roxx', 'Mahindra Thar Roxx',
    array['/activities/car-rental/mahindra-thar-roxx-1.webp'],
    '[{"label": "Transmission", "value": "Automatic/Manual"}, {"label": "Seating Capacity", "value": "5 Seater"}]'::jsonb,
    'single', '{"price": {"display_price": 3500}}'::jsonb, 'land', true
  )
on conflict (activity_category, slug) do update set
  name = excluded.name,
  photos = excluded.photos,
  quick_answers = excluded.quick_answers,
  pricing_type = excluded.pricing_type,
  pricing_data = excluded.pricing_data,
  contact_type = excluded.contact_type,
  is_active = excluded.is_active;
