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
    # How can I puts out these wells?
    # so all the let statements abouve, the things created in them are saved? How long for?
    # until it is run again?
    let(:api_key) { ApiKey.generate }
    let(:response) { post :create, well: {
      latitude: -33.835279, longitude: 151.203917, suburb: 'Waverton', postcode: '2060', country: 'Australia', description: 'Knock on door, and die'
    }, format: :json, api_key: api_key.key }
    let(:well) { Well.last }
    it 'creates a well' do
      expect(JSON.parse(response.body)['description']).to eq(well.description)
    end
  end

  describe 'sending a request to create a well without an API key' do
    let(:response) { post :create, well: {
      latitude: -33.835279, longitude: 151.203917, suburb: 'Waverton', postcode: '2060', country: 'Australia', description: 'Knock on door, and die'
    }, format: :json }
    it 'responds with a 401' do
      expect(response.code).to eq('401')
    end
  end
  
  describe 'creating a well with an image attached' do
    let(:api_key) { ApiKey.generate }
    let(:response) { post :create, well: {
      latitude: -33.835279, longitude: 151.203917, suburb: 'Waverton', postcode: '2060', country: 'Australia', description: 'Knock on door, and die', image: 'https://s3.amazonaws.com/well-test/croc.jpg'
    }, format: :json, api_key: api_key.key }
    let(:well) { Well.last }
    it 'creates a well' do
      expect(JSON.parse(response.body)['image']).to eq(well.image)
    end
  end
  
  describe 'retrieving the image for a well' do
    let!(:well_1) { Well.create(latitude: -33.835279, longitude: 151.203917, suburb: 'Waverton', postcode: '2060', country: 'Australia', description: 'Knock on door, and die', image: 'https://s3.amazonaws.com/well-test/croc.jpg') }
    let(:response) { post :create, well: {
      latitude: -33.835279, longitude: 151.203917, suburb: 'Waverton', postcode: '2060', country: 'Australia', description: 'Knock on door, and die'
    }, format: :json, api_key: api_key.key }
    let(:response) { get :show, id: well_1.id, format: :json }
    it 'returns an image file' do
      expect(JSON.parse(response.body)['image']).to eq(well_1.image)
    end
  end
end
