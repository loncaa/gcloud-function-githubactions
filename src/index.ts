import { Request, Response } from "@google-cloud/functions-framework";

const NODE_ENV = process.env.NODE_ENV || "development";
if (NODE_ENV === "development") {
  require("dotenv").config();
}

export const myFnc = async (req: Request, res: Response) => {
  const { method } = req;

  if (method !== "GET") {
    return res.status(405).send("Method Not Allowed");
  }

  res.status(200).send(`Method Allowed - ${process.env.ENV_STRING}`);
};
