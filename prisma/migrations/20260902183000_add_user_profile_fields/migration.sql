ALTER TABLE "User" ADD COLUMN "login" VARCHAR(100);
ALTER TABLE "User" ADD COLUMN "firstName" VARCHAR(100);
ALTER TABLE "User" ADD COLUMN "lastName" VARCHAR(100);
ALTER TABLE "User" ADD COLUMN "phone" VARCHAR(20);
ALTER TABLE "User" ADD COLUMN "bio" TEXT;

UPDATE "User" SET "login" = split_part(email, '@', 1) WHERE "login" IS NULL;

ALTER TABLE "User" ALTER COLUMN "login" SET NOT NULL;
CREATE UNIQUE INDEX "User_login_key" ON "User"("login");
