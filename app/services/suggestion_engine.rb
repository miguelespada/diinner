class SuggestionEngine
  
  def initialize user
    @user = user
  end

  def search date, price
    # TODO here should be the magic
    results = []
    Table.all.each do |table|
      results << Reservation.new({user: @user, table: table, price: price, date: date})
    end 
    results 
  end
end