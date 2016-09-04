module Querier
  include Devise::Controllers::Helpers

  def all_records_for(table, year, month)
    current_user.send(table)
      .where('extract(year from created_at) = ?', year)
      .where('extract(month from created_at) = ?', month)
      .order(created_at: :desc)
  end
end
