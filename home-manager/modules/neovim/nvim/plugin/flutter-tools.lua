-- .nvim.lua
-- If you have more than one setup configured you will be prompted when you run
-- your app to select which one you want to use
require('flutter-tools').setup_project({
  {
    name = 'Development', -- an arbitrary name that you provide so you can recognise this config
    flavor = 'DevFlavor', -- your flavour
    target = 'lib/main_dev.dart', -- your target
    cwd = 'example',      -- the working directory for the project. Optional, defaults to the LSP root directory.
    device = 'pixel6pro', -- the device ID, which you can get by running `flutter devices`
    dart_define = {
      API_URL = 'https://dev.example.com/api',
      IS_DEV = true,
    },
    pre_run_callback = nil, -- optional callback to run before the configuration
    -- exposes a table containing name, target, flavor and device in the arguments
    dart_define_from_file = 'config.json' -- the path to a JSON configuration file
  },
  {
    name = 'Web',
    device = 'chrome',
    flavor = 'WebApp',
    web_port = "4000",
    additional_args = { "--wasm" }
  },
  {
    name = 'Profile',
    flutter_mode = 'profile', -- possible values: `debug`, `profile` or `release`, defaults to `debug`
  }
})
