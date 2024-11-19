import { prisma } from "..";
import fixture from "./fixture.json";
import { PrismaPromise, ProfileImage } from "@prisma/client";

export const profileImage = () => {
  console.log('exec profile_image seed...');
  const res: PrismaPromise<ProfileImage>[] = [];
  fixture.forEach((data) => {
    const row = prisma.profileImage.create({data});
    res.push(row);
  })
  return res;
};
