class ExpenseApiController < ApplicationController

  #GET
  def get_all
    @expenses = @user.expenses
    render json: @expenses
  end

  #GET
  def get_expense
    begin
      @expense = @user.expenses.find(params[:id])
      render json: @expense
    rescue
      render json: {"Message": "Expense not found or not available"}
    end
  end

  #POST
  def new_expense
    amount = params[:amount]&.to_f
    begin
      @expense = Expense.create!(title: params[:title], amount: amount, date: params[:date], user_id: @user.id)
      render json: @expense
    rescue
      render json: {"Message": "Invalid expense data, cannot add expense"}, status: :bad_request
    end
  end

  #PUT
  def update_expense
    amount = params[:amount]&.to_f
    begin
      @expense = @user.expenses.find(params[:id])
      begin
        @expense.update!(title: params[:title], amount: amount, date: params[:date])
        render json: @expense
      rescue
        render json: {"Message": "Invalid expense data, cannot update expense"}, status: :bad_request
      end
    rescue
      render json: {"Message": "Expense not found or not available"}
    end
  end

  #DELETE
  def delete_expense
    begin
      @expense = @user.expenses.find(params[:id])
      @expense.destroy
      render json: {message: "Expense #{@expense.title} deleted"}
    rescue
      render json: {"Message": "Expense not found or not available"}
    end
  end

  private

  def expense_params
    params.require(:expense).permit(:title, :amount, :date, :user_id)
  end

end