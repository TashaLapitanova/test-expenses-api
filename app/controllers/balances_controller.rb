class BalancesController < ApplicationController

  #GET
  def get_total
    all_user_incomes = Income.where(user_id: @user.id.to_i).pluck(:amount).sum.to_f
    all_user_expenses = Expense.where(user_id: @user.id.to_i).pluck(:amount).sum.to_f
    render json: {"total user balance": all_user_incomes - all_user_expenses}
  end

end
