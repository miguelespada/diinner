class BlogPost
  include Mongoid::Document

  has_attachment :picture, accept: [:jpg, :png, :gif]

  field :title, type: String
  field :url, type: String

  def self.get_three_random
    BlogPost.all.desc('created_at').sample(3)
  end

  def self.cached_posts
    Rails.cache.fetch("blog_posts_cache", expires_in: 24.hours) do
      BlogPost.get_three_random.to_a
    end
  end
end
