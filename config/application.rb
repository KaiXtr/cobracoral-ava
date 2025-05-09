require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module CobracoralWebsite
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")

    # Abrir variáveis LOCAL_ENV e SECRETS_ENV

    config.before_configuration do
      env_file = File.join(Rails.root, 'config', 'local_env.yml')
      YAML.load(File.open(env_file)).each do |key, value|
        ENV[key.to_s] = value.to_s
      end if File.exist?(env_file)

      secrets_env_file = File.join(Rails.root, 'config', 'secrets_env.yml')
      YAML.load(File.open(secrets_env_file)).each do |key, value|
        ENV[key.to_s] = value.to_s
      end if File.exist?(secrets_env_file)
    end

    # Logger

    if Rails.env.test?
      config.logger = Logger.new("log/test.log")
    end
    if Rails.env.development?
      config.logger = Logger.new("log/development.log")
    end
    if Rails.env.production?
      config.logger = Logger.new("log/production.log")
    end
    config.log_level = :info
    
    # Redis

    #config.cache_store = :redis_store,
    #    ENV['REDIS_URL'] + ':' + ENV['REDIS_PORT'] + '/' + ENV['REDIS_DB'] + '/cache',
    #    {}
  end
end
