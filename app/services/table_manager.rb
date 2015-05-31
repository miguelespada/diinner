class TableManager

  def self.process
    tables = self.cancel_partial(today_tables)
    # capture(tables)
    # [valid, cancelled] = capture_payments(tables)
  end

  def self.today_tables
    Table.where(date: Date.today)
  end

  def self.cancel tables
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

  def capture tables
    table.map{|t| t.capture}
  end


end