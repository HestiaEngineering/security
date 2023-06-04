import { Application, Context, isHttpError, Next, Router } from "./deps.ts";
import { Index } from "./routes/index.ts";

// Check if stuff exists
if (!Deno.env.get("DB_USER")) {
  console.error("DB_USER not defined");
} else if (!Deno.env.get("DB_PASSWORD")) {
  console.error("DB_PASSWORD not defined");
}

// Implement keys (tbd)
try {
  await Deno.readTextFile("keys/test.txt");
} catch (e) {
  if (e instanceof Deno.errors.NotFound) {
    console.error("file does not exists");
  }
}

const app = new Application();
const router = new Router();

app.use(async (ctx: Context, next: Next) => {
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
  .get("/", Index.get)
  .get("/other", (ctx: Context) => ctx.throw(415));

app.use(router.routes());
app.use(router.allowedMethods());

// Docker doesn't support IPV6 by default
//app.listen({ port: 8000, hostname: "::" });
app.listen({ port: 8000, hostname: "127.0.0.1" });
