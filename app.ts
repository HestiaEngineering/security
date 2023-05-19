import {
  Application,
  isHttpError,
  Router,
} from "https://deno.land/x/oak@v12.4.0/mod.ts";
import { index_get } from "./routes/index.ts";

const app = new Application();
const router = new Router();

app.use(async (ctx, next) => {
  try {
    await next();
    if (ctx.response.status === 404) {
      ctx.throw(404);
    }
  } catch (err) {
    if (isHttpError(err)) ctx.response.status = err.status;
    else ctx.response.status = 500;
    ctx.response.body = { error: err.message };
    ctx.response.type = "json";
  }
});

router
  .get("/", index_get)
  .get("/other", (ctx) => ctx.throw(415));

app.use(router.routes());
app.use(router.allowedMethods());

await app.listen({ port: 8000 });
