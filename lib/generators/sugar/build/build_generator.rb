require "rails"

module Sugar
  module Generators
    class BuildGenerator < ::Rails::Generators::Base
      desc "Creates a custom Sugar build."
      source_root File.expand_path("../../../../../vendor/assets", __FILE__)

      def build(*packages)
        say_status("hi there building " + packages.to_s, "Sugar JS", :green)
        #copy_file "javascripts/sugar.js", "public/javascripts/sugar.js"
      end

    end
  end
end
