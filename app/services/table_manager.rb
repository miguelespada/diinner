class TableManager

  def self.process
    Reservation.all.map{|r| p r.create_stripe_charge}
    tables = self.cancel_partial(today_tables)

    self.capture(tables)
    # [valid, cancelled] = capture_payments(tables)
  end

  def self.today_tables
    Table.where(date: Date.today)
  end

  def self.cancel_partial tables
    valid_tables = []
    tables.each do |table|
      if table.partial?
        table.cancel
        table.notify_cancellation
      else
        valid_tables << table
      end
    end
    valid_tables
  end

  def self.capture tables
    tables.map{|table| table.capture}
  end


end