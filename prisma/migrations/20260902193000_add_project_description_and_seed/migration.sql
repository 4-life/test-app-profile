ALTER TABLE "Project" ADD COLUMN "description" TEXT;

INSERT INTO "Project" (id, "userId", name, description, url)
SELECT gen_random_uuid(), u.id, p.name, p.description, p.url
FROM "User" u, (VALUES
  ('Enterprise IoT Solutions', 'High-scalable, reliable IoT infrastructure for enterprise environments', 'https://meshintex.com/'),
  ('Lambda Digital', 'Accept crypto payments with a single QR code', 'https://xn--wxa.digital/'),
  ('Boilerplate to build MVP fast', 'API + database + front-end', 'https://github.com/4-life/hello-world')
) AS p(name, description, url)
WHERE u.email = 'ovchinnikovpa@gmail.com'
  AND NOT EXISTS (SELECT 1 FROM "Project" WHERE "userId" = u.id);
