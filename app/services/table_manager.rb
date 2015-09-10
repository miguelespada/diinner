class TableManager

  def self.remove_old_tables 
    n = 0
    Table.all.each do |table|
      if table.passed? && table.can_be_deleted?
        table.destroy
        n += 1 
      end
    end
    n
  end

  def self.process_table table
    # We built a list of a single item an proceed 
    # Used in last minute dinners
    self.process [table]
  end

  def self.process_today_tables
    self.process today_tables
  end

  def self.process_last_minute_tables
    # Last minute tables can only be cancelled by the deamon
     tables = self.process_last_minute(today_tables)
     self.notify_cancel_last_minute(tables)
  end

  def self.process tables
    tables = self.cancel_partial(tables)
    self.capture(tables)
    self.refund_partial(tables)
    self.refund_last_minute(tables)
    tables = self.cancel_partial(tables)
    self.charge(tables)
    self.notify_confirmations(tables)
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

  def self.process_last_minute tables
    last_minute_tables = []
    tables.each do |table|
      if table.plan_closed?
        table.cancel_last_minute
        last_minute_tables << table
      end
    end
    last_minute_tables
  end

  def self.refund_partial tables
    tables.map{|table| table.refund if !table.plan_closed?}
  end

  def self.refund_last_minute tables
    # Note that this can happen if there is an error in the payment
    tables.map{|table| table.refund_last_minute if table.must_cancel_last_minute?}
  end

  def self.capture tables
    tables.map{|table| table.capture}
  end

  def self.charge tables
    tables.map{|table| table.charge}
  end

  def self.notify_confirmations tables
    tables.map{|table| table.notify_confirmation}
  end

   def self.notify_cancel_last_minute tables
    tables.map{|table| table.notify_cancel_last_minute}
  end
end