class WellSerializer < ActiveModel::Serializer
  attributes :latitude, :longitude, :suburb, :postcode, :country, :description
end
