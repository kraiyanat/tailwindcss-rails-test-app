
require "#{Rails.root.join('config/initializers/tailwind.rb')}"

FULL_GEM_PATH = Gem.loaded_specs['tailwindcss-rails'].full_gem_path

TAILWIND_COMPILE_COMMANDS = Tailwindcss::Configuration::COMPILE_FILES_CONFIGURATION.map do |files_set|
    "#{RbConfig.ruby} #{Pathname.new(FULL_GEM_PATH).to_s}/exe/tailwindcss -i '#{Rails.root.join("#{files_set[:entry]}")}' -o '#{Rails.root.join("#{files_set[:output]}")}' -c '#{Rails.root.join("#{files_set[:tailwind_config]}")}' --minify"
end

Rake::Task["tailwindcss:build"].clear
Rake::Task["tailwindcss:watch"].clear
namespace :tailwindcss do
  desc "Build your Tailwind CSS"
  task :build do
    TAILWIND_COMPILE_COMMANDS.each do |command|
      system(command, exception: true)
    end
  end

  desc "Watch and build your Tailwind CSS on file changes"
  task :watch do 
    system "#{TAILWIND_COMPILE_COMMANDS[0]} -w"
  end
end

Rake::Task["assets:precompile"].enhance(["tailwindcss:build"])

if Rake::Task.task_defined?("test:prepare")
  Rake::Task["test:prepare"].enhance(["tailwindcss:build"])
elsif Rake::Task.task_defined?("db:test:prepare")
  Rake::Task["db:test:prepare"].enhance(["tailwindcss:build"])
end