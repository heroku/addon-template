# Heroku Add-on

Sinatra-based Heroku Add-on provisioning service, generated with the
[Pliny](https://github.com/interagent/pliny) gem.

For more information please refer to the Pliny gem docs.

## Getting Started

Deploy your copy via the Heroku Button

[![Deploy](https://www.herokucdn.com/deploy/button.png)](https://heroku.com/deploy?template=https://github.com/heroku/addon-template)

Then run the following commands to work with the generated code locally:

```sh-session
heroku git:clone --app <new-app-name>
bin/setup
kensa init
#edit addon-manifest.json in your favorite editor
kensa push
```

### addon-manifest.json

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

If your add-on does not rely on providing environment variables
