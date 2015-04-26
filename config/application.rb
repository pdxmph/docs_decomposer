require File.expand_path('../boot', __FILE__)

require 'rails/all'


# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module DocsDecomposer
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de

    # Do not swallow errors in after_commit/after_rollback callbacks.
    config.active_record.raise_in_transactional_callbacks = true
    config.time_zone = 'Pacific Time (US & Canada)'

    config.docs = ActiveSupport::OrderedOptions.new

    # Public/production content configuration
    config.docs.public_branch = "master"
    config.docs.public_repo = "puppet-docs"
    config.docs.projects = {'pe' => ['3.7']}

    # Private/pre-release content configuration
    config.docs.dev_repo = "puppet-docs-private"
    config.docs.private_branch = "pe38-dev"
    config.docs.dev_directory= 'pe'
    config.docs.dev_version = '3.7'
    config.docs.dev_version_number = '3.8-dev'
  end
end
