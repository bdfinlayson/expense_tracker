namespace :db do
  desc 'Imports the Heroku database into the local one'

  task import: :environment do
    dbconfig = Rails.configuration.database_configuration[Rails.env].with_indifferent_access

    Bundler.with_clean_env do
      %x[
        heroku pg:backups capture -a budgetwise
        curl -o latest.dump `heroku pg:backups public-url -a budgetwise`
        pg_restore --verbose --clean --no-acl --no-owner -U bryanfinlayson -d #{dbconfig[:database]} latest.dump
      ]
    end
  end
end

