class ApiKey < ActiveRecord::Base
  def self.generate
    create(key: SecureRandom.hex)
  end
end
