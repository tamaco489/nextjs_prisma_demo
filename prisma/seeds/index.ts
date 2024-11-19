import { PrismaClient } from "@prisma/client";
import { user } from "./user";
import { profile } from "./profile";
import { address } from "./address";
import { profileImage } from "./profile_image";

export const prisma = new PrismaClient();

async function main() {
  console.log('starting prisma client...')
  await prisma.$transaction([
    ...user(),
    ...profile(),
    ...address(),
    ...profileImage(),
  ])
};

main()
  .then(
    // 成功時に追加の処理が必要な場合はここでなんらか実行する（今回は不要）
  )
  .catch((e) => {
    console.error(e);
  })
  .finally(async () => {
    // 例外の有無に関わらず Prisma Client のコネクションを閉じる
    console.log('close prisma client connection...');
    await prisma.$disconnect();
  });
