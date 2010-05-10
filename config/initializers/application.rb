def get_database_config
  YAML.load_file(Rails.root.join('config', 'database.yml'))
end

MongoMapper.setup(get_database_config, Rails.env, {
        :logger    => Rails.logger,
        :passenger => false
})

