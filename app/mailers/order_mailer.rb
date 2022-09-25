class OrderMailer < ApplicationMailer
  def new_order_email
    @order = params[:order]
    @order_details = params[:order_details]
    @user = @order.user

    mail(to: ENV['ADMIN_MAIL'], subject: 'You got a new order!')
  end
end
