module BaseModel
  include Calculator

  def date
    created_at.strftime('%m-%d-%y')
  end

  def item_amount
    '$' + amount.to_s
  end

  def budgeted_amount
    item_amount
  end

  def category_name
    case self.model_name.name
    when 'Expense', 'RecurringExpense', 'Budget', 'PendingExpense'
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

  def account_payable_name
    account_payable.name
  end

  def recurring?
    case self.model_name.name
    when 'Expense'
      recurring_expense_id.present?
    when 'Income'
      recurring_income_id.present?
    else
      'N/A'
    end
  end
end
