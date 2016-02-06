class BlogPost
  include Mongoid::Document

  has_attachment :picture, accept: [:jpg, :png, :gif]

  field :title, type: String
  field :url, type: String

  def self.get_three_random
    BlogPost.all.desc('created_at').limit(3)
  end

end
