-- Deactivates all placeholder/test listings so they stop appearing on the
-- public site, while keeping the rows in the database for reference. RLS
-- already restricts the public (publishable-key) queries to is_active =
-- true rows, so this alone removes them from both the Level 2 list page
-- and their direct Level 3 URLs.
update public.listings
set is_active = false
where (activity_category, slug) in (
  ('scuba', 'template-test-tiered'),
  ('scuba', 'template-test-multi-service'),
  ('yacht', 'sample-yacht'),
  ('quad-biking', 'sample-quad-trail')
);
