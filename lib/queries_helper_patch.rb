require_dependency 'queries_helper'

module QueriesHelperPatch
  def self.included(base)
    base.send(:include, InstanceMethods)
    base.class_eval do
      alias_method_chain :query_links, :count
    end
  end
 
  module InstanceMethods
    def query_links_with_count(title, queries)
      return '' if queries.empty?
      # links to #index on issues/show
      url_params = controller_name == 'issues' ? {:controller => 'issues', :action => 'index', :project_id => @project} : params

      content_tag('h3', title) + "\n" +
        content_tag('ul',
          queries.collect {|query|
              query.project = @project
              css = 'query'
              css << ' selected' if query == @query
              content_tag 'li' do
                concat link_to(query.name , url_params.merge(:query_id => query), :class => css)
                concat "(" + query.issue_count.to_s + ")"
              end
            }.join("\n").html_safe,
          :class => 'queries'
        ) + "\n"
    end
  end
end
