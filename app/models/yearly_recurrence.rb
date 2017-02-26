module YearlyRecurrence

  def item_not_yet_logged?
    annual_item_due?
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
end
