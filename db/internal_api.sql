/*
 *  DBMS: "PostgreSQL 15"
 *  Database: "security"
 *  Tables: "internal_api", "internal_api_key", "internal_api_key_role", "internal_api_role"
 */

CREATE DATABASE IF NOT EXISTS "security";
CREATE SCHEMA IF NOT EXISTS "internal_api";

CREATE TABLE IF NOT EXISTS "internal_api"."api" (
    "id" uuid NOT NULL,
    "code" varchar(255) NOT NULL,
    "name" varchar(255) NOT NULL,
    "description" TEXT NOT NULL,
    PRIMARY KEY("id")
);

CREATE TABLE IF NOT EXISTS "internal_api"."key" (
    "id" uuid NOT NULL,
    "api" uuid NOT NULL,
    "key" varchar(255) NOT NULL,
    "name" varchar(255) NOT NULL,
    "description" TEXT NOT NULL,
    PRIMARY KEY("id")
    CONSTRAINT "fk_internal_api_api_id" FOREIGN KEY ("api") REFERENCES "internal_api"."api"("id") ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS "internal_api"."role" (
    "id" uuid NOT NULL,
    "name" varchar(255) NOT NULL,
    "description" varchar(255) NOT NULL,
    "status" varchar(255) NOT NULL,
    "created_at" timestamp NOT NULL,
    "updated_at" timestamp NOT NULL,
    PRIMARY KEY("id")
);

CREATE TABLE IF NOT EXISTS "internal_api"."key_role" (
    "key" uuid NOT NULL,
    "role" uuid NOT NULL,
    PRIMARY KEY("key", "role"),
    CONSTRAINT "fk_internal_api_key_id" FOREIGN KEY ("internal_api_key_id") REFERENCES "internal_api_key"("id") ON DELETE CASCADE,
    CONSTRAINT "fk_internal_api_role_id" FOREIGN KEY ("internal_api_role_id") REFERENCES "internal_api_role"("id") ON DELETE CASCADE
);

-- Is this really needed?
CREATE INDEX "idx_internal_api_key_id" ON  "internal_api"."key_role"("internal_api_key_id");
CREATE INDEX "idx_internal_api_role_id" ON "internal_api"."role"("id");
CREATE INDEX "idx_internal_api_id" ON      "internal_api"."key"("id");
CREATE INDEX "idx_internal_api_role_id" ON "internal_api"."key_role"("internal_api_role_id");
CREATE INDEX "idx_internal_api_key_id" ON   "internal_api"."key"("id");