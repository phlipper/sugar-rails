require "rails"

module Sugar
  module Generators
    class BuildGenerator < ::Rails::Generators::Base
      source_root File.expand_path("../../../../../vendor/assets", __FILE__)
      argument :packages, :type => :array, :default => []
      class_option :minify, :type => :boolean, :default => false

      desc "Creates a custom Sugar build."
      def build
        return unless valid_rails_version?

        if packages.present?
          build_packages
        else
          display_help
        end
      end


      private

      def get_package_content(packages)
        type = options.minify? ? "minified" : "development"
        base_path = "javascripts/precompiled/#{type}"

        packages.each do |name|
          filename = find_in_source_paths "#{base_path}/#{name}.js"
          yield name, File.read(filename)
        end
      end

      def build_packages
        output = ""
        destination = "vendor/assets/javascripts/sugar-custom.js"

        say_status "", ""
        say_status "build", "Custom Sugar packages: #{packages.join(", ")}", :green

        remove_file destination
        packages.unshift("core")  # add 'core' package to the top of the bulid
        get_package_content(packages) { |name, content| output << content }
        create_file destination, "(function() { #{output} })();"

        say_status "", ""
        say_status "success", "Add `//= require sugar-custom` to your app/assets/javascripts/application.js", :green
        say_status "", ""
      end

      def valid_rails_version?
        valid = ::Rails.version >= "3.1" && ::Rails.application.config.assets.enabled

        unless valid
          say_status "", ""
          say_status "error", "You are using Rails below version 3.1 or the Asset Pipeline is not enabled.", :red
          say_status "", "This generator requires Rails 3.1+ and the Asset Pipeline."
          say_status "", ""
          say_status "", "Please ensure that you are running a supported version of Rails."
          say_status "", "Yoy may need to enable the Asset Pipeline by setting `config.assets.enabled = true` in your `config/application.rb` file."
        end

        valid
      end

      def display_help
        default_packages = [
          :es5, :object, :array, :number, :regexp, :function, :date,
          :date_ranges, :date_locales, :string, :inflections, :language
        ]

        say_status "", ""
        say_status "[USAGE]", "rails g sugar:build package1 package2 ... [options]", :yellow
        say_status "", ""
        say_status "", "This script creates a custom Sugar build."
        say_status "", "You can include the following packages:"
        say_status "", ""


        get_package_content(default_packages) do |name, content|
          description = if name == :date_locales
            "Locale definitions: fr, it, es, pt, de, ru, pl, sv, ja, ko, zh-CN, zh-TW"
          else
            content[/@description (.+)$/, 1]
          end

          say_status "", "#{name.to_s.ljust(15)} #{description}"
        end

        say_status "", ""
        say_status "", "Dependencies must be met for your build to work properly:"
        say_status "", ""
        say_status "", "date   < date_locales"
        say_status "", "date   < date_ranges"
        say_status "", "string < inflections"
        say_status "", "string < language"
        say_status "", ""
        say_status "", "Note that all packages require proper ES5 support, however this package"
        say_status "", "can be omitted if you are only targeting modern browsers (ie. not < IE9)."
        say_status "", ""
        say_status "", "Also note that the core package is required and included by default."
        say_status "", "Custom builds can also be created at http://sugarjs.com/customize"
        say_status "", ""
      end
    end
  end
end
