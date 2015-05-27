require 'spec_helper'

describe WellsController do
  describe '#index' do
    let!(:well_1) { Well.create(latitude: -33.835279, longitude: 151.203917, suburb: 'Waverton', postcode: '2060', country: 'Australia', description: 'Knock on door, and die') }
    let!(:well_2) { Well.create(latitude: -33.883496, longitude: 151.231271, suburb: 'Darlinghurst', postcode: '2000', country: 'Australia', description: 'Walk up to level 2') }
    let(:response) { get :index, format: :json }
    it 'provides a list of wells' do
      expect(JSON.parse(response.body).size).to eq(2)
    end
  end

  describe '#show' do
    let!(:well_1) { Well.create(latitude: -33.835279, longitude: 151.203917, suburb: 'Waverton', postcode: '2060', country: 'Australia', description: 'Knock on door, and die') }
    let(:response) { get :show, id: well_1.id, format: :json }
    it 'provides information on a well' do
      expect(JSON.parse(response.body)['description']).to eq(well_1.description)
    end
  end

  describe '#create' do
    let(:response) { post :create, well: {
      latitude: -33.835279, longitude: 151.203917, suburb: 'Waverton', postcode: '2060', country: 'Australia', description: 'Knock on door, and die'
    }, format: :json }
    let(:well) { Well.last }
    it 'creates a well' do
      expect(JSON.parse(response.body)['description']).to eq(well.description)
    end
  end
end
