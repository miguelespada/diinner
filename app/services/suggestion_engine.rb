class SuggestionEngine
  def initialize user
    @user = user
  end

  def search date, price, companies
    # TODO here should be the magic
    results = []
    Table.all.each do |table|
      reservation = Reservation.new({user: @user,
                                    table: table,
                                    price: price,
                                    date: date,
                                    companies: companies})
      results << reservation if table.matches?(reservation)
    end
    results
  end
end