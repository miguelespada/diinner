class SuggestionEngine
  def initialize user
    @user = user
  end

  def search date, price, customer_count = 1
    # TODO here should be the magic
    results = []
    Table.all.each do |table|
      if table.matches?(date, price, customer_count)
        results << Reservation.new({user: @user, table: table, price: price})
      end
    end
    results
  end
end