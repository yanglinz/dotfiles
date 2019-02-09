#!/usr/bin/env python3

import click

from scripts import stow


@click.group()
def cli():
    pass


@cli.command()
def link():
    stow.link_targets()


@cli.command()
def unlink():
    stow.unlink_targets()


if __name__ == "__main__":
    cli()
