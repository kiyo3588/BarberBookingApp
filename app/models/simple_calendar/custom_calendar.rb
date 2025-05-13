module SimpleCalendar
  class CustomCalendar < SimpleCalendar::Calendar
    def td_classes_for(day)
      classes = super
      classes << " closed-day" if ClosedDay.closed?(day)
      classes
    end
  end
end