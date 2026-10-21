-- Adds the new menu_pdfs column (multiple labeled menus per listing)
-- and links each restaurant to its menu PDF(s). Idempotent: upserts by
-- (activity_category, slug) on the existing rows, safe to re-run.
-- Only touches the 3 restaurants already imported (Mystery of Lemon
-- Chilli, Curry House, Fiturr) — Cafe, Salon & Spa, and every other
-- category are untouched. KNS and Saint Cloud's PDFs are intentionally
-- not linked anywhere by this file.

alter table public.listings add column if not exists menu_pdfs jsonb;

update public.listings
set menu_pdfs = '[
  {"label": "Menu", "url": "/menus/restaurants/mystery-of-lemon-chilli-menu.pdf"}
]'::jsonb
where activity_category = 'restaurants' and slug = 'mystery-of-lemon-chilli';

update public.listings
set menu_pdfs = '[
  {"label": "Food Menu", "url": "/menus/restaurants/curry-house-food-menu.pdf"},
  {"label": "Bar Menu", "url": "/menus/restaurants/curry-house-bar-menu.pdf"}
]'::jsonb
where activity_category = 'restaurants' and slug = 'curry-house';

update public.listings
set menu_pdfs = '[
  {"label": "Food Menu", "url": "/menus/restaurants/fiturr-food-menu.pdf"},
  {"label": "Bar Menu", "url": "/menus/restaurants/fiturr-bar-menu.pdf"},
  {"label": "Beverage Menu", "url": "/menus/restaurants/fiturr-beverage-menu.pdf"},
  {"label": "Special Menu", "url": "/menus/restaurants/fiturr-special-menu.pdf"}
]'::jsonb
where activity_category = 'restaurants' and slug = 'fiturr';
