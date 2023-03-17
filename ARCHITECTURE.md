# Architecture

This document describes the high-level architecture of `Medians`

`Medians` is organized as a variant of a standard Phoenix layout.  It's based
on old (~ Phoenix 1.4) guidelines that suggest laying out Phoenix apps as an
Umbrella App, except without using an umbrella, so everything is deployed as
a monolithic app.  This gains the advantage of having better code organization
while cutting down on the complexity of the directory structure and following
the guidance that you shouldn't use an umbrella unless you have distinct 
deployment concerns.  Further, "standard" Phoenix contexts are *not* used, 
opting to separate it into "business logic" and "data" layers with specific 
roles.

## Basics

The `/lib` directory contains the following namespaces:

- `Data` (in the `/lib/data` directory).

  Contains data access and mutation concerns.  This includes caching layers, 
  and if any data access were to trigger an updating PubSub message, they would 
  occur here.  This is an abstraction over the Database layer that the business
  layer should interface with.  Any entrypoints into non-database information
  sources (e.g. 3rd party APIs) would also be placed into this layer.

  In general, this directory contains modules of the form `Data.<plural-noun>`
  that contain content with conventional get/fetch/put/insert methods; however,
  if a method has a more complex action (e.g. preloads) they should be
  surfaced at this layer as a specific function each time the business logic
  demands it.

  Other tools, such as caching implementation, or simple 3rd party access 
  helpers, etc. belong in the `Data.Sources.*` namespace.  If the 3rd party
  access is sufficiently complex, it belongs in its own namespace.

- `Db` (in the `/lib/db` directory)

  Contains all database schemas and changesets.  In the future, queries should
  be moved into this namespace.

- `Medians` (in the `/lib/medians` directory)

  Contains business logic and basic application necessities.  Currently there
  is nothing in this namespace.

- `MediansWeb` (in the `/lib/medians_web` directory)

  Contains website concerns.  The following directories exist (note that the
  namespaces correspond to Phoenix namespace conventions and not Elixir 
  namespace conventions):

  - `/lib/medians_web/components`: common components for web design
    - `blurb`: English-language descriptions that are generated from data contents
    - `chart`: Dynamically generatable SVG content
    - `layouts`: Global website layout templates
  - `/lib/medians_web/controllers`: Controllers that can be routed from 
    - `page`: homepage, which currently generates a simple school selector
    - `schools`: entrypoint for the schools resource
      - `index`: (currently unimplemented)
      - `show`: shows the main "school browser" page, providing a description of the school, and
        presenting basic statistics about the school.

## Unexplored architecture strategies:

- Moving actual queries into the `Db` layer and exposing them into `Data`
- Colocating tests into the `/lib` directory.
- Reworking the web namespace to reflect a more Elixir-ish directory/namespace
  mapping and a less Phoenix-ish mapping.
- Moving component and page `.heex` files out of the web directories and into 
  `/assets` for easier discovery and modification by, e.g. frontend developers.