class SuggestionEngine
  def initialize user
    @user = user
  end

  def search date, price, companies
    # TODO here should be the magic
    results = []
    Table.all.each do |table|
      if table.matches?(date, price, companies)
        results << Reservation.new({user: @user,
                                    table: table,
                                    price: price,
                                    companies: companies})
      end
    end
    results
  end
end