def get_database_config
  YAML.load_file(Rails.root.join('config', 'mongo.yml'))
end

Date::DATE_FORMATS[:default] = '%m/%d/%Y'

# if you want to change the format of Time display then add the line below
Time::DATE_FORMATS[:default]= '%m/%d/%Y %H:%M:%S'

require Rails.root.join("lib","names.rb")
require Rails.root.join("lib","tree_helper.rb")
require Rails.root.join("lib/services/employee_requirements.rb")
require Rails.root.join("lib/services/employee_requirements/service.rb")


MongoMapper.setup(get_database_config, Rails.env, {
        :logger    => Rails.logger,
        :passenger => false
})

module IdentityMapAddition
  def self.included(model)
    model.plugin MongoMapper::Plugins::IdentityMap
  end
end

MongoMapper::Document.append_inclusions(IdentityMapAddition)

Cubicle.register_cubicle_directory(Rails.root.join('app','cubicles'))
Cubicle.register_cubicle_directory(Rails.root.join('app','cubes'))
Cubicle::Aggregation::Profiler.enabled = false

#cert_path = Rails.root.join("app","models","credentials")
#searcher = "**/*.rb"
#Dir[File.join(cert_path,searcher)].each do |cert|
#  "Credentials::#{File.basename(cert).split(".")[0].classify}".constantize
#end
