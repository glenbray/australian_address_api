json.array! @addresses do |a|
  json.address a["address"]
  json.lot_number a["lot_number"]
  json.flat_number a["flat_number"]
  json.level_number a["level_number"]
  json.number_first a["number_first"]
  json.number_last a["number_last"]
  json.street_name a["street_name"]
  json.street_type a["street_type"]
  json.street_suffix a["street_suffix"]
  json.suburb a["locality_name"]
  json.postcode a["postcode"]
  json.state a["state"]
end

