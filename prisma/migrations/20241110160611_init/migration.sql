-- CreateEnum
CREATE TYPE "EkycStatus" AS ENUM ('not_submitted', 'reviewing', 'approved', 'rejected');

-- CreateTable
CREATE TABLE "User" (
    "id" BIGSERIAL NOT NULL,
    "auth0_user_id" CHAR(255) NOT NULL,
    "email" CHAR(255),
    "ekyc_status" "EkycStatus" NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "User_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Profile" (
    "id" BIGSERIAL NOT NULL,
    "user_id" BIGINT NOT NULL,
    "first_name" CHAR(255) NOT NULL,
    "last_name" CHAR(255) NOT NULL,
    "first_name_roman" CHAR(255) NOT NULL,
    "last_name_roman" CHAR(255) NOT NULL,
    "birth_date" CHAR(14) NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "Profile_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Address" (
    "id" BIGSERIAL NOT NULL,
    "user_id" BIGINT NOT NULL,
    "zip_code" CHAR(7) NOT NULL,
    "prefecture" CHAR(255) NOT NULL,
    "city" CHAR(255) NOT NULL,
    "street" CHAR(255) NOT NULL,
    "other" CHAR(255) NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "Address_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "User_auth0_user_id_key" ON "User"("auth0_user_id");

-- CreateIndex
CREATE INDEX "User_auth0_user_id_idx" ON "User"("auth0_user_id");

-- CreateIndex
CREATE UNIQUE INDEX "Profile_user_id_key" ON "Profile"("user_id");

-- CreateIndex
CREATE INDEX "Profile_user_id_idx" ON "Profile"("user_id");

-- CreateIndex
CREATE INDEX "Address_user_id_idx" ON "Address"("user_id");

-- AddForeignKey
ALTER TABLE "Profile" ADD CONSTRAINT "Profile_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Address" ADD CONSTRAINT "Address_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
