class Address < ApplicationRecord
  STREET_SYNONYMS = [
    ['street','st'],
    ['terrace','tce'],
    ['road','rd'],
    ['boulevard','bvd'],
    ['close','cl'],
    ['crest','crst'],
    ['drive','dr'],
    ['avenue',' av']
  ]

  connects_to database: {reading: :gnaf, writing: :gnaf}

  self.primary_key = "gid"
  self.table_name = "gnaf_202005.addresses"

  searchkick default_fields: [:full_address],
      word_start: [:full_address],
      synonyms: STREET_SYNONYMS,
      locations: [:location]

  def full_address
    [address.titlecase, locality_name.titlecase, state, postcode].join(' ')
  end

  def search_data
    {
      full_address: full_address.downcase,
      suburb: locality_name.downcase,
      state: state.downcase,
      postcode: postcode,
      location: {
        latitude: latitude,
        longitude: longitude
      }
    }
  end
end
