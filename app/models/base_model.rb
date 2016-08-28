module BaseModel
  def date
    created_at.strftime('%m-%d-%y')
  end

  def item_amount
    '$' + amount.to_s
  end

  def category_name
    case self.model_name.to_s
    when 'Expense', 'RecurringExpense'
      expense_category.name
    when 'Income', 'RecurringIncome'
      income_category.name
    else
      'N/A'
    end
  end

  def vendor_name
    vendor.name
  end

  def recurring?
    case self.model_name.to_s
    when 'Expense'
      recurring_expense_id.present?
    when 'Income'
      recurring_income_id.present?
    else
      'N/A'
    end
  end
end
