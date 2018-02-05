require 'redmine'

Rails.configuration.to_prepare do
  require_dependency 'issues_helper'
  IssuesHelper.send(:include, IssuesHelperPatch)
end

Rails.application.config.i18n.load_path += Dir["#{File.dirname(__FILE__)}/config/locales/*.{rb,yml}"]

Redmine::Plugin.register :redmine_custom_query_status do
  name 'Redmine Custom Query Status plugin'
  author 'WATANABE Koichi'
  description 'チケット一覧のカスタムクエリ一覧にクエリに該当するチケット数を表示する'
  version '0.0.2'
end
