import { Context } from "../../deps.ts";

export class InternalApiIndex {
  public static get(ctx: Context) {
    ctx.response.body = {};
  }
}
