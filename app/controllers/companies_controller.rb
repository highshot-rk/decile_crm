class CompaniesController < ApplicationController
  before_action :set_company, only: %i[edit update destroy]

  def index
    @companies = Company.order(:name).page(params[:page]).per(10)
  end

  def new
    @company = Company.new

    render :edit
  end

  def create
    @company = Company.new(company_params)
    if @company.save
      redirect_to companies_path(page: params[:page]), notice: 'Company added successfully.'
    else
      flash[:alert] = @company.errors.full_messages.join("\n")
      render :edit, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @company.update(company_params)
      redirect_to companies_path(page: params[:page]), notice: 'Company updated successfully.'
    else
      flash[:alert] = @company.errors.full_messages.join("\n")
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @company.destroy
    redirect_to companies_path(page: params[:page]), notice: 'Company deleted successfully.'
  end

  private

  def set_company
    @company = Company.find(params[:id])
  end

  def company_params
    params.require(:company).permit(:name)
  end
end
