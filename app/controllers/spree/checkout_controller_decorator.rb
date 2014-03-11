module Spree
  CheckoutController.class_eval do
    before_filter :redirect_to_paypal_express_form_if_needed, :only => [:update]

    private
    def redirect_to_paypal_express_form_if_needed
      return unless (params[:state] == "payment") && params[:order][:payments_attributes]

      payment_method = PaymentMethod.find(params[:order][:payments_attributes].first[:payment_method_id])
      if payment_method.kind_of?(Spree::Gateway::PayPalExpress)
        redirect_to paypal_express_url(:payment_method_id => payment_method.id)
      end
    end
  end
end
