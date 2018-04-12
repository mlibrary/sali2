class TimeRange
  def initialize(date, start_time, end_time)
    @date = Date.parse(date)
    (start_hours, start_minutes) = extract_time_from_string start_time
    (end_hours, end_minutes) = extract_time_from_string end_time
    @start_time = Time.new(@date.year, @date.month, @date.day, start_hours, start_minutes)
    @end_time = Time.new(@date.year, @date.month, @date.day, end_hours, end_minutes)
    # TODO: Verify that start_time precedes end_time
  end

  attr_reader :date, :start_time, :end_time

  def duration
    (@end_time.tv_sec - @start_time.tv_sec) / 60
  end

  private

  def extract_time_from_string(str)
    pattern = /^\s*(\d{1,2}):(\d{2})\s?(AM|PM)?\s*$/
    matches = pattern.match str.upcase
    if matches.nil?
      [0,0]
    else
      hours = matches[1].to_i
      minutes = matches[2].to_i
      am_or_pm = matches[3]
      if am_or_pm.nil?
        # do nothing
      elsif am_or_pm == 'PM' && hours < 12
        hours += 12
      elsif am_or_pm == 'AM' && hours == 12
        hours = 0
      end
      [hours, minutes]
    end
  end
end