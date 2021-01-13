class OrdersController < ApplicationController
  before_action :set_action, only: [:create, :index]
  before_action :authenticate_user!, only: [:index]
  before_action :move_to_index, only: [:index]

  def index
    @user_order = UserOrder.new
    
  end

  def create
    @user_order = UserOrder.new(order_params)
    if @user_order.valid?
      pay_item
      @user_order.save
      redirect_to root_path
    else
      render :index
    end
  end

  private

  def set_action
    @item = Item.find(params[:item_id])
  end

  def move_to_index
    if (current_user.id == @item.user_id) || @item.order.present?
      redirect_to root_path
    end  
  end

  def order_params
    params.require(:user_order).permit(:postal_code, :prefecture_id, :city, :address, :apartment, :phone_number).merge(user_id: current_user.id, item_id: params[:item_id], token: params[:token])
  end

  def pay_item
    Payjp.api_key = Payjp.api_key = Rails.application.credentials.PAYJP[:PAYJP_SECRET_KEY]
      Payjp::Charge.create(
        amount: Item.find(params[:item_id]).price,
        card: order_params[:token],
        currency: 'jpy'
      )
  end

end
