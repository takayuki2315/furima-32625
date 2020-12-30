class ItemsController < ApplicationController
  before_action :set_action, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]
  before_action :move_to_index, only: [:edit, :update, :destroy]

  def index
    @items = Item.includes(:user).order("created_at DESC")
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @item.update(item_params)
      redirect_to item_path
    else
      render :edit
    end
  end

  def destroy
    if @item.destroy
    redirect_to root_path
    else
      render :show
    end
  end



  private

  def set_action
    @item = Item.find(params[:id])
  end

  def item_params
    params.require(:item).permit(:name, :text, :category_id, :condition_id, :delivery_fee_id, :prefecture_id, :days_to_delivery_id, :price, :image).merge(user_id: current_user.id)
    
  end

  def move_to_index
    if (current_user != @item.user) || @item.order.present?
      redirect_to root_path 
    end
  end

end
