# frozen_string_literal: true

module Ads
  module PaginationLinks
    def pagination_links(model, request_path, current_page)
      return {} if model.total_pages.zero?

      links = {
        first: pagination_link(request_path, page: 1),
        last: pagination_link(request_path, page: model.total_pages)
      }
      if next_page_exists?(model, current_page)
        links[:next] = pagination_link(request_path, page: next_page(current_page))
      end
      if previous_page_exists?(model, current_page)
        links[:prev] = pagination_link(request_path, page: previous_page(current_page))
      end

      links
    end

    private

    def pagination_link(request_path, page:)
      url_for(request_path, page)
    end

    def next_page(current_page)
      return 2 if current_page <= 0

      current_page + 1
    end

    def next_page_exists?(model, current_page)
      model.total_pages >= current_page + 1
    end

    def previous_page(current_page)
      current_page - 1
    end

    def previous_page_exists?(model, current_page)
      previous_page = current_page - 1
      previous_page.positive? && previous_page < model.total_pages
    end

    def url_for(request_path, page)
      "#{request_path}?page=#{page}"
    end
  end
end
