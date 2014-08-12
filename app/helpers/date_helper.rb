module DateHelper

  # take a regular old date and turn it into something human-parseable
  def friendly_date(datetime)
    date = datetime.to_date
    
    # THE PAST
    if datetime < Time.now 
      # today: 2 hours ago
      if date == Date.today
        time_ago_in_words(datetime) + "ago"
      # yesterday: yesterday
      elsif date == Date.yesterday
        "yesterday"
      # any other time in the past: 5 days ago
      elsif date < Date.yesterday
        distance_of_time_in_words(date, Date.today) + " ago"
      end

    
    # FUTURE
    elsif datetime > Time.now 
      # today: in two hours, or today at 5pm
      if datetime < Time.now.advance(:hours => 3)
        "in " + time_ago_in_words(datetime)
      elsif date == Date.today
        "today at " + short_time(datetime)
      # tomorrow: tomorrow at 5pm
      elsif date == Date.tomorrow
        "tomorrow at " + short_time(datetime)
      # this week: this Thursday at 5pm
      elsif date < Date.current.advance(days: 7)
        datetime.strftime("this %A at ") + short_time(datetime)    
      # next week: next Thursday, March 28th
      elsif date < Date.current.advance(days: 14)
        datetime.strftime("next %A, %B %d")
      end
    
    # default
    else
      datetime.strftime("%B %d")
    end
  
  end

  def short_time(time)
    if time.min == 0
      time.strftime("%l%P")
    else
      time.strftime("%l:%M %P")
    end
  end

end
