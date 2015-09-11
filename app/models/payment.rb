class Payment
  include Mongoid::Document
  include Mongoid::Timestamps
  belongs_to :reservation
  belongs_to :restaurant
  field :stripe_data, type: Hash

  def locator
    # TODO DRY this
    i = (id.to_s[5..7] + id.to_s[18..20]).to_i(30)
    "P_" + Hashids.new("The salt of every").encode(i)
  end
end