# Medians

A quick and dirty law school browser.  ~200 law schools' LSAT, GPA, and GRE
score aggregate statistics for inbound classes 2017-2022 are presented

NB: the source for the data is obtained from: 
https://coda.io/d/Elixir-Test-Assignment-Medians_deRalPA8fGX/Data_suAMo#_lujWj
There is one row with unusable data (the school name is missing); this row is not
inserted into the database.

## Up and running.

1. Make sure you have elixir 1.14.2 and erlang OTP/25 running (run `elixir -v`).  
  If you don't, skip to the <a href="#install-elixir">Install Elixir</a> section 
  and come back here.

2. Make sure you have postgres >= 14 running (run `psql --version`).  If you 
  don't, skip to the <a href="#install-postgres">Install Postgres</a> section 
  and come back here.

3. Make sure the default postgres user (postgres/postgres) exists.  (run
  `psql -h localhost -U postgres -W` and type `postgres` at the prompt.)
  To exit postgres, type `\q` at the postgres prompt.

  If you would prefer to use different settings, they can be changed in 
  `config/dev.exs` and `config/test.exs`, at the very top of the file.

4. Clone this repository (`git clone https://github.com/ityonemo/medians`)

5. Enter the repository (`cd medians`)

7. If necessary, set the elixir and erlang versions locally. (`asdf local erlang 25.1.1` 
  and `asdf local elixir 1.14.2`)

8. Fetch the project dependencies. (`mix deps.get`)

9. Initialize the database (`mix ecto.reset`)

You are now ready to run the web app.

- run:  `iex -S mix` and point your browser to http://localhost:4000

### Install Elixir

The easiest way to ensure correct versions of Elixir is to use the **asdf-vm** 
version management system.  This is a CLI tool that will manage elixir at the
per-directory level.  Note that Elixir requires both the Elixir system and the
Erlang virtual machine, and the versions of both must be managed separately.

Instructions for installing asdf-vm are here:  https://asdf-vm.com/guide/getting-started.html

This works for both macos (`brew install asdf`) and linux (see within).  
Windows?  Maybe works with WSL, who knows ¯\_(ツ)_/¯

Don't forget to activate asdf on your command line:  https://asdf-vm.com/guide/getting-started.html#_3-install-asdf

Once you have asdf, install the elixir and erlang packages:

- `asdf install erlang 25.1.1`
- `asdf install elixir 1.14.2`

And this is a relatively good pairing, you might as well make it the global default:

- `asdf global erlang 25.1.1`
- `asdf global elixir 1.14.2`

Note that you can set the versions at a per-directory level using `asdf local ...`.

### Install Postgres

Linux, ubuntu:

1. `sudo apt install postgresql`
2. `sudo -u postgres psql template1`
  - `ALTER USER postgres with encrypted password 'postgres'`
  - `/q`

Mac:

1. `brew install postgres@14`
2. `sudo -u postgres psql template1`
  - `ALTER USER postgres with encrypted password 'postgres'`
  - `/q`
