-- Real Cafe data import (replaces the placeholder test listing from
-- cafe-seed.sql). Idempotent: upserts by (activity_category, slug),
-- safe to run twice. No code changes needed — /cafe and /cafe/[slug]
-- already render through RestaurantListPageView/RestaurantDetailPageView,
-- same as Restaurants.
--
-- menu_pdf_url left null — PDF to be uploaded separately, the Menu
-- section simply won't render until it's set. Location uses the full
-- street address from Details at a Glance ("...Sangolda, Goa"); the
-- sheet's separate Location column just says "Saligao", the broader
-- locality, not a conflict. No vendor name in the description.

update public.activities
set image_urls = array[
  '/activities/cafe/category-1.webp',
  '/activities/cafe/category-2.webp',
  '/activities/cafe/category-3.webp',
  '/activities/cafe/category-4.webp',
  '/activities/cafe/category-5.webp'
]
where slug = 'cafe';

insert into public.listings (
  activity_category, slug, name, description, overview_points, photos,
  location_address, location_lat, location_lng,
  quick_answers, pricing_type, pricing_data, contact_type, menu_pdf_url, is_active
)
values (
  'cafe', 'saint-cloud', 'Saint Cloud',
  'Located along Chogm Road, Saint Cloud Bakery is a charming cafe and patisserie known for its fresh bakes, specialty coffee, and decadent Berliners. It offers a relaxed setting for quick bites or sweet treats, averaging ₹700 to ₹800 for two.',
  '["Signature Berliners: Renowned for their fresh, fluffy Berliners with fillings like Nutella, Vanilla Cream with Strawberry Jam, and savory Garlic Cream Cheese.", "Dietary-Friendly Options: Offers specialized premium desserts, including a highly-rated Flourless Dark Chocolate Almond Cake that is completely gluten-free and sugar-free.", "Artisan Sandwiches: Features a diverse sandwich menu using high-quality breads, such as the Ciabatta Roast Chicken, Burrata Pesto, and Aubergine Roast Pepper Hummus Focaccia.", "Atmosphere: A charming, clean, and relaxed cafe environment that is ideal for unwinding, casual meals, and coffee catch-ups.", "Custom Bakes: Serves as a trusted local cake shop offering custom celebration designs, photo cakes, and eggless options baked daily with premium ingredients."]'::jsonb,
  array['/activities/cafe/saint-cloud-1.webp', '/activities/cafe/saint-cloud-2.webp', '/activities/cafe/saint-cloud-3.webp', '/activities/cafe/saint-cloud-4.webp', '/activities/cafe/saint-cloud-5.webp'],
  '20A, Chogm Road, opposite Prime Rose, Sangolda, Goa', null, null,
  '[{"label": "Timings", "value": "9:00 AM to 9:00 PM daily"}, {"label": "Cost for Two", "value": "Approximately ₹700 to ₹800"}, {"label": "Cuisine & Offerings", "value": "Bakery, Cafe, Coffee, Desserts, and Sandwiches"}]'::jsonb,
  'single', '{"price": {"display_price": 0}}'::jsonb, 'land', null, true
)
on conflict (activity_category, slug) do update set
  name = excluded.name,
  description = excluded.description,
  overview_points = excluded.overview_points,
  photos = excluded.photos,
  location_address = excluded.location_address,
  location_lat = excluded.location_lat,
  location_lng = excluded.location_lng,
  quick_answers = excluded.quick_answers,
  pricing_type = excluded.pricing_type,
  pricing_data = excluded.pricing_data,
  contact_type = excluded.contact_type,
  is_active = excluded.is_active;
  -- menu_pdf_url intentionally NOT reset on conflict, so a PDF added later survives a re-run.
