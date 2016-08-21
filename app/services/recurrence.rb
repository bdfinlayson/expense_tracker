class Recurrence
  def initialize(model)
    @model = model
    @model_due_day = model.created_at.day
    @frequency = model.frequency
    @vendor_id = model.vendor_id
    @user = model.user
    @target = which_table
    @current_month = Time.now.month
    @current_day = Time.now.day
    @days_in_month = Time.now.end_of_month.day
  end

  def compute
    log_recurrence if event_not_yet_logged?
  end

  private

  def which_table
    if @model.class == RecurringExpense
      { join_table: :expenses, model: Expense }
    else
      { join_table: :incomes, model: Income }
    end
  end

  def log_recurrence
    attrs = get_model_attributes
    @model.send(@target[:join_table]).push @target[:model].create(attrs)
  end

  def event_not_yet_logged?
    case @frequency
    when 'monthly'
      monthly_item_due?
    else
      false
    end
  end

  def monthly_item_due?
    query = @user.send(@target[:join_table]).where(vendor_id: @vendor_id)
    logged_items = query.where('extract(month from created_at) = ?', @current_month)
    if logged_items.empty? && overdue?
      true
    else
      false
    end
  end

  def overdue?
    difference_in_days = @model_due_day - @days_in_month
    if (@model_due_day > @days_in_month) && (difference_in_days <= 3)
      true
    else
      @model_due_day <= @current_day
    end
  end

  def get_model_attributes
    if overdue?
      @model.attributes.except('frequency', 'updated_at', 'note', 'id')
    else
      @model.attributes.except('frequency', 'created_at', 'updated_at', 'note', 'id')
    end
  end
end
