import { Context } from "../deps.ts";

export class Index {
  public static get(context: Context) {
    context.response.type = "json";
    context.response.body = {
      "module": "security",
      "version": "alpha",
    };
  }
}
