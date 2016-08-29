require 'thor'
require 'xcodeproj'
require 'generamba/constants/rambafile_constants.rb'
require 'generamba/helpers/rambafile_validator.rb'
require 'generamba/helpers/xcodeproj_helper.rb'

module Generamba::CLI
  class Application < Thor
    include Generamba

    desc 'json_schema', 'Generate models by JSON schema'
    def json_schema

    #   does_rambafile_exist = Dir[RAMBAFILE_NAME].count > 0

    #   unless does_rambafile_exist
    #     puts('Rambafile not found! Run `generamba setup` in the working directory instead!'.red)
    #     return
    #   end

    #   rambafile_validator = Generamba::RambafileValidator.new
    #   rambafile_validator.validate(RAMBAFILE_NAME)

    #   setup_username_command = Generamba::CLI::SetupUsernameCommand.new
    #   setup_username_command.setup_username

    #   rambafile = YAML.load_file(RAMBAFILE_NAME)

    #   project = XcodeprojHelper.obtain_project(rambafile.xcodeproj_path)
    #   json_schemas_dir = rambafile.json_schema.input
    #   models_types_dir = rambafile.json_schema.output
    #   generator_dir = rambafile.json_schema.generator

    #   # Remove old models
    #   Pathname.new(Dir.getwd).join(generator_dir).join('output').children.each { |p| p.unlink }
    #   XcodeprojHelper.clear_group(project, rambafile.project_target, models_types_dir)

    #   # Generate models
    #   Pathname.new(Dir.getwd).join(json_schemas_dir).children.each do |json_schema_file_path|
    #     exec('node "%s" -s "%s" -a "%s" -p "%s" -c "%s"" --use-struct --has-header' % [
    #       Pathname.new(Dir.getwd).join(generator_dir).to_s,
    #       json_schema_file_path,
    #       Generamba::UserPreferences.obtain_username,
    #       rambafile.project_name,
    #       rambafile.company
    #       ])
    #   end

    #   # Add files to project
    #   Pathname.new(Dir.getwd).join(generator_dir).join('output').children.each do |model_file_path|
    #     XcodeprojHelper.add_file_to_project_and_targets(project, rambafile.project_target, models_types_dir, model_file_path)
    #   end

    end
  end
end