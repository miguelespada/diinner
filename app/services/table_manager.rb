class TableManager

  def self.process_table table
    # We built a list of a single item an proceed 
    # Used in last minute dinners
    self.process [table]
  end

  def self.process_today_tables
    self.process today_tables
  end

  def self.process tables
    tables = self.cancel_partial(tables)
    self.capture(tables)
    self.refund_partial(tables)
    tables = self.cancel_partial(tables)
    self.charge(tables)
    self.notify_plans(tables)
  end

  def self.today_tables
    Table.where(date: Date.today)
  end

  def self.cancel_partial tables
    valid_tables = []
    tables.each do |table|
      if !table.plan_closed?
        table.cancel
        table.notify_cancellation
      else
        valid_tables << table
      end
    end
    valid_tables
  end

  def self.refund_partial tables
    tables.map{|table| table.refund if !table.plan_closed?}
  end

  def self.capture tables
    tables.map{|table| table.capture}
  end

  def self.charge tables
    tables.map{|table| table.charge}
  end

  def self.notify_plans tables
    tables.map{|table| table.notify_plan}
  end
end