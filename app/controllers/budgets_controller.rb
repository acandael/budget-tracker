class BudgetsController < ApplicationController
  before_action :set_budget, only: %i[ show edit update destroy ]

  # GET /budgets or /budgets.json
  def index
    @new_budget = Budget.new
    @budgets = Current.user.budgets.all
  end

  # GET /budgets/1 or /budgets/1.json
  def show
  end

  # GET /budgets/new
  def new
    @budgets = Current.user.budgets.new
  end

  # GET /budgets/1/edit
  def edit
  end

  # POST /budgets or /budgets.json
  def create
    @budget = Current.user.budgets.new(budget_params)

    respond_to do |format|
      if @budget.save
        format.html { redirect_to @budget, notice: "Budget was successfully created." }
        format.json { render :show, status: :created, location: @budget }
      else
        format.html { render :new, status: :unprocessable_content }
        format.json { render json: @budget.errors, status: :unprocessable_content }
      end
    end
  end

  # PATCH/PUT /budgets/1 or /budgets/1.json
  def update
    respond_to do |format|
      if @budget.update(budget_params)
        format.html { redirect_to @budget, notice: "Budget was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @budget }
      else
        format.html { render :edit, status: :unprocessable_content }
        format.json { render json: @budget.errors, status: :unprocessable_content }
      end
    end
  end

  # DELETE /budgets/1 or /budgets/1.json
  def destroy
    @budget.destroy!

    respond_to do |format|
      format.html { redirect_to budgets_path, notice: "Budget was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_budget
      @budget = Current.user.budgets.find(params.expect(:id))
    rescue ActiveRecord::RecordNotFound
      redirect_to budgets_url
    end

    # Only allow a list of trusted parameters through.
    def budget_params
      params.expect(budget: [ :month ])
    end
end
