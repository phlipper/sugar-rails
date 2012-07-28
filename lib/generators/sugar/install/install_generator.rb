require "rails"

# Supply generator for Rails 3.0.x or if asset pipeline is not enabled
if ::Rails.version < "3.1" || !::Rails.application.config.assets.enabled
  module Sugar
    module Generators
      class InstallGenerator < ::Rails::Generators::Base
        desc "This generator installs Sugar #{Sugar::Rails::SUGARJS_VERSION}"
        source_root File.expand_path("../../../../../vendor/assets", __FILE__)

        def copy_javascript
          say_status("copying", "Sugar", :green)
          copy_file "javascripts/sugar.js", "public/javascripts/sugar.js"
        end
      end
    end
  end
else
  module Sugar
    module Generators
      class InstallGenerator < ::Rails::Generators::Base
        desc "Just show instructions so people will know what to do when mistakenly using generator for Rails 3.1 apps"

        def do_nothing
          say_status("deprecated", "You are using Rails 3.1 with the asset pipeline enabled, so this generator is not needed.")
          say_status("", "The necessary files are already in your asset pipeline.")
          say_status("", "Just add `//= require sugar` to your app/assets/javascripts/application.js")
          say_status("", "If you upgraded your app from Rails 3.0 and still have sugar.js in your public assets folders, be sure to remove them.")
          say_status("", "If you do not want the asset pipeline enabled, you may turn it off in application.rb and re-run this generator.")
          # ok, nothing
        end
      end
    end
  end
end
