import * as Colors from "https://deno.land/std@0.105.0/fmt/colors.ts";
import * as Path from "https://deno.land/std@0.105.0/path/mod.ts";
import { exists } from "https://deno.land/std@0.105.0/fs/mod.ts";
import { parse } from "https://deno.land/std@0.105.0/flags/mod.ts";

const cwd = Deno.cwd();
const home = String(Deno.env.get("HOME"));
const user = String(Deno.env.get("USER"));

interface StowLink {
  source: string;
  target: string;
}

function links(): StowLink[] {
  return [
    { source: "git", target: home },
    { source: "nix", target: home },
    { source: "shell", target: home },
    { source: "vim", target: home },
    {
      source: "vscode",
      target: `/Users/${user}/Library/ApplicationSupport/Code/User`,
    },
  ];
}

async function stow(link: StowLink) {
  console.log(Colors.green(`Stowing ${link.source}...`));
  const p = Deno.run({
    cmd: ["stow", "-t", link.target, link.source],
    cwd: Path.join(cwd, "stow"),
  });
  await p.status();
  return;
}

async function unstow(link: StowLink) {
  console.log(Colors.red(`Unstowing ${link.source}...`));
  const p = Deno.run({
    cmd: ["stow", "-t", link.target, "-D", link.source],
    cwd: Path.join(cwd, "stow"),
  });
  await p.status();
  return;
}

async function preCheck() {
  const hasHome = await exists(home);
  const hasStow = await exists(Path.join(cwd, "stow"));
  const hasInit = await exists(Path.join(cwd, "boot/init.sh"));
  if (!(hasHome && hasStow && hasInit)) {
    throw new Error("Running stow.ts from an invalid directory.");
  }
}

async function linkAll() {
  await preCheck();
  for (const l of links()) {
    await stow(l);
  }
}

async function unlinkAll() {
  await preCheck();
  for (const l of links()) {
    await unstow(l);
  }
}

function dispatch() {
  const { _: args } = parse(Deno.args);
  const subcommand = String(args[0]);

  if (subcommand === "link") linkAll();
  if (subcommand === "unlink") unlinkAll();
}

dispatch();
