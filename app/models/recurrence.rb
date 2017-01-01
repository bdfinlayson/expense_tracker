class Recurrence
  def initialize(model)
    @model = model
    @model_due_day = model.created_at.day
    @frequency = model.frequency
    @vendor_id = model.vendor_id
    @user = model.user
    @target = which_table
    @current_year = Time.now.year
    @current_month = Time.now.month
    @current_day = Time.now.day
    @days_in_month = Time.now.end_of_month.day
  end

  def compute
    log_item if item_not_yet_logged?
  end

  private

  def which_table
    if @model.class == RecurringExpense
      { join_table: :pending_expenses, model: PendingExpense }
    else
      { join_table: :incomes, model: Income }
    end
  end

  def log_item
    attrs = get_model_attributes
    @model.send(@target[:join_table]).push @target[:model].create(attrs)
  end

  def item_not_yet_logged?
    case @frequency
    when 'biweekly'
      start_day = @model_due_day
      next_day = calculate_next_biweekly_day(start_day)
      if @current_day >= start_day && @current_day < next_day
        true if biweekly_item_due?(start_day) && query_for_biweekly_items(start_day).count == 0
      elsif @current_day >= next_day
        true if biweekly_item_due?(next_day) && query_for_biweekly_items(next_day).count == 1
      else
        false
      end
    when 'monthly'
      monthly_item_due?
    when 'annually'
      annual_item_due?
    else
      false
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

  def calculate_next_biweekly_day(start_day)
    next_day = start_day + 14
    if next_day > @days_in_month
      next_day - @days_in_month
    else
      next_day
    end
  end

  def monthly_item_due?
    query = @user.send(@target[:join_table]).unscoped.where(vendor_id: @vendor_id)
    logged_items = query.where('extract(month from created_at) = ?', @current_month)
    if logged_items.empty? && overdue?(@model_due_day)
      true
    else
      false
    end
  end

  def annual_item_due?
    query = @user.send(@target[:join_table])
      .unscoped.where(vendor_id: @vendor_id)
      .where('extract(year from created_at) = ?', @current_year)
      .where('extract(month from created_at) = ?', @model.created_at.month)
    if query.empty? && @current_month == @model.created_at.month
      true
    else
      false
    end
  end

  def overdue?(day)
    difference_in_days = day - @days_in_month
    if (day > @days_in_month) && (difference_in_days <= 3)
      true
    else
      @current_day >= day
    end
  end

  def get_model_attributes
    @model.attributes.except('frequency', 'created_at', 'updated_at', 'note', 'id', 'due_day')
  end
end
