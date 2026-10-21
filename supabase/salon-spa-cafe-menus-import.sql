-- Links the KNS (Salon & Spa) and Saint Cloud (Cafe) menu PDFs, both
-- deferred from their original imports. Single menu each, so this
-- just sets the existing menu_pdf_url field directly — no new column
-- or code change needed, both pages already render it. Idempotent,
-- safe to re-run.

update public.listings
set menu_pdf_url = '/menus/salon-spa/kns-katusha-nail-studio-menu.pdf'
where activity_category = 'salon-spa' and slug = 'kns-katusha-nail-studio';

update public.listings
set menu_pdf_url = '/menus/cafe/saint-cloud-menu.pdf'
where activity_category = 'cafe' and slug = 'saint-cloud';
