class TransactionsController < ApplicationController
  before_action :set_budget
  before_action :set_transaction, only: %i[ edit update destroy ]

  # GET /transactions/new
  def new
    @transaction = @budget.transactions.new
  end

  # GET /transactions/1/edit
  def edit
  end

  # POST /transactions or /transactions.json
  def create
    @transaction = @budget.transactions.new(transaction_params)

    respond_to do |format|
      if @transaction.save
        format.html { redirect_to @transaction.budget, notice: "Transaction was successfully created." }
        format.json { render :show, status: :created, location: @transaction }
      else
        # format.html { render :new, status: :unprocessable_content }
        format.html { redirect_to @budget, alert: @transaction.errors.full_messages }
        format.json { render json: @transaction.errors, status: :unprocessable_content }
      end
    end
  end

  # PATCH/PUT /transactions/1 or /transactions/1.json
  def update
    respond_to do |format|
      if @transaction.update(transaction_params)
        format.html { redirect_to @transaction.budget, notice: "Transaction was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @transaction }
      else
        format.html { redirect_to @budget, alert: @transaction.errors.full_messages }
        format.json { render json: @transaction.errors, status: :unprocessable_content }
      end
    end
  end

  # DELETE /transactions/1 or /transactions/1.json
  def destroy
    @transaction.destroy!

    respond_to do |format|
      format.html { redirect_to @budget, notice: "Transaction was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private
    def set_budget
      @budget = Budget.find(params.expect(:budget_id))
    rescue ActiveRecord::RecordNotFound
      redirect_to budgets_url
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_transaction
      @transaction = @budget.transactions.find(params.expect(:id))
    rescue ActiveRecord::RecordNotFound
      redirect_to @budget
    end

    # Only allow a list of trusted parameters through.
    def transaction_params
      params.expect(transaction: [ :name, :amount, :due_date, :transaction_type, :recurring ])
    end
end
