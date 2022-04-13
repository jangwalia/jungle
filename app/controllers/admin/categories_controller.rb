class Admin::CategoriesController < ApplicationController
  http_basic_authenticate_with name: ENV["USERNAME"], password: ENV["PASSWORD"]
  
  def index
    @Category = Category.order(id: :desc).all
  end

  def new
    @Category = Category.new
  end

  def create
    @Category = Category.new(Category_params)

    if @Category.save
      redirect_to [:admin, :Category], notice: 'Category created!'
    else
      render :new
    end
  end

  

  private

  def Category_params
    params.require(:Category).permit(
      :name,
      :description,
      :category_id,
      :quantity,
      :image,
      :price
    )
  end
end
