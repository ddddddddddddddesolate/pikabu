# frozen_string_literal: true

module Resolvers
  class PostsResolver < BaseResolver
    type [Types::PostType], null: false

    argument :filters, Types::PostsFiltersType, required: false
    argument :order, Types::OrderFieldsType, required: false
    argument :paginate, Types::PaginationType, required: false
    argument :search, Types::PostsSearchType, required: false

    def resolve(filters: nil, order: nil, paginate: nil, search: nil)
      @posts = Post.includes(:user, :tags, :images, reactions: [:user]).page(1)

      order_posts(order) if order
      filter_posts(filters) if filters
      paginate_posts(paginate) if paginate
      search_posts(search) if search

      @posts
    end

    private

    def order_posts(order)
      @posts = @posts.likes(order.likes) if order.likes
      @posts = @posts.date(order.date) if order.date
    end

    def filter_posts(filters)
      @posts = @posts.fresh if filters.fresh
      @posts = @posts.best if filters.best
      @posts = @posts.hot if filters.hot

      @posts = @posts.tags(filters.tags) if filters.tags
    end

    def paginate_posts(paginate)
      @posts = @posts.page(paginate.page).per(paginate.per)
    end

    def search_posts(search)
      @posts = @posts.search(search.title)
    end
  end
end
