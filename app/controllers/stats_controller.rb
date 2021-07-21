class StatsController < ApplicationController

  #GET
  def get_total
    all_user_incomes = Income.where(user_id: @user.id.to_i).pluck(:amount).sum.to_f
    all_user_expenses = Expense.where(user_id: @user.id.to_i).pluck(:amount).sum.to_f
    render json: {"total user balance": all_user_incomes - all_user_expenses}
  end

  #GET
  def get_stats_within_period
    income_within_period = Income.where(user_id: @user.id.to_i)
                                 .where("date >= ?", params[:start_date])
                                 .where("date <= ?", params[:end_date])
                                 .pluck(:amount).sum.to_f
    expenses_within_period = Expense.where(user_id: @user.id.to_i)
                                   .where("date >= ?", params[:start_date])
                                   .where("date <= ?", params[:end_date])
                                   .pluck(:amount).sum.to_f
    render json: {"total income within requested period": income_within_period,
                  "total expenses within requested period": expenses_within_period}
  end

end
