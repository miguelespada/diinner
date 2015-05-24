class SuggestionEngine
  def initialize user
    @user = user
  end

  def search date, price, companies
    # TODO here should be the magic
    results = []
    Table.all.each do |table|
      reservation = Reservation.new({user: @user,
                                    price: price,
                                    date: date,
                                    companies: companies})
      if table.matches?(reservation)
        reservation.table = table
        results << reservation
      end
    end
    results
  end
end