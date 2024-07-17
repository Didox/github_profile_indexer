require_relative "boot"

require "rails/all"


# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module GithubProfileIndexer
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.1

    # Please, add to the `ignore` list any other `lib` subdirectories that do
    # not contain `.rb` files, or that should not be reloaded or eager loaded.
    # Common ones are `templates`, `generators`, or `middleware`, for example.
    config.autoload_lib(ignore: %w(assets tasks))

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")

     # Configurar o fuso horário para São Paulo
     config.time_zone = 'Brasilia'

     # Configurar o locale padrão para pt-BR
     config.i18n.default_locale = :'en'
    #  config.i18n.default_locale = :'pt-BR'

     # Carregar traduções adicionais do diretório config/locales
     config.i18n.load_path += Dir[Rails.root.join('config', 'locales', '**', '*.{rb,yml}')]

     # Configurar ActiveRecord para usar o fuso horário configurado
     config.active_record.default_timezone = :local
  end
end
