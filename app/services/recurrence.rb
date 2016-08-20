class Recurrence
  def initialize(model)
    @model = model
    @frequency = model.frequency
    @vendor_id = model.vendor_id
    @user = model.user
    @target = which_table
    @current_month = Time.now.month
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
    attrs = @model.attributes.except('frequency', 'created_at', 'updated_at', 'note', 'id')
    @model.send(@target[:join_table]).push @target[:model].create(attrs)
  end

  def event_not_yet_logged?
    if @frequency == 'monthly'
      query = @user.send(@target[:join_table]).where(vendor_id: @vendor_id)
      query.where('extract(month from created_at) = ?', @current_month).empty?
    else
      false
    end
  end
end
