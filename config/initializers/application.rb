def get_database_config
  YAML.load_file(Rails.root.join('config', 'mongo.yml'))
end

Date::DATE_FORMATS[:default] = '%m/%d/%Y'

# if you want to change the format of Time display then add the line below
Time::DATE_FORMATS[:default]= '%m/%d/%Y %H:%M:%S'


MongoMapper.setup(get_database_config, Rails.env, {
        :logger    => Rails.logger,
        :passenger => false
})

