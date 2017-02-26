module BiweeklyRecurrence

  def item_not_yet_logged?
    start_day = @model_due_day
    next_day = calculate_next_biweekly_day(start_day)
    if @current_day >= start_day && @current_day < next_day
      true if biweekly_item_due?(start_day) && query_for_biweekly_items(start_day).count == 0
    elsif @current_day >= next_day
      true if biweekly_item_due?(next_day) && query_for_biweekly_items(next_day).count == 1
    else
      false
    end
  end

  def calculate_next_biweekly_day(start_day)
    next_day = start_day + 14
    if next_day > @days_in_month
      next_day - @days_in_month
    else
      next_day
    end
  end

  def biweekly_item_due?(day)
    if overdue?(day)
      true
    else
      false
    end
  end

  def query_for_biweekly_items(day)
    query = @user.send(@target[:join_table]).unscoped.where(vendor_id: @vendor_id)
    query
      .where('extract(year from created_at) = ?', @current_year)
      .where('extract(month from created_at) = ?', @current_month)
  end
end
