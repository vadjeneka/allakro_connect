require 'rails_helper'

RSpec.describe "Products", type: :request do
  describe "GET /index" do
    pending "add some examples (or delete) #{__FILE__}"
  end
    it "returns http success" do
      get "/products/index"
      expect(response).to have_http_status(:success)
    end
  end

end
