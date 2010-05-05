CREATE TABLE "associations" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "created_at" datetime, "updated_at" datetime, "entity_id" integer, "knows_entity_id" varchar(255), "infosource" varchar(255), "description" varchar(255));
CREATE TABLE "attachments" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "entity_id" integer, "file_name" varchar(255), "created_at" datetime, "updated_at" datetime);
CREATE TABLE "comments" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "content" text, "user_id" integer, "transaction_id" integer, "created_at" datetime, "updated_at" datetime, "commenter" varchar(255));
CREATE TABLE "documents" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "entity_id" integer, "document_name" varchar(255), "created_at" datetime, "updated_at" datetime);
CREATE TABLE "entities" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "is_organization" boolean, "name" varchar(255), "leader" varchar(255), "email" varchar(255), "phone_number" varchar(255), "description" varchar(255), "created_at" datetime, "updated_at" datetime, "photo_file_name" varchar(255), "photo_content_type" varchar(255), "photo_file_size" integer, "homepage" varchar(255));
CREATE TABLE "information_sources" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "source" varchar(255), "rank" integer, "transaction_id" integer, "created_at" datetime, "updated_at" datetime);
CREATE TABLE "schema_migrations" ("version" varchar(255) NOT NULL);
CREATE TABLE "thirdpartypeople" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "last_name" varchar(255), "first_name" varchar(255), "sex" varchar(255), "phone_number" varchar(255), "birthday" date, "created_at" datetime, "updated_at" datetime);
CREATE TABLE "transactions" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "amount" decimal, "description" varchar(255), "created_at" datetime, "updated_at" datetime, "recipient_id" varchar(255), "donor_id" varchar(255), "rank" integer, "entity_id" integer, "ilike" integer, "date_of_transaction" date, "creator_id" integer);
CREATE TABLE "transactions_users" ("transaction_id" integer, "user_id" integer);
CREATE TABLE "users" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "username" varchar(255), "firstname" varchar(255), "lastname" varchar(255), "email" varchar(255), "phone_number" varchar(255), "hashed_password" varchar(255), "created_at" datetime, "updated_at" datetime, "link" varchar(255), "photo_file_name" varchar(255), "photo_content_type" varchar(255), "photo_file_size" integer);
CREATE UNIQUE INDEX "unique_schema_migrations" ON "schema_migrations" ("version");
INSERT INTO schema_migrations (version) VALUES ('20100410080254');

INSERT INTO schema_migrations (version) VALUES ('20100201162708');

INSERT INTO schema_migrations (version) VALUES ('20100202093128');

INSERT INTO schema_migrations (version) VALUES ('20100202112429');

INSERT INTO schema_migrations (version) VALUES ('20100202113533');

INSERT INTO schema_migrations (version) VALUES ('20100202114019');

INSERT INTO schema_migrations (version) VALUES ('20100207174345');

INSERT INTO schema_migrations (version) VALUES ('20100207212308');

INSERT INTO schema_migrations (version) VALUES ('20100207233639');

INSERT INTO schema_migrations (version) VALUES ('20100211121419');

INSERT INTO schema_migrations (version) VALUES ('20100218185301');

INSERT INTO schema_migrations (version) VALUES ('20100223185704');

INSERT INTO schema_migrations (version) VALUES ('20100223190534');

INSERT INTO schema_migrations (version) VALUES ('20100224110845');

INSERT INTO schema_migrations (version) VALUES ('20100224115020');

INSERT INTO schema_migrations (version) VALUES ('20100225122224');

INSERT INTO schema_migrations (version) VALUES ('20100225172650');

INSERT INTO schema_migrations (version) VALUES ('20100225212743');

INSERT INTO schema_migrations (version) VALUES ('20100226021913');

INSERT INTO schema_migrations (version) VALUES ('20100226030615');

INSERT INTO schema_migrations (version) VALUES ('20100226032149');

INSERT INTO schema_migrations (version) VALUES ('20100226033606');

INSERT INTO schema_migrations (version) VALUES ('20100317084108');

INSERT INTO schema_migrations (version) VALUES ('20100317143708');

INSERT INTO schema_migrations (version) VALUES ('20100318153607');

INSERT INTO schema_migrations (version) VALUES ('20100318154330');

INSERT INTO schema_migrations (version) VALUES ('20100322173128');

INSERT INTO schema_migrations (version) VALUES ('20100331120307');

INSERT INTO schema_migrations (version) VALUES ('20100310112913');

INSERT INTO schema_migrations (version) VALUES ('20100318195411');

INSERT INTO schema_migrations (version) VALUES ('20100418130303');

INSERT INTO schema_migrations (version) VALUES ('20100419172126');

INSERT INTO schema_migrations (version) VALUES ('20100422223052');

INSERT INTO schema_migrations (version) VALUES ('20100422223659');

INSERT INTO schema_migrations (version) VALUES ('20100422225335');

INSERT INTO schema_migrations (version) VALUES ('20100428113141');

INSERT INTO schema_migrations (version) VALUES ('20100428123201');

INSERT INTO schema_migrations (version) VALUES ('20100428131059');

INSERT INTO schema_migrations (version) VALUES ('20100503073058');