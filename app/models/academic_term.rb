class AcademicTerm
  def initialize(term=nil)
    if term.nil?
      # make it the current term
      estimate_current_term
    else
      pattern = /^\s*([A-Za-z]{2,}(?:[-\/][Ss][uU][mM]{2}[eE][rR])?)\s*(\d{4})\s*$/
      # matches = term.match spring_summer_pattern
      matches = pattern.match term
      if matches.nil? || matches.length < 3
        #make it the current term
        estimate_current_term
      else
        @semester = match_semester(matches[1])
        # @semester = matches[1].upcase
        @year = matches[2].to_i
      end
    end
  end

  attr_reader :semester, :year

  def to_s
    "#{semester} #{year}"
  end

  private

  def estimate_current_term
    # get today's date
    today = Time.now
    # assign year as current year
    @year = today.year
    # estimate semester based on month and day
    @semester = case today.yday
                  when 0..120
                    'WI'
                  when 121..162
                    'SP'
                  when 163..204
                    'SU'
                  when 205..366
                    'FA'
                end
  end

  def match_semester(input)
    case input.upcase
      when "FA", "FALL"
        "FA"
      when "SP", "SPRING"
        "SP"
      when "SS", "SPRING-SUMMER", "SPRING/SUMMER"
        "SS"
      when "SU", "SUMMER"
        "SU"
      when "WI", "WINTER"
        "WI"
      else
        "ERR"
    end
  end
end