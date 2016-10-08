class BudgetDecorator < Draper::Decorator
  delegate_all

  def spent
    '$' + object
    .expense_category
    .expenses
    .where('extract(month from created_at) = ?', context[:month] )
    .pluck(:amount)
    .sum
    .round(2)
    .to_s
  end

  def percent_spent
    percentage_of(
      object
      .expense_category
      .expenses
      .where('extract(month from created_at) = ?', context[:month] )
      .pluck(:amount)
      .sum, amount).to_s + '%'
  end

  def left
    '$' + (amount - object
                      .expense_category
                      .expenses
                      .where('extract(month from created_at) = ?', context[:month] )
                      .pluck(:amount)
                      .sum)
                      .round(2)
                      .to_s
  end

end
