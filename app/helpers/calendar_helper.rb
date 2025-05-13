module CalendarHelper
  def calendar_td_classes(day)
    classes = ["day"]
    classes << "today" if day == Date.today
    classes << "past" if day < Date.today
    classes << "future" if day > Date.today
    classes << "closed-day" if ClosedDay.closed?(day)
    classes.join(" ")
  end

  def closed_day_reason(date)
    closed_day = ClosedDay.find_by(date: date)
    closed_day&.reason
  end
end