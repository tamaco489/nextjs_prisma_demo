-- CreateTable
CREATE TABLE "ProfileImage" (
    "id" BIGSERIAL NOT NULL,
    "user_id" BIGINT NOT NULL,
    "file_path" CHAR(255) NOT NULL,
    "uploaded_at" TIMESTAMP(3),
    "updated_at" TIMESTAMP(3) NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "ProfileImage_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE INDEX "ProfileImage_user_id_idx" ON "ProfileImage"("user_id");

-- AddForeignKey
ALTER TABLE "ProfileImage" ADD CONSTRAINT "ProfileImage_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
