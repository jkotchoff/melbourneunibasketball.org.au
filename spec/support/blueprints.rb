require 'machinist/active_record'

# Add your blueprints here.
#
# e.g.
#   Post.blueprint do
#     title { "Post #{sn}" }
#     body  { "Lorem ipsum..." }
#   end

NewsItem.blueprint do
  title          { "Post #{sn}" }
  author         { "Author #{sn}" }
  synopsis       { "Synopsis #{sn}" }
  created_at     { Time.now }
end

Member.blueprint do
  # Attributes here
end
