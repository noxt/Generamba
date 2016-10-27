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
      models_types_dir = rambafile['json_schema']['models_path']
      gen_command = rambafile['json_schema']['gen_command']
      generator_dir = rambafile['json_schema']['generator_dir']
      target = rambafile['json_schema']['target']
 
      group_path = Pathname.new(Dir.getwd).join(models_types_dir)
      project_group_path = Pathname.new(models_types_dir)

      puts('Remove old models...')
      group_path.children.each { |p| FileUtils.rm(p) }
      XcodeprojHelper.clear_group(project, [target], project_group_path)

      puts('Generate models...')
      command = 'cd "%s" && %s && cd "%s"' % [
        Pathname.new(Dir.getwd).join(generator_dir).to_s,
        gen_command,
        Pathname.new(Dir.getwd).to_s
        ]
      system(command)

      puts('Add files to project...')
      group_path.children.each do |model_file_path|
        XcodeprojHelper.add_file_to_project_and_targets(project,
                                                        [target],
                                                        project_group_path,
                                                        group_path,
                                                        false,
                                                        model_file_path,
                                                        false)
      end
      
      project.save

      puts('Let\'s go!')
    end
  end
end