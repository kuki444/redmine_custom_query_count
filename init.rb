require 'redmine'

Rails.configuration.to_prepare do
  require_dependency 'queries_helper'
  QueriesHelper.send(:include, QueriesHelperPatch)
end

Rails.application.config.i18n.load_path += Dir["#{File.dirname(__FILE__)}/config/locales/*.{rb,yml}"]

Redmine::Plugin.register :redmine_custom_query_count do
  name 'Redmine Custom Query Count plugin'
  author 'Norio Kuki'
  description 'チケット一覧のカスタムクエリ一覧にクエリに該当するチケット数を表示する'
  version '0.4.0'
  url 'https://github.com/kuki444/redmine_custom_query_count'
end
