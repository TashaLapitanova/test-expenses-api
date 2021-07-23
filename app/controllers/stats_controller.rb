class StatsController < ApplicationController

  # total amount - controller method

  #GET
  def get_total_balance
    all_user_incomes = @user.incomes.total_amount
    all_user_expenses = @user.expenses.total_amount
    render json: {"Total user balance": all_user_incomes - all_user_expenses}
  end

  #GET
  def get_balance_within_period
    if params[:start_date] && params[:end_date]
      begin
        start_date = Date.parse(params[:start_date])
        end_date = Date.parse(params[:end_date])
        incomes_within_period = @user.incomes.within_period(start_date, end_date)
        expenses_within_period = @user.expenses.within_period(start_date, end_date)
        balance_within_period = incomes_within_period.total_amount - expenses_within_period.total_amount

        render json: {"User incomes within requested period": incomes_within_period,
                      "User expenses within requested period": expenses_within_period,
                      "User balance within requested period": balance_within_period}
      rescue => e
        render json: {"Message": e}, status: :bad_request
      end
    else
      render json: {"Message": "Please provide start and end date of the period"}, status: :bad_request
    end
  end

  #GET
  def get_users_with_stats_within_period
    if params[:start_date] && params[:end_date]
      begin
        start_date = Date.parse(params[:start_date])
        end_date = Date.parse(params[:end_date])
        period = start_date..end_date

        users = User.select(:username, :id).distinct
                    .joins(:expenses, :incomes)
                    .includes(:expenses, :incomes)
                    .where(expenses: {date: period}, incomes: {date: period})
        render :json => users.to_json(:include => [{ expenses: {} }, {incomes: {}}])
      rescue => e
        render json: {"Message": e}, status: :bad_request
      end
    else
      render json: {"Message": "Please provide start and end date of the period"}, status: :bad_request
    end
  end
  #
  #GET
  # def get_users_with_stats_within_period
  #   if params[:start_date] && params[:end_date]
  #     begin
  #       start_date = Date.parse(params[:start_date])
  #       end_date = Date.parse(params[:end_date])
  #
  #       expenses = Expense.within_period(start_date, end_date)
  #       incomes = Income.within_period(start_date, end_date)
  #       user_ids = expenses.map{|exp| exp.user_id}.push(incomes.map{|inc| inc.user_id}).flatten.uniq
  #       users = User.where(id: user_ids)
  #
  #       response = Array.new
  #       users.each do |user|
  #         response.push({
  #                         username: user.username,
  #                         id: user.id,
  #                         expenses: expenses.select{|exp| exp.user_id == user.id},
  #                         incomes: incomes.select{|inc| inc.user_id == user.id}
  #                       })
  #       end
  #       render json: response
  #     rescue => e
  #       render json: {"Message": e}, status: :bad_request
  #     end
  #   else
  #     render json: {"Message": "Please provide start and end date of the period"}, status: :bad_request
  #   end
  # end

end
