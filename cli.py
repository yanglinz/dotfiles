#!/usr/bin/env python3

import click

from scripts import linker


@click.group()
def cli():
    pass


@cli.command()
def link():
    linker.link_targets()


if __name__ == "__main__":
    cli()
