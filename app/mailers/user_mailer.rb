class UserMailer < ApplicationMailer

  def order_approval
    @name = params[:name]
    @order = params[:order]
    mail(to: params[:to], subject: "新規発注の申し入れ") 
  end

  def status_1
    @name = params[:name]
    @order = params[:order]
    mail(to: params[:to], subject: "発注受け入れのお知らせ") 
  end

  def delivery
    @name = params[:name]
    @order = params[:order]
    @delivery = params[:delivery]
    mail(to: params[:to], subject: "発送のお知らせ") 
  end

  def status_3
    @name = params[:name]
    @order = params[:order]
    mail(to: params[:to], subject: "お得意先 受取連絡") 
  end

  def invoice_approval
    @name = params[:name]
    @order = params[:order]
    mail(to: params[:to], subject: "請求書承認申請") 
  end

  def send_invoice
    @name = params[:name]
    @order = params[:order]
    mail(to: params[:to], subject: "請求書送付のご連絡") 
  end

end
