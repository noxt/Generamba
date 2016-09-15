require 'thor'
require 'xcodeproj'
require 'generamba/constants/rambafile_constants.rb'
require 'generamba/helpers/rambafile_validator.rb'
require 'generamba/helpers/xcodeproj_helper.rb'

module Generamba::CLI
  class Application < Thor
    include Generamba

    desc 'gen_json_schema', 'Generate models by JSON schema'
    def gen_json_schema

      does_rambafile_exist = Dir[RAMBAFILE_NAME].count > 0

      unless does_rambafile_exist
        puts('Rambafile not found! Run `generamba setup` in the working directory instead!'.red)
        return
      end

      rambafile_validator = Generamba::RambafileValidator.new
      rambafile_validator.validate(RAMBAFILE_NAME)

      setup_username_command = Generamba::CLI::SetupUsernameCommand.new
      setup_username_command.setup_username

      rambafile = YAML.load_file(RAMBAFILE_NAME)

      project = XcodeprojHelper.obtain_project(rambafile['xcodeproj_path'])
      json_schemas_dir = rambafile['json_schema']['input']
      models_types_dir = rambafile['json_schema']['output']
      generator_dir = rambafile['json_schema']['generator']
      target = rambafile['json_schema']['target']
 
      group_path = Pathname.new(Dir.getwd).join(models_types_dir)
      project_group_path = Pathname.new(models_types_dir)

      puts('Remove old models...')
      generated_filed_path = Pathname.new(Dir.getwd).join(generator_dir).join('output')
      FileUtils.mkdir(generated_filed_path) unless File.exists?(generated_filed_path)

      generated_filed_path.children.each { |p| FileUtils.rm(p) }
      group_path.children.each { |p| FileUtils.rm(p) }
      XcodeprojHelper.clear_group(project, [target], project_group_path)

      puts('Generate models...')
      Pathname.new(Dir.getwd).join(json_schemas_dir).children.each do |json_schema_file_path|
        command = 'cd "%s" && node "%s" -s "%s" -a "%s" -p "%s" -c "%s" --use-struct --has-header && cd "%s"' % [
          Pathname.new(Dir.getwd).join(generator_dir).to_s,
          Pathname.new(Dir.getwd).join(generator_dir).join('index.js').to_s,
          json_schema_file_path,
          Generamba::UserPreferences.obtain_username,
          rambafile['project_name'],
          rambafile['company'],
          Pathname.new(Dir.getwd).to_s
          ]
        system(command)
      end

      puts('Add files to project...')
      FileUtils.cp_r(Dir['%s/*' % generated_filed_path.to_s], group_path.to_s)
      group_path.children.each do |model_file_path|
        XcodeprojHelper.add_file_to_project_and_targets(project, [target], project_group_path, model_file_path)
      end
      
      project.save

      puts('Let\'s go!')
    end
  end
end