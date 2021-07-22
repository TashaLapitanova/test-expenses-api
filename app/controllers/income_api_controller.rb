class IncomeApiController < ApplicationController

  #GET
  def get_all
    @incomes = @user.incomes
    render json: @incomes
  end

  #GET
  def get_income
    begin
      @income = @user.incomes.find(params[:id])
      render json: @income
    rescue
      render json: {"Message": "Income not found or not available"}, status: :not_found
    end
  end

  #POST
  def new_income
    amount = params[:amount]&.to_f
    begin
      @income = Income.create!(title: params[:title], amount: amount, date: params[:date], user_id: @user.id)
      render json: @income
    rescue
      render json: {"Message": "Invalid income data, cannot add income"}, status: :bad_request
    end
  end

  #PUT
  def update_income
    amount = params[:amount]&.to_f
    begin
      @income = @user.incomes.find(params[:id])
      begin
        @income.update!(title: params[:title], amount: amount, date: params[:date])
        render json: @income
      rescue
        render json: {"Message": "Invalid income data, cannot update income"}, status: :bad_request
      end
    rescue
      render json: {"Message": "Income not found or not available"}, status: :not_found
    end
  end

  #DELETE
  def delete_income
    begin
      @income = @user.incomes.find(params[:id])
      @income.destroy
      render json: {message: "Income #{@income.title} deleted"}
    rescue
      render json: {"Message": "Income not found or not available"}, status: :not_found
    end
  end

  private

  def income_params
    params.require(:income).permit(:title, :amount, :date, :user_id)
  end

end
