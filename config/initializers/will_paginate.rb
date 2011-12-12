# a workaround for ActiveAdmin to work with will_paginate
# https://github.com/mislav/will_paginate/issues/174
if defined?(WillPaginate)
  module WillPaginate
    module ActiveRecord
      module RelationMethods
        alias_method :per, :per_page
        alias_method :num_pages, :total_pages
        alias_method :total_count, :count
      end
    end
  end
end
