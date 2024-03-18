from django.test import TestCase
from trips.models import Flight, Trip, Cost, Country
from django.contrib.auth.models import User

class TestViews(TestCase):
    def setUp(self):
        # Creating objects for the test case
        self.country1 = Country.objects.create(
            country = 'Germany'
        )
        self.country2 = Country.objects.create(
            country = 'Hungary'
        )
        self.flight = Flight.objects.create(
            origin = self.country1,
            destination = self.country2
        )
        self.cost = Cost.objects.create(
            flight_cost = 130,
            hotel_cost = 240,
            food_cost = 50,
            fun_cost = 85,
            travel_cost = 125,
            visa_cost = 40,
            vaccine_cost = 0,
            other_cost = 25
        )
        self.user = User.objects.create(
            username = 'user',
            password = 'password'
        )
        self.trip = Trip.objects.create(
            user_id = self.user,
            flight_id = self.flight,
            cost_id = self.cost,
            number_of_days = 5,
            number_of_travellers = 2,
            trip_name = 'Trip',
            reverse = False
        )
    def test_trip_model(self):
        # Testing the many-to-many relationships between the models
        self.assertEqual(self.trip.trip_name, 'Trip')
        self.assertEqual(self.trip.user_id, self.user)
        self.assertEqual(self.trip.cost_id.hotel_cost, 240)
        self.assertEqual(self.trip.flight_id.origin.country, 'Germany')
