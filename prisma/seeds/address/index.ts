import { prisma } from "..";
import fixture from "./fixture.json";
import type { PrismaPromise, Address } from "@prisma/client";

export const address = () => {
  console.log("exec address seed...");
  const res: PrismaPromise<Address>[] = [];
  fixture.forEach((data) => {
    const row = prisma.address.create({data});
    res.push(row)
  });
  return res;
};
