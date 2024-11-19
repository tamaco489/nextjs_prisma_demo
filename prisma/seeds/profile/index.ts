import { prisma } from "..";
import fixture from "./fixture.json";
import { PrismaPromise, Profile } from "@prisma/client";

export const profile = () => {
  console.log("exec profile seed...");
  const res: PrismaPromise<Profile>[] = [];
  fixture.forEach((data) => {
    const row = prisma.profile.create({data});
    res.push(row);
  });
  return res;
};
