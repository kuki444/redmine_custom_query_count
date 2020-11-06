require_dependency 'queries_helper'

module QueriesHelperPatch
  def query_links(title, queries)
    return '' if queries.empty?
    # links to #index on issues/show
    url_params =
      if controller_name == 'issues'
        {:controller => 'issues', :action => 'index', :project_id => @project}
      else
        {}
      end
    content_tag('h3', title) + "\n" +
      content_tag(
        'ul',
        queries.collect do |query|
          css = +'query'
          clear_link = +''
          if query == @query
            css << ' selected'
            clear_link += link_to_clear_query
          end
          if controller_name == 'issues'
            content_tag('li',
                        link_to(query.name + "(" + query.issue_count.to_s + ")",
                                url_params.merge(:query_id => query),
                                :class => css) +
                                clear_link.html_safe)
          else
            content_tag('li',
                        link_to(query.name,
                                url_params.merge(:query_id => query),
                                :class => css) +
                                clear_link.html_safe)
          end
        end.join("\n").html_safe,
        :class => 'queries'
      ) + "\n"
  end
end

module QueriesHelper
  prepend QueriesHelperPatch
end