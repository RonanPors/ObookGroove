-- Deploy obookgroove:02_crud_functions to pg

BEGIN;

-- XXX Add DDLs here.

-- insert user
CREATE FUNCTION "insert_user"(json) RETURNS "user" AS $$

  INSERT INTO "user" (
    "pseudo",
    "email",
    "password",
    "phone_number",
    "profile_picture"
  ) VALUES (
    $1->>'pseudo',
    $1->>'email',
    $1->>'password',
    $1->>'phone_number',
    $1->>'profile_picture'
  ) RETURNING *

$$ LANGUAGE sql

VOLATILE STRICT;

-- insert book
CREATE FUNCTION "insert_book"(json) RETURNS "book" AS $$

  INSERT INTO "book" (
    "isbn",
    "title",
    "author",
    "resume",
    "genre",
    "cover",
    "year",
    "number_of_pages"
  ) VALUES (
    $1->>'isbn',
    $1->>'title',
    $1->>'author',
    $1->>'resume',
    ($1->>'genre')::TEXT[],
    $1->>'cover',
    ($1->>'year')::INT,
    ($1->>'number_of_pages')::INT
  ) RETURNING *

$$ LANGUAGE sql

VOLATILE STRICT;

-- insert user_has_book
CREATE FUNCTION "insert_user_has_book"(json) RETURNS "user_has_book" AS $$

  INSERT INTO "user_has_book" (
    "book_id",
    "user_id",
    "is_active",
    "is_favorite"
  ) VALUES (
    ($1->>'book_id')::INT,
    ($1->>'user_id')::INT,
    ($1->>'is_active')::BOOLEAN,
    ($1->>'is_favorite')::BOOLEAN
  ) RETURNING *

$$ LANGUAGE sql

VOLATILE STRICT;

-- update user
CREATE FUNCTION "update_user"(json) RETURNS "user" AS $$

  UPDATE "user" SET
    "pseudo" = COALESCE($1->>'pseudo', "pseudo"),
    "email" = COALESCE($1->>'email', "email"),
    "password" = COALESCE($1->>'password', "password"),
    "last_login" = COALESCE(($1->>'last_login')::TIMESTAMPTZ, "last_login"),
    "phone_number" = COALESCE($1->>'phone_number', "phone_number"),
    "profile_picture" = COALESCE($1->>'profile_picture', "profile_picture"),
    "updated_at" = now()
  WHERE "id" = ($1->>'id')::INT
  RETURNING *

$$ LANGUAGE sql

VOLATILE STRICT;

-- update book
CREATE FUNCTION "update_book"(json) RETURNS "book" AS $$

  UPDATE "book" SET
    "isbn" = COALESCE($1->>'isbn', "isbn"),
    "title" = COALESCE($1->>'title', "title"),
    "author" = COALESCE($1->>'author', "author"),
    "resume" = COALESCE($1->>'resume', "resume"),
    "genre" = COALESCE(($1->>'genre')::TEXT[], "genre"),
    "cover" = COALESCE($1->>'cover', "cover"),
    "year" = COALESCE(($1->>'year')::INT, "year"),
    "number_of_pages" = COALESCE(($1->>'number_of_pages')::INT, "number_of_pages"),
    "updated_at" = now()
  WHERE "id" = ($1->>'id')::INT
  RETURNING *

$$ LANGUAGE sql

VOLATILE STRICT;

-- update user_has_book
CREATE FUNCTION "update_user_has_book"(json) RETURNS "user_has_book" AS $$

  UPDATE "user_has_book" SET
    "book_id" = COALESCE(($1->>'book_id')::INT, "book_id"),
    "user_id" = COALESCE(($1->>'user_id')::INT, "user_id"),
    "is_active" = COALESCE(($1->>'is_active')::BOOLEAN, "is_active"),
    "is_favorite" = COALESCE(($1->>'is_favorite')::BOOLEAN, "is_favorite"),
    "updated_at" = now()
  WHERE "id" = ($1->>'id')::INT
  RETURNING *

$$ LANGUAGE sql

VOLATILE STRICT;

COMMIT;