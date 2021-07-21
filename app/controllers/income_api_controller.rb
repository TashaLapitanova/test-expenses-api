class IncomeApiController < ApplicationController
  before_action :authorized

  #GET
  def get_all
    @incomes = Income.where(user_id: @user.id.to_i)
    render json: @incomes
  end

  #GET
  def get_income
    @income = Income.find(params[:id])
    if @income.user_id === @user.id
      render json: @income
    else
      render nothing: true, status: :unauthorized
    end
  end

  #POST
  def new_income
    amount = params[:amount]&.to_f
    @income = Income.create!(title: params[:title], amount: amount, date: params[:date], user_id: @user.id)
    if @income.save
      render json: @income
    else
      render nothing: true, status: :bad_request
    end
  end

  #PUT
  def update_income
    amount = params[:amount]&.to_f
    @income = Income.find(params[:id])
    if @income.user_id === @user.id
      if @income.update!(title: params[:title], amount: amount, date: params[:date])
        render json: @income
      else
        render nothing: true, status: :bad_request
      end
    else
      render nothing: true, status: :unauthorized
    end
  end

  #DELETE
  def delete_income
    @income = Income.find(params[:id])
    if @income.user_id === @user.id
      @income.destroy
      render json: {message: "Income deleted"}
    else
      render nothing: true, status: :unauthorized
    end
  end

  private

  def income_params
    params.require(:income).permit(:title, :amount, :date, :user_id)
  end

end
