require 'spec_helper'

describe ApiKey do
  describe '.generate' do
    let(:api_key) { ApiKey.generate }
    it 'generates an API key' do
      expect(api_key.key).to_not be_nil
    end
  end
end
