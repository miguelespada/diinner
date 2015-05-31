class TableManager

  def process
    # [valid, cancelled] = cancel_partial(today_tables)
    # reserve_payments(valid)
    # [valid, cancelled] = cancel_incomplete(tables)
    # [valid, cancelled] = capture_payments(tables)
  end

  def self.today_tables
    Table.where(date: Date.today)
  end

  def cancel_partial tables
    # cancelled = []
    # valid = []
    # tables.each do |table|
    #   if table.partial?
    #     table.cancel
    #     cancelled << table
    #   else
    #     valid << table
    #   end
    # end
  end

end