class Recurring
  attr_reader :resource

  def initialize(resource)
    @resource = resource
  end

  def compute
    case resource.frequency
    when 'weekly'
    when 'biweekly'
      Recurrence.new(resource).extend(BiweeklyRecurrence).compute
    when 'monthly'
      Recurrence.new(@resource).extend(MonthlyRecurrence).compute
      # Recurrence.new(@resource).compute
    when 'annually'
      # Recurrence.new(resource).extend(YearlyRecurrence).compute
      Recurrence.new(@resource).compute
    end
  end
end
