#!/usr/bin/env python3

import click

from stow import manifest


@click.group()
def cli():
    pass


@cli.command()
def link():
    manifest.link_targets()


@cli.command()
def unlink():
    manifest.unlink_targets()


if __name__ == "__main__":
    cli()
