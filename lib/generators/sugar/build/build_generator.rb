require "rails"

module Sugar
  module Generators
    class BuildGenerator < ::Rails::Generators::Base
      desc "Creates a custom Sugar build."
      source_root File.expand_path("../../../../../vendor/assets", __FILE__)
      argument :packages, :type => :array, :default => []

      def build
        if packages.blank?
          default_packages = [:es5, :object, :array, :number, :regexp, :function, :date, :date_ranges, :date_locales, :string, :inflections, :language]
          say_status("", "")
          say_status("usage", "rails g sugar:build package1 package2 ...")
          say_status("", "")
          say_status("info", "This script creates a custom Sugar build. You can include the following packages:")
          say_status("", "")
          get_package_content(default_packages) do |name, c|
            if name == :date_locales
              description = "Locale definitions: fr, it, es, pt, de, ru, pl, sv, ja, ko, zh-CN, zh-TW"
            else
              match = c.match(/@description (.+)$/)
              description = match[1]
            end
            say_status("", "#{name.to_s + (' ' * (15 - name.size))} #{description}")
          end

          say_status("", "")
          say_status("", "Dependencies must be met for your build to work properly:")
          say_status("", "")
          say_status("", "date   < date_locales")
          say_status("", "date   < date_ranges")
          say_status("", "string < inflections")
          say_status("", "string < language")
          say_status("", "")
          say_status("", "Note that all packages require proper ES5 support, however this package")
          say_status("", "can be omitted if you are only targeting modern browsers (ie. not < IE9).")
          say_status("", "")
          say_status("", "Also note that the core package is required and included by default.")
          say_status("", "Custom builds can also be created at http://sugarjs.com/customize")
          say_status("", "")
          say_status("include", "add `//= require sugar-custom` to your app/assets/javascripts/application.js")
          say_status("", "")

        else
          say_status("Building custom package: " + packages.join(' '), "Sugar", :green)
          content     = ''
          destination = "vendor/assets/javascripts/sugar-custom.js"
          remove_file destination
          get_package_content(packages.unshift('core')) do |name, c|
            content << c
          end
          create_file destination, "(function() { #{content} })();"
        end
      end

      private

      def get_package_content(packages)
        packages.each do |p|
          file = find_in_source_paths "javascripts/precompiled/minified/#{p}.js"
          yield p, File.open(file, 'r').read
        end
      end

    end
  end
end
