require 'rails_helper'

RSpec.describe "CompanyGroups", type: :request do
  describe "GET /company_groups" do
    it "works! (now write some real specs)" do
      get company_groups_path
      expect(response).to have_http_status(200)
    end
  end
end
