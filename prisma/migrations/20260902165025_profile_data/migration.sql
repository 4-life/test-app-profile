CREATE TABLE "Skill" (
    "id" TEXT NOT NULL,
    "userId" TEXT NOT NULL,
    "name" VARCHAR(100) NOT NULL,

    CONSTRAINT "Skill_pkey" PRIMARY KEY ("id")
);

CREATE TABLE "Experience" (
    "id" TEXT NOT NULL,
    "userId" TEXT NOT NULL,
    "company" VARCHAR(200) NOT NULL,
    "position" VARCHAR(200) NOT NULL,
    "startDate" DATE NOT NULL,
    "endDate" DATE,
    "achievements" TEXT[],

    CONSTRAINT "Experience_pkey" PRIMARY KEY ("id")
);

CREATE TABLE "Project" (
    "id" TEXT NOT NULL,
    "userId" TEXT NOT NULL,
    "name" VARCHAR(200) NOT NULL,
    "url" VARCHAR(500) NOT NULL,

    CONSTRAINT "Project_pkey" PRIMARY KEY ("id")
);


CREATE TABLE "Link" (
    "id" TEXT NOT NULL,
    "userId" TEXT NOT NULL,
    "label" VARCHAR(100) NOT NULL,
    "url" VARCHAR(500) NOT NULL,

    CONSTRAINT "Link_pkey" PRIMARY KEY ("id")
);

ALTER TABLE "Skill" ADD CONSTRAINT "Skill_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE "Experience" ADD CONSTRAINT "Experience_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE "Project" ADD CONSTRAINT "Project_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE "Link" ADD CONSTRAINT "Link_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;
