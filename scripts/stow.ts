import { parse } from "https://deno.land/std@0.105.0/flags/mod.ts";

function dispatch() {
  const { _: args } = parse(Deno.args);
  const subcommand = args[0];
  console.log(subcommand)
}

dispatch();
