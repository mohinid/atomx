# spec/requests/transactions_spec.rb
require 'rails_helper'

RSpec.describe "Transactions", type: :request do
  describe "GET /transactions.json" do
    before do
      create(:transaction, type: "credit", status: "pending", created_at: 2.days.ago)
      create(:transaction, type: "debit", status: "completed", created_at: 1.day.ago)
    end

    it "returns all transactions" do
      get "/transactions.json"
      expect(response).to have_http_status(:success)
      expect(JSON.parse(response.body)["transactions"].size).to eq(2)
    end

    it "filters by type" do
      get "/transactions.json", params: { type: "credit" }
      json = JSON.parse(response.body)
      expect(json["transactions"].all? { |t| t["type"] == "credit" }).to be true
    end

    it "filters by status" do
      get "/transactions.json", params: { status: "pending" }
      json = JSON.parse(response.body)
      expect(json["transactions"].all? { |t| t["status"] == "pending" }).to be true
    end

    it "filters by date_from and date_to" do
      from = 3.days.ago.to_date.to_s
      to = 1.day.ago.to_date.to_s
      get "/transactions.json", params: { date_from: from, date_to: to }
      json = JSON.parse(response.body)
      expect(json["transactions"].size).to eq(2)
    end
  end

  describe "GET /transactions/report.xlsx" do
    before do
      create(:transaction, type: "credit", status: "pending", created_at: 2.days.ago)
      create(:transaction, type: "debit", status: "completed", created_at: 1.day.ago)
    end

    it "returns a report in xlsx format" do
      get "/transactions/report.xlsx"
      expect(response).to have_http_status(:success)
      expect(response.header["Content-Type"]).to include("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet")
    end

    it "filters report by type and status" do
      get "/transactions/report.xlsx", params: { type: "credit", status: "pending" }
      expect(response).to have_http_status(:success)
    end
  end
end
