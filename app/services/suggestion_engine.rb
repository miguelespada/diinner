class SuggestionEngine
  def initialize user, params
    @user = user
    @params = params
  end

    # TODO maybe push to suggestion engine
  def companies
    company = []
    @params[:companies_attributes].each do |company_params|
      c = company_params[1]
      if !c[:age].blank? && !c[:gender].blank?
        company << Company.new(c)
      end
    end
    company
  end

  def date
    Date.strptime @params[:date]
  end

  def price
    price = @params[:price].to_i
  end


  def search
    results = []
    Table.where(:date => date).each do |table|
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