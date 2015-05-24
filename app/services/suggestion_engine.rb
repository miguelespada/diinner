class SuggestionEngine
  def initialize user
    @user = user
  end

  def search date, price
    # TODO here should be the magic
    results = []
    Table.all.each do |table|
      if table.matches?(date, price, {male: 1, female: 0})
        results << Reservation.new({user: @user,
                                    table: table,
                                    price: price})
      end
    end
    results
  end
end