# Heroku Add-on Template

Sinatra-based Heroku Add-on provisioning service, generated with the
[Pliny](https://github.com/interagent/pliny) gem.

## Getting Started

Deploy your copy via the Heroku Button

[![Deploy](https://www.herokucdn.com/deploy/button.png)](https://heroku.com/deploy?template=https://github.com/heroku/addon-template)

Then run the following commands to work with the generated code locally:

```sh-session
heroku git:clone --app <new-app-name>
bin/setup
kensa init
#edit addon-manifest.json in your favorite editor - see notes below
kensa push
```

## A high-level tour of how the addon-template works

Please see [How Add-ons
Work](https://devcenter.heroku.com/articles/how-add-ons-work) first.

Most of the work happens in `Mediators::*` classes, which are invoked via
endpoints when something happens relative to an add-on associated with an
application.

Endpoints are defined in the [lib/endpoints/](lib/endpoints) directory, and
mounted in [lib/routes.rb](lib/routes.rb). The most relevant endpoints are
in [lib/endpoints/heroku/resources.rb](Endpoints::Heroku::Resources).

Look through the code for `FIXME` comments pointing out specific relevant code
paths.

### Provisioning a new add-on

When a heroku customer requests an instance of your add-on, we POST to your
add-on's `/heroku/resources` endpoint identifying the app, the plan, the region
and other metadata. This initializes and runs
[Mediators::Resources::Creator.call](lib/mediators/resources/creator.rb), which
is where you do whatever creates the services your add-on provides. You return
app specific environment variables here that are exported to the provisioning
heroku app's environment.

### Deprovisioning an add-on

When an add-on is deprovisioned, we send a DELETE request to the
`/heroku/resources/:id` endpoint with the `id` you returned to us as part of
the original provisioning request.  This initializes and runs
[Mediators::Resources::Destroyer.call](lib/mediators/resources/destroyer.rb),
which is where you remove the app specific services.

### Changing an add-on's plan

When an add-on's plan changes, we PUT to your add-on's `/heroku/resources/:id`
endpoint with metadata similar to a provisioning call. This initializes and
runs [Mediators::Resources::Updater.call](lib/mediators/resources/updater.rb).
If you need to return new environment variables (say, a new connection string
because of a plan change), return those here similar to a provisioning call.

## Notes

### addon-manifest.json

The add-on manifest is a JSON document which [describes the
interface](https://devcenter.heroku.com/articles/add-on-manifest) between
Heroku and your service.  It's used for both local development via the [kensa
gem](https://github.com/heroku/kensa) and to [submit your
add-on](https://devcenter.heroku.com/articles/submitting-an-add-on) to the
marketplace.

**id**

Set the value for `id` to a lowercase, URL-friendly version of your add-on's
name.

_Choose wisely; once your add-on has been created under this name, it cannot be
changed._

**api: config_vars**

If you wish to provide configuration variables to applications that install
your add-on, include every uppercase variable name here. You _must_ list every
variable you will send in response to a provision request, or your response
will be rejected, and installation will fail for the customer.

If your add-on does not rely on providing environment variables, then you do
not need to list config vars here.

### Using Kensa to test your service

Refer to the [Building a Heroku
Add-on](https://devcenter.heroku.com/articles/building-a-heroku-add-on) article
for instructions and how to use kensa to test your add-on service.

### Initializing and using postgres extensions on linux

If you're using postgres on linux (rather than osx), you're probably not using
a superuser account during development.  This means the database init run
during `./bin/setup` will fail due to insufficient privileges.

The easiest fix is to add the relevant procedural languages to `template1` as
the postgres superuser, and then re-run `./bin/setup`.

        sudo -u postgres psql template1
        psql# create extension "plpgsql";
        psql# create extension "uuid-ossp";

### bundler-audit

We use [bundler-audit](https://github.com/rubysec/bundler-audit) to ensure we
aren't using gems with known vulnerabilities. It runs automatically in the
default rake task and, consequently, on travisci. If a gem with a known
vulnerability is found, the build will fail.

## See also

- [The pliny gem docs](http://www.rubydoc.info/gems/pliny/)
- [The pliny wiki](https://github.com/interagent/pliny/wiki)
- [Building a Heroku
  Add-on](https://devcenter.heroku.com/articles/building-a-heroku-add-on)

## License

MIT License. See [LICENSE](https://github.com/heroku/addon-template/blob/master/LICENSE).
