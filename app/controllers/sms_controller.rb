class SmsController < ApplicationController
    
    skip_before_action :verify_authenticity_token
    before_action :authenticate_caller


    def inbound
        to, from, text = sms_params[:to], sms_params[:from], sms_params[:text]
        phone_number = PhoneNumber.where(number: to, account_id: @current_account.id).last
        if phone_number.present?
            render json: { message: "", error: "to parameter not found"} 
            return
        end
        if  text.downcase.include?("stop")
            $redis.set("calls:#{to.to_s}_#{from.to_s}", 14400)
        end
        render json: { message: "inbound sms ok" }, status: 200
    end


    def outbound
        to, from, text = sms_params[:to], sms_params[:from], sms_params[:text]

        key = "calls:#{from.to_s}_#{to.to_s}"
        data = $redis.get(key)

        if data
            
        render json: { message: 'Form submitted successfully' }
    end


    private

    def sms_params
        params.permit(:from, :to, :text)
    end
end
