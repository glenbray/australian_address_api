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

  scope :search_import, -> { where("confidence > 0") }

  def self.reverse_geocode(longitude, latitude)
    Address.search(
      where: {
        location: {
          near: {
            lon: longitude.to_s,
            lat: latitude.to_s
          },
          within: "0.1m"
        }
      }
    )
  end

  def self.bulk_reindex
    uncached do
      counter = 0
      batch_size = 2000

      search_import.find_in_batches(batch_size: batch_size) do |batch|
        counter += batch_size

        searchkick_index.import(batch)

        Rails.logger.info '==================================='
        Rails.logger.info "processed records up to #{counter}"
        Rails.logger.info '==================================='
      end
    end
  end

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
        lat: latitude.to_s,
        lon: longitude.to_s
      }
    }
  end
end
