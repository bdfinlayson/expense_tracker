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

  def spent
    '$' + expense_category.summed_expenses.round(2).to_s
  end

  def percent_spent
    percentage_of(expense_category.summed_expenses, amount).to_s + '%'
  end

  def left
    '$' + (amount - expense_category.summed_expenses).round(2).to_s
  end

  def category_name
    case self.model_name.name
    when 'Expense', 'RecurringExpense', 'Budget'
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
