## Invoiceninja-Caddy for Dokku

This Dockerfile can be used to push [Invoiceninja](https://github.com/invoiceninja/invoiceninja) a server running Dokku.

## Connecting to Database

This Dockerfile automatically parses `DATABASE_URL` environment variable of a linked database container and makes Invoiceninja use it. No configuration required.

## Installation

Just clone and push to your Dokku installation.

# License
MIT