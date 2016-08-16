class Calculator
  def self.percentage_change(original_amount, new_amount)
    return 100 if original_amount == 0
    diff = new_amount - original_amount
    (diff / original_amount).floor
  end

  def self.percentage_of(part, whole)
    return 0 if whole.zero?
    (part / whole * 100).floor
  end
end
