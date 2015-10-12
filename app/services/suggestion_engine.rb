class SuggestionEngine

  def initialize user, params = {}
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
    return Date.tomorrow if @params[:date].empty? 
    Date.strptime(@params[:date], "%d/%m/%Y")
  end

  def date_in_range?
    date >= Date.tomorrow && date <= 2.weeks.from_now
  end

  def price
    @params[:price]
  end

  def after_plan
    @params[:after_plan]
  end

  def city
    City.find(@params[:city])
  end

  def search
    results = []
    Table.where(:date => date).each do |table|
      if table.city == city
        # TODO plan is today should be plan_closed?
        reservation = Reservation.new({user: @user,
                                      price: range_to_price(price),
                                      date: date,
                                      after_plan: after_plan,
                                      companies: companies})

        if table.matches?(reservation)
          reservation.table = table
          results << reservation
        end
      end
    end
    results
  end

  # TODO refactor and DRY
  def last_minute
    results = []
    Table.where(:date => Date.today).each do |table|
      if table.city == @user.city
        reservation = Reservation.new({user: @user,
                                      price: range_to_price(@user.menu_range),
                                      date: Date.today})

        if table.matches?(reservation)
          reservation.table = table
          results << reservation
        end
      end
    end
    results
  end

  def range_to_price range
    return 20 if range == "lowcost"
    return 40 if range == "regular"
    return 60 if range == "premium"
  end
end