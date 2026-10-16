-- Real Restaurants data import (replaces the placeholder test
-- listing from restaurants-seed.sql). Idempotent: upserts by
-- (activity_category, slug), safe to run twice. No code changes
-- needed — /restaurants and /restaurants/[slug] already render
-- through RestaurantListPageView/RestaurantDetailPageView, same as
-- Cafe.
--
-- menu_pdf_url is left null for all 3 — PDFs to be uploaded
-- separately; the Menu section simply won't render until it's set.
-- Fiturr has only 4 photos in the source (missing #2), used as-is.
-- Location uses each restaurant's address text, not the sheet's exact
-- Google Maps short link (Get Directions builds its own search URL
-- from the address, same as every other category using LocationCard
-- — no code change to the component shared with Cafe). No vendor
-- name in any description.

update public.activities
set image_urls = array[
  '/activities/restaurants/category-1.webp',
  '/activities/restaurants/category-2.webp',
  '/activities/restaurants/category-3.webp',
  '/activities/restaurants/category-4.webp',
  '/activities/restaurants/category-5.webp'
]
where slug = 'restaurants';

insert into public.listings (
  activity_category, slug, name, description, overview_points, photos,
  location_address, location_lat, location_lng,
  quick_answers, pricing_type, pricing_data, contact_type, menu_pdf_url, is_active
)
values
  (
    'restaurants', 'mystery-of-lemon-chilli', 'Mystery of Lemon Chilli',
    'The Mystery of Lemon Chilli is a cozy, family-friendly fine-dining spot in Arpora. It specializes in a diverse mix of Continental, Chinese, Italian, and fusion dishes, offering a warm and relaxed atmosphere that typically costs between ₹700 and ₹1,200 for two people.',
    '["Dining Atmosphere: Features a warm, cozy fine-dining ambiance that is highly recommended for family meals and group outings.", "Culinary Specialties: Known for its standout Continental dishes and amazing fusion food.", "Standout Dishes: Customer favorites include the Fish Croquettes, Lamb Osso Bucco, and Paneer Dry Fry.", "Service Excellence: Praised for its immaculately presented food and highly attentive, hospitable staff."]'::jsonb,
    array['/activities/restaurants/mystery-of-lemon-chilli-1.webp', '/activities/restaurants/mystery-of-lemon-chilli-2.webp', '/activities/restaurants/mystery-of-lemon-chilli-3.webp', '/activities/restaurants/mystery-of-lemon-chilli-4.webp', '/activities/restaurants/mystery-of-lemon-chilli-5.webp'],
    'Govekar Nagar, Porvorim / Arpora, Goa', null, null,
    '[{"label": "Timings", "value": "12:00 PM to 4:00 PM and 7:00 PM to 11:00 PM"}, {"label": "Cost for Two", "value": "Approximately ₹700 to ₹1,200"}, {"label": "Cuisine & Offerings", "value": "Continental, Chinese, and Italian"}]'::jsonb,
    'single', '{"price": {"display_price": 0}}'::jsonb, 'land', null, true
  ),
  (
    'restaurants', 'curry-house', 'The Curry House',
    'Located on the Aguada-Siolim Road, The Curry House is a lively, casual dining venue known for its vibrant crowd. It frequently hosts live music and open mic nights while serving a broad menu of North Indian, Goan, Continental, and Indo-Chinese favorites for about ₹1,200 to ₹1,900 per couple.',
    '["Ambiance: Offers a cozy yet refined interior with warm lighting and tasteful decor.", "Entertainment: Features live music that is highly appreciated by guests, adding a lively energy to the dining experience.", "Late-Night Dining: Extremely convenient for late travelers, keeping its doors open until 3:00 AM.", "Food Quality: Recognized for its commitment to authentic flavors, quality ingredients, and broad multicuisine options."]'::jsonb,
    array['/activities/restaurants/curry-house-1.webp', '/activities/restaurants/curry-house-2.webp', '/activities/restaurants/curry-house-3.webp', '/activities/restaurants/curry-house-4.webp', '/activities/restaurants/curry-house-5.webp'],
    'Aguada - Siolim Rd, near Candolim Panchayat, Pintos Vaddo, Candolim', null, null,
    '[{"label": "Timings", "value": "11:00 AM to 3:00 AM daily"}, {"label": "Cost for Two", "value": "Approximately ₹650 to ₹1,500"}, {"label": "Cuisine & Offerings", "value": "North Indian, Goan, Chinese, Continental, and Seafood"}]'::jsonb,
    'single', '{"price": {"display_price": 0}}'::jsonb, 'land', null, true
  ),
  (
    'restaurants', 'fiturr', 'Fiturr',
    'Fiturr delivers a premium, high-energy nightlife experience on Anjuna''s Flea Market Road. This pet-friendly venue pairs rich North Indian, Mughlai, and Continental cuisine with captivating live entertainment, including music, belly dancing, and sheesha, generally costing around ₹1,900 to ₹2,200 for two.',
    '["Vibrant Entertainment: Delivers an electric vibe with live music, belly dance performances, and sheesha offerings.", "Upscale & Pet-Friendly: A chic, upscale restaurant that is completely pet-friendly and features both inside and outside seating areas.", "Signature Dishes: Highly reviewed for its beautifully presented mains, craft cocktails, thin-crust pizzas, jalapeno cheese poppers, and a standout hummus platter featuring beetroot hummus.", "Convenience: Offers excellent service from a friendly team and provides valet parking for guests."]'::jsonb,
    array['/activities/restaurants/fiturr-1.webp', '/activities/restaurants/fiturr-2.webp', '/activities/restaurants/fiturr-3.webp', '/activities/restaurants/fiturr-4.webp'],
    'Beach Road, Monteiro Vaddo, Anjuna, Goa', null, null,
    '[{"label": "Timings", "value": "Open daily until 11:59 PM"}, {"label": "Cost for Two", "value": "Approximately ₹1,900 to ₹2,200"}, {"label": "Cuisine & Offerings", "value": "North Indian, Mughlai, and Continental"}]'::jsonb,
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
  -- menu_pdf_url intentionally NOT reset on conflict, so a PDF added later
  -- (via a separate update once you upload it) survives re-running this file.
