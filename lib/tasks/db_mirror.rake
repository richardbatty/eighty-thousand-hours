namespace :db do
  def local_db
    config_file = File.join Rails.root, 'config', 'database.yml'
    doc = YAML::load_file(config_file)
    doc[Rails.env]['database']
  end

  desc 'Copies production db into local development db'
  app = "eighty-thousand-hours"
  task :mirror do
    system(%Q{
      heroku pgbackups:capture --expire --app #{app} && \
      curl -o /tmp/hic-db.dump $(heroku pgbackups:url --app #{app}) && \
      pg_restore --verbose --clean --no-acl --no-owner -d #{local_db} /tmp/hic-db.dump
    })
  end
end
