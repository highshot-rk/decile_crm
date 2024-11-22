class PeopleController < ApplicationController
  before_action :set_person, only: %i[edit update destroy move_stage]

  def index
    @people_by_stage = Person.all.group_by(&:stage)
  end

  def new
    @person = Person.new
    @companies = Company.all
  end

  def create
    @person = Person.new(person_params)
    if @person.save
      redirect_to people_path, notice: 'Person added successfully.'
    else
      @companies = Company.all
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @companies = Company.all
  end

  def update
    if @person.update(person_params)
      redirect_to people_path, notice: 'Person updated successfully.'
    else
      @companies = Company.all
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @person.destroy
    redirect_to people_path, notice: 'Person deleted successfully.'
  end

  def move_stage
    @person.update(stage: params[:stage])
    redirect_to people_path, notice: "#{@person.full_name} moved to #{params[:stage]}."
  end

  private

  def set_person
    @person = Person.find(params[:id])
  end

  def person_params
    params.require(:person).permit(:first_name, :last_name, :email, :phone, :stage, :probability, :company_id)
  end
end
