require 'minitest/autorun'

class BookingTest < Minitest::Test
  def placeBooking
    books = BookingsController.new
    assert_equal "Vehículo no disponible para las fechas seleccionadas", books.create({	"token":"eyJhbGciOiJSUzI1NiIsImtpZCI6Im5remtXQSJ9.eyJpc3MiOiJodHRwczovL2lkZW50aXR5dG9vbGtpdC5nb29nbGUuY29tLyIsImF1ZCI6InJlbnR5LXZ1ZSIsImlhdCI6MTU0NDc3MDc1NiwiZXhwIjoxNTQ1OTgwMzU2LCJ1c2VyX2lkIjoiS1M4M3pyVDVtU1JDNmNpeENpdGVIV2RFRVE1MyIsImVtYWlsIjoiY2VzYXIubXVub3pyMkB1ZGVhLmVkdS5jbyIsInNpZ25faW5fcHJvdmlkZXIiOiJwYXNzd29yZCIsInZlcmlmaWVkIjpmYWxzZX0.JiO2pYb_k2gwpOyzmjUHn9G4WhjVPB1oOI4PfYwWBeU3BW_TNACCJyJRlsx-2go1s-O3XBggX90Dwpbb6YlUowVbS4p1kDf0myW32WGmET5zUZBGoDSDkd1sAGTabjU3lyqhgJuYok8UMwdyriCG3itmRjpyjLyT6IErwpKPK6nMtBi2Y-kGKHChh8N1ERXG0NNpAubT1hZJZBm9O2p0K6kt7TCaHxG9dsvRB3gVNMjPiUrU12Qmch9C0Pae74yK_yj6M-CbYnzX68rZkfqqyTUPHMJUhwW4gmCUXWbcCIX3VOedvN4Q-fK1GEyC0QyQHupAkJYfibIs_LWIbi1mQg",
    "carId":3,
    "bookingDate":"2018-02-13",
    "pickup":"Medellin DC",
    "pickupDate":"2018-01-01",
    "deliverPlace":"Bogota DC",
    "deliverDate":"2018-02-03"
  })
  end
  def searchBookings
    books = BookingsController.new
    assert_equal "{	bookingId:10,
    uid: KJSDHFJHS54K45L4K67WFFFN,
    car: {
      id: 3,
      brand: KIA,
      model: 2018,
      thumbnail:,
      price: 1232,
      type: LUJO
    },
    bookingDate: ,
    pickup: Medellin DC,
    pickupDate: ,
    deliverPlace: ,
    rental: {
      id: 1,
      name: RUBY
      }
    }", books.search({	"token":"eyJhbGciOiJSUzI1NiIsImtpZCI6Im5remtXQSJ9.eyJpc3MiOiJodHRwczovL2lkZW50aXR5dG9vbGtpdC5nb29nbGUuY29tLyIsImF1ZCI6InJlbnR5LXZ1ZSIsImlhdCI6MTU0NDc3MDc1NiwiZXhwIjoxNTQ1OTgwMzU2LCJ1c2VyX2lkIjoiS1M4M3pyVDVtU1JDNmNpeENpdGVIV2RFRVE1MyIsImVtYWlsIjoiY2VzYXIubXVub3pyMkB1ZGVhLmVkdS5jbyIsInNpZ25faW5fcHJvdmlkZXIiOiJwYXNzd29yZCIsInZlcmlmaWVkIjpmYWxzZX0.JiO2pYb_k2gwpOyzmjUHn9G4WhjVPB1oOI4PfYwWBeU3BW_TNACCJyJRlsx-2go1s-O3XBggX90Dwpbb6YlUowVbS4p1kDf0myW32WGmET5zUZBGoDSDkd1sAGTabjU3lyqhgJuYok8UMwdyriCG3itmRjpyjLyT6IErwpKPK6nMtBi2Y-kGKHChh8N1ERXG0NNpAubT1hZJZBm9O2p0K6kt7TCaHxG9dsvRB3gVNMjPiUrU12Qmch9C0Pae74yK_yj6M-CbYnzX68rZkfqqyTUPHMJUhwW4gmCUXWbcCIX3VOedvN4Q-fK1GEyC0QyQHupAkJYfibIs_LWIbi1mQg"})
  end
end