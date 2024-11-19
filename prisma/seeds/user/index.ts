import { prisma } from "..";
import fixture from "./fixture.json";
import type { PrismaPromise, User, EkycStatus  } from "@prisma/client";

export const user = () => {
  console.log("exec user seed...");
  const res: PrismaPromise<User>[] = [];
  fixture.forEach((data) => {
    const row = prisma.user.create({
      data: {
        auth0_user_id: data.auth0_user_id,
        email: data.email,
        ekyc_status: data.ekyc_status as EkycStatus,
      }
    });
    res.push(row);
  });
  return res;
};
