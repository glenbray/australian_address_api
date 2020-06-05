require "test_helper"

class AddressTest < ActiveSupport::TestCase
  test "#full_address" do
    address = Address.new(
      address: "UNIT 1, 3 MACROSSAN STREET",
      locality_name: "CRANLEY",
      postcode: 4350,
      state: "QLD"
    )

    assert_equal "Unit 1, 3 Macrossan Street Cranley 4350 QLD", address.full_address
  end

  test "search" do
    street_address = "UNIT 1, 3 MACROSSAN STREET"

    address = Address.new(
      address: "UNIT 1, 3 MACROSSAN STREET",
      locality_name: "CRANLEY",
      postcode: 4350,
      state: "QLD"
    ).save!

    assert_equal Address.search(street_address.downcase).first, "hey"
  end
end
