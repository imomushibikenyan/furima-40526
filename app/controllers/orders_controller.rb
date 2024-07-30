class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_item, only: [:new, :create]

  def new
    @order_form = OrderForm.new(item_id: @item.id, user_id: current_user.id)
  end
  

  def create
    @order_form = OrderForm.new(order_form_params)

    if @order_form.save
      redirect_to root_path, notice: '購入が完了しました'
    else
      render :new
    end
  end

  private

  def set_item
    @item = Item.find(params[:item_id])
  end

  def order_form_params
    params.require(:order_form).permit(
      :item_id, :user_id,
      :postal_code, :recipient_phone, :region_id, :city, :street_address, :building_name
    )
  end
end
