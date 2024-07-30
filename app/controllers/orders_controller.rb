class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_item, only: [:index, :create]

  def index
    @order_form = OrderForm.new(item_id: @item.id, user_id: current_user.id)
  end
  
  def create
    @order_form = OrderForm.new(order_form_params)
    if @order_form.valid?
      @order_form.save
      redirect_to root_path
    else
      render 'index', status: :unprocessable_entity
    end
  end

  private

  def set_item
    @item = Item.find(params[:item_id])
  end

  def order_form_params
    params.require(:order_form).permit(
      :item_id, :user_id,
      :postal_code, :recipient_phone, :region_id, :city, :street_address, :building_name, :token
    ).merge(user_id: current_user.id, item_id: params[:item_id])
  end
end
