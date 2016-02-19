every 1.day, :at => '00:01 am' do
  runner "TableManager.process_today_tables"
end

every 1.day, :at => '6:00 pm' do
  runner "TableManager.process_last_minute_tables"
end

every 1.day, :at => '2:00 am' do
  runner "Admin.remove_old_logs"
end

every 1.day, :at => '3:00 am' do
  runner "TableManager.remove_old_tables"
end

every 1.day, :at => '5:00 am' do
  runner "Reservation.invite_to_evaluate"
end

