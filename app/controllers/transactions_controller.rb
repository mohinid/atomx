# app/controllers/transactions_controller.rb
class TransactionsController < ApplicationController
  # GET /transactions
  def index
    transactions = Transaction.all
    transactions = transactions.where(type: params[:type]) if params[:type].present?
    transactions = transactions.where(status: params[:status]) if params[:status].present?
    
    if params[:date_from].present? && params[:date_to].present?
      from = Date.parse(params[:date_from]).beginning_of_day
      to = Date.parse(params[:date_to]).end_of_day
      transactions = transactions.where(created_at: from..to)
    elsif params[:date_from].present?
      from = Date.parse(params[:date_from]).beginning_of_day
      transactions = transactions.where('created_at >= ?', from)
    elsif params[:date_to].present?
      to = Date.parse(params[:date_to]).end_of_day
      transactions = transactions.where('created_at <= ?', to)
    end
  
    @transactions = transactions.page(params[:page]).per(params[:per_page] || 10)
  
    respond_to do |format|
      format.html # renders index.html.erb
      format.json do
        render json: {
          transactions: @transactions.as_json,
          current_page: @transactions.current_page,
          total_pages: @transactions.total_pages,
          total_count: @transactions.total_count
        }
      end
    end
  end  

  # GET /transactions/report
  def report
    transactions = Transaction.all
    transactions = transactions.where(type: params[:type]) if params[:type].present?
    transactions = transactions.where(status: params[:status]) if params[:status].present?
    if params[:date_from].present? && params[:date_to].present?
      from = Date.parse(params[:date_from]).beginning_of_day
      to = Date.parse(params[:date_to]).end_of_day
      transactions = transactions.where(created_at: from..to)
    end
  
    summary = {
      total_count: transactions.count,
      total_credit: transactions.where(type: 'credit').count,
      total_debit: transactions.where(type: 'debit').count
    }
  
    respond_to do |format|
      format.xlsx { render xlsx: 'report', locals: { transactions: transactions, summary: summary } }
    end
  end  
end
