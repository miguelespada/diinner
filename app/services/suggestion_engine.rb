class SuggestionEngine
  def initialize user, params
    @user = user
    @params = params
  end

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
    Date.strptime(@params[:date], "%d/%m/%Y")
  end

  def price
    @params[:price].to_i
  end

  def city
    City.find(@params[:city])
  end

  def search
    results = []
    Table.where(:date => date).each do |table|
      if table.city == city
        reservation = Reservation.new({user: @user,
                                      price: price,
                                      date: date,
                                      companies: companies})

        if table.matches?(reservation)
          reservation.table = table
          results << reservation
        end
      end
    end
    results
  end
end