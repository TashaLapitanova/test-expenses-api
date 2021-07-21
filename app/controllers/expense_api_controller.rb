class ExpenseApiController < ApplicationController

  #GET
  def get_all
    @expenses = Expense.where(user_id: @user.id.to_i)
    render json: @expenses
  end

  #GET
  def get_expense
    @expense = Expense.find(params[:id])
    if @expense.user_id === @user.id
      render json: @expense
    else
      render nothing: true, status: :unauthorized
    end
  end

  #POST
  def new_expense
    amount = params[:amount]&.to_f
    @expense = Expense.create!(title: params[:title], amount: amount, date: params[:date], user_id: @user.id)
    if @expense.save
      render json: @expense
    else
      render nothing: true, status: :bad_request
    end
  end

  #PUT
  def update_expense
    amount = params[:amount]&.to_f
    @expense = Expense.find(params[:id])
    if @expense.user_id === @user.id
      if @expense.update!(title: params[:title], amount: amount, date: params[:date])
        render json: @expense
      else
        render nothing: true, status: :bad_request
      end
    else
      render nothing: true, status: :unauthorized
    end
  end

  #DELETE
  def delete_expense
    @expense = Expense.find(params[:id])
    if @expense.user_id === @user.id
      @expense.destroy
      render json: {message: "Expense deleted"}
    else
      render nothing: true, status: :unauthorized
    end
  end

  private

  def expense_params
    params.require(:expense).permit(:title, :amount, :date, :user_id)
  end

end