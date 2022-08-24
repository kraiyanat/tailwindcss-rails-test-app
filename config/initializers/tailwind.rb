# Tailwind configuration file

class Tailwindcss::Configuration

  COMPILE_FILES_CONFIGURATION = [
    {
      entry: "app/assets/stylesheets/application.tailwind.css",
      output: "app/assets/builds/tailwind.css",
      tailwind_config: "config/tailwind.config.js"
    },
    {
      entry: "app/assets/stylesheets/application.tailwind_2.css",
      output: "app/assets/builds/tailwind_2.css",
      tailwind_config: "config/tailwind_2.config.js"
    },
    # extra_compile_file_configurations
    # {
    #   entry: "",
    #   output: "",
    #   tailwind_config: ""
    # }
  ]
end
