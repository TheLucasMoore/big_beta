require 'rails_helper'
require 'mountain_project_import'

RSpec.describe MountainProjectImport, type: 'request' do

  let(:user) { create(:user) }

  let(:service) { MountainProjectImport.new(user.id, user.email, "TOTALLY-REAL-KEY") }
  let(:ticks_resp) { File.read('spec/fixtures/mountain_project_ticks_resp.json') }
  let(:ticks_json) { JSON.parse(ticks_resp).to_json }
  let(:routes_resp) { File.read('spec/fixtures/mountain_project_routes_resp.json') }
  let(:routes_json) { JSON.parse(routes_resp).to_json }

  before :each do
    stub_request(:get, /mountainproject\.com\/data\/get-ticks/).to_return(body: ticks_json)
    stub_request(:get, /mountainproject\.com\/data\/get-routes/).to_return(body: routes_json)
  end

  context 'requesting initial climb history' do
    it 'pulls ticks' do
      resp = service.query_for_ticks
      expect(resp['hardest']).to eq "5.12a"
      expect(resp['average']).to eq "5.10a"
      expect(resp['ticks'].count).to eq 42
    end
  end

  context 'second query for route grades' do
    it 'puts all route ids into routes url' do
      resp = service.query_for_ticks
      json = service.extract_data_from_ticks(resp)
    end
  end
  context 'one method to scrape data'
end
