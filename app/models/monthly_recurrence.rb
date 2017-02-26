module MonthlyRecurrence

  def item_not_yet_logged?
    monthly_item_due?
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
end
