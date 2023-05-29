import { Context } from "https://deno.land/x/oak@v12.4.0/context.ts";

export class index {
  public static get(ctx: Context) {
    ctx.response.type = "json";
    ctx.response.body = {
      "module": "security",
      "version": "alpha",
    };
  }
}
