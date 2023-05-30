/*
 *  DBMS: `PostgreSQL 15`
 *  Database: `security`
 *  Tables: `internal_api`, `internal_api_key`, `internal_api_key_role`, `internal_api_role`
 */

CREATE DATABASE `security` IF NOT EXISTS;
CREATE SCHEMA `internal_api` IF NOT EXISTS;

CREATE TABLE `internal_api`.`api` (
    `id` uuid NOT NULL DEFAULT uuid_generate_v4(),
    `name` varchar(255) NOT NULL,
    `description` varchar(255) NOT NULL,
    `status` varchar(255) NOT NULL,
    `created_at` timestamp NOT NULL,
    `updated_at` timestamp NOT NULL,
    PRIMARY KEY(`id`)
);

CREATE TABLE `internal_api_key` (
    `id` uuid NOT NULL,
    `name` varchar(255) NOT NULL,
    `description` varchar(255) NOT NULL,
    `key` varchar(255) NOT NULL,
    `status` varchar(255) NOT NULL,
    `created_at` timestamp NOT NULL,
    `updated_at` timestamp NOT NULL,
    PRIMARY KEY(`id`)
);

CREATE TABLE `internal_api_key_role` (
    `internal_api_key_id` uuid NOT NULL,
    `internal_api_role_id` uuid NOT NULL,
    PRIMARY KEY(`internal_api_key_id`, `internal_api_role_id`),
    CONSTRAINT `fk_internal_api_key_id` FOREIGN KEY (`internal_api_key_id`) REFERENCES `internal_api_key`(`id`) ON DELETE CASCADE,
    CONSTRAINT `fk_internal_api_role_id` FOREIGN KEY (`internal_api_role_id`) REFERENCES `internal_api_role`(`id`) ON DELETE CASCADE
);

CREATE TABLE `internal_api_role` (
    `id` uuid NOT NULL,
    `name` varchar(255) NOT NULL,
    `description` varchar(255) NOT NULL,
    `status` varchar(255) NOT NULL,
    `created_at` timestamp NOT NULL,
    `updated_at` timestamp NOT NULL,
    PRIMARY KEY(`id`)
);

CREATE INDEX `idx_internal_api_key_id` ON `internal_api_key_role`(`internal_api_key_id`);
CREATE INDEX `idx_internal_api_role_id` ON `internal_api_key_role`(`internal_api_role_id`);
CREATE INDEX `idx_internal_api_key_id` ON `internal_api_key`(`id`);
CREATE INDEX `idx_internal_api_role_id` ON `internal_api_role`(`id`);
CREATE INDEX `idx_internal_api_id` ON `internal_api_key`(`id`);
