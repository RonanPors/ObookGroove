-- Deploy obookgroove:01_init to pg

BEGIN;

CREATE TABLE "user" (
    "id" INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    "pseudo" TEXT NOT NULL UNIQUE,
    "email" TEXT NOT NULL UNIQUE,
    "password" TEXT NOT NULL,
    "last_login" TIMESTAMPTZ NOT NULL DEFAULT now(),
    "phone_number" TEXT NULL,
    "profile_picture" TEXT NULL,
    "created_at" TIMESTAMPTZ NOT NULL DEFAULT now(),
    "updated_at" TIMESTAMPTZ NULL
);

CREATE TABLE book (
    "id" INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    "isbn" TEXT NOT NULL,
    "title" TEXT NOT NULL,
    "author" TEXT NULL,
    "resume" TEXT NULL,
    "genre" TEXT [] NOT NULL,
    "cover" TEXT NULL,
    "year" INT NULL,
    "number_of_pages" INT NULL,
    "created_at" TIMESTAMPTZ NOT NULL DEFAULT now(),
    "updated_at" TIMESTAMPTZ NULL
);

CREATE TABLE user_has_book (
    "id" INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    "book_id" INT NOT NULL,
    "user_id" INT NOT NULL,
    "is_active" BOOLEAN NOT NULL DEFAULT true,
    "is_favorite" BOOLEAN NOT NULL DEFAULT false,
    "created_at" TIMESTAMPTZ NOT NULL DEFAULT now(),
    "updated_at" TIMESTAMPTZ NULL
);

COMMIT;