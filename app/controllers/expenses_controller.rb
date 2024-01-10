class ExpensesController < ApplicationController
  before_action :set_expense, only: %i[ show edit update destroy ]

  # GET /expenses or /expenses.json
  def index
    @data_keys = %w[January February March April May June]
    @data_values = [0, 10, 5, 2, 20, 30, 45]
    if params[:month]
      @expenses = Expense.where('extract(month from date) = ?', Date::MONTHNAMES.index(params[:month]))

      # Create a Date object for the first day of the specified month
      first_day_of_month = Date.new(Date.today.year, Date::MONTHNAMES.index(params[:month]), 1)

      # Calculate the last day of the specified month
      last_day_of_month = first_day_of_month.end_of_month

      # Generate an array of all days in the specified month using 'map'
      @days_in_month = (first_day_of_month..last_day_of_month).map(&:day).to_a
      @values_per_day = @days_in_month.map do |day|
        @expenses.where('extract(day from date) = ?', day).sum(:amount)
      end
    else
      @expenses = Expense.all
    end
    @months = Date.today.all_year.map { |date| date.strftime("%B") }.uniq
    @expenses_by_month = @expenses.order(date: :asc).group_by { |expense| expense.date.strftime("%Y-%m") }
    @monthly_sums = []

    @expenses_by_month.values.each do |month_expenses|
      # Calculate the sum of expenses for the current month
      total_amount = month_expenses.sum { |expense| expense.amount }

      # Create a hash with month and total_amount
      @monthly_sums << total_amount
    end

    @expenses_by_day = @expenses.order(date: :desc).group_by { |expense| expense.date.strftime("%A, %d %B") }
  end

  # GET /expenses/new
  def new
    @expense = Expense.new
  end

  # GET /expenses/1/edit
  def edit
  end

  # POST /expenses or /expenses.json
  def create
    @expense = Expense.new(expense_params)

    respond_to do |format|
      if @expense.save
        format.html { redirect_to expenses_url, notice: "Expense was successfully created." }
        format.json { render :show, status: :created, location: @expense }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @expense.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /expenses/1 or /expenses/1.json
  def update
    respond_to do |format|
      if @expense.update(expense_params)
        format.html { redirect_to expenses_url, notice: "Expense was successfully updated." }
        format.json { render :show, status: :ok, location: @expense }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @expense.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /expenses/1 or /expenses/1.json
  def destroy
    @expense.destroy

    respond_to do |format|
      format.html { redirect_to expenses_url, notice: "Expense was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_expense
    @expense = Expense.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def expense_params
    params.require(:expense).permit(:name, :date, :amount, :description, :category_id)
  end
end
