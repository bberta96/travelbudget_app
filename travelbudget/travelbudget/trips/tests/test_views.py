from django.test import TestCase, Client
from django.urls import reverse
from trips.models import Flight, Trip, Cost, Country
from django.contrib.auth.models import User
from django.contrib.auth.forms import UserCreationForm, AuthenticationForm

class TestViews(TestCase):
    def setUp(self):
        # Set up test data
        self.client = Client()
        self.searchtrip_url = reverse('searchtrip')
        self.user = User.objects.create_user(
            username = 'user',
            password = 'password'
        )
        self.index_url = reverse('index',args=[self.user.pk])
        self.register_url = reverse('register')
        self.login_url = reverse('login')
        self.logout_url = reverse('logout')
        self.country1 = Country.objects.create(
            country = 'Germany'
        )
        self.country2 = Country.objects.create(
            country = 'Hungary'
        )
        self.country3 = Country.objects.create(
            country = 'UK'
        )
        self.flight = Flight.objects.create(
            origin = self.country1,
            destination = self.country2
        )
        self.cost1 = Cost.objects.create(
            flight_cost = 130,
            hotel_cost = 240,
            food_cost = 50,
            fun_cost = 85,
            travel_cost = 125,
            visa_cost = 40,
            vaccine_cost = 0,
            other_cost = 25
        )
        self.cost2 = Cost.objects.create(
            flight_cost = 120,
            hotel_cost = 280,
            food_cost = 55,
            fun_cost = 60,
            travel_cost = 105,
            visa_cost = 0,
            vaccine_cost = 0,
            other_cost = 70
        )
        self.trip1 = Trip.objects.create(
            user_id = self.user,
            flight_id = self.flight,
            cost_id = self.cost1,
            number_of_days = 5,
            number_of_travellers = 2,
            trip_name = 'Trip1',
            reverse = False
        )
        self.trip2 = Trip.objects.create(
            user_id = self.user,
            flight_id = self.flight,
            cost_id = self.cost2,
            number_of_days = 2,
            number_of_travellers = 1,
            trip_name = 'Trip2',
            reverse = True
        )
    def test_index_GET(self):
        # Test that a logged in user is redirected to the correct template
        self.client.force_login(self.user)
        response = self.client.get(self.index_url)
        self.assertEquals(response.status_code, 200)
        self.assertTemplateUsed(response, 'trips/index.html')
    def test_searchtrip_GET(self):
        # Test that a user is redirected to the correct template
        response = self.client.get(self.searchtrip_url)
        self.assertEquals(response.status_code, 200)
        self.assertTemplateUsed(response, 'trips/searchtrip.html')
        self.assertContains(response,self.country1.country)
    def test_register_GET(self):
        # Test that a user is redirected to the correct template
        response = self.client.get(self.register_url)
        self.assertEquals(response.status_code, 200)
        self.assertTemplateUsed(response, 'trips/register.html')
    def test_login_GET(self):
        # Test that a user is redirected to the correct template
        response = self.client.get(self.login_url)
        self.assertEquals(response.status_code, 200)
        self.assertTemplateUsed(response, 'trips/login.html')
    def test_logout_GET(self):
        # Test that the user is redirected to the login page after the successful logout
        response = self.client.get(self.logout_url)
        self.assertEquals(response.status_code, 302)
        self.assertRedirects(response, '/trips/account/login')
    def test_searchtrip_POST(self):
        # Test the context variable passed to the template by the view
        data = {
            'origin' : self.country1.country,
            'destination' : self.country2.country,
            'number_of_days' : 5,
            'number_of_travellers' : 2
        }
        response = self.client.post(self.searchtrip_url, data)
        self.assertEquals(response.status_code, 200)
        self.assertTemplateUsed(response, 'trips/searchtrip.html')
        self.assertContains(response, 'csrfmiddlewaretoken')
        self.assertContains(response,self.trip1.cost_id.hotel_cost)
        self.assertNotContains(response,self.trip2.cost_id.hotel_cost)
        self.assertContains(response,self.trip2.cost_id.flight_cost)
        self.assertTrue('searchedcosts' in response.context)
    def test_index_POST(self):
        # Test that the form has all the necessary fields
        # Test that the template is getting all the data it needs
        # Test the created objects
        data = {
            'trip_name' : 'New trip',
            'origin' : self.country1.country,
            'destination' : self.country3.country,
            'number_of_days' : 7,
            'number_of_travellers' : 2,
            'flight_cost' : 350,
            'hotel_cost' : 500,
            'food_cost' : 80,
            'fun_cost' : 100,
            'travel_cost' : 196,
            'visa_cost' : 0,
            'vaccine_cost' : 40,
            'other_cost' : 100
        }
        response = self.client.post(self.index_url, data)
        self.assertEquals(response.status_code, 200)
        self.assertTemplateUsed(response, 'trips/index.html')
        self.assertContains(response, 'csrfmiddlewaretoken')
        new_trip = Trip.objects.latest('id')
        self.assertEquals(new_trip.trip_name, 'New trip')
        self.assertEqual(new_trip.user_id, self.user)
        self.assertEqual(new_trip.cost_id.travel_cost, 14)
        self.assertEqual(new_trip.flight_id.destination.country, 'UK')
    def test_login_authenticated_user_POST(self):
        # Verify that users with valid credentials can successfully authenticate
        data = {
            'username': 'user',
            'password': 'password'
        }
        form = AuthenticationForm(data = {
            'username': 'user',
            'password': 'password'
        })
        self.assertTrue(form.is_valid())
        response = self.client.post(self.login_url, data, follow = True)
        self.assertTrue(response.context['user'].is_authenticated)
        self.assertEquals(response.status_code, 200)
        self.assertRedirects(response, f'/trips/{self.user.pk}')
    def test_login_not_authenticated_user_POST(self):
        # Ensure that users with invalid credentials cannot access the system
        data = {
            'username': 'password',
            'password': 'user'
        }
        form = AuthenticationForm(data = {
            'username': 'password',
            'password': 'user'
        })
        response = self.client.post(self.login_url, data, follow = True)
        self.assertFalse(response.context['user'].is_authenticated)
        self.assertEquals(response.status_code, 200)
        self.assertTemplateUsed(response, 'trips/login.html')
    def test_login_form_not_valid_POST(self):
        # Ensure that an empty form can not be submitted
        data = {
            'username': '',
            'password': ''
        }
        form = AuthenticationForm(data = {
            'username': '',
            'password': ''
        })
        self.assertFalse(form.is_valid())
        response = self.client.post(self.login_url, data, follow = True)
        self.assertEquals(response.status_code, 200)
        self.assertTemplateUsed(response, 'trips/login.html')
    def test_register_form_valid_POST(self):
        # Ensure that a new User object can be created by filling out the form correctly
        data = {
            'username': 'new_user',
            'password1': 'new_password',
            'password2': 'new_password'
        }
        form = UserCreationForm(data = {
            'username': 'new_user',
            'password1': 'new_password',
            'password2': 'new_password'
        })
        self.assertTrue(form.is_valid())
        response = self.client.post(self.register_url, data, follow = True)
        new_user = User.objects.latest('id')
        self.assertEquals(new_user.username, 'new_user')
        self.assertEquals(response.status_code, 200)
        self.assertRedirects(response, '/trips/account/login')
    def test_register_form_not_valid_POST(self):
        # Ensure that an empty form can not be submitted
        data = {
            'username': 'new_user',
            'password1': 'new_password',
            'password2': ''
        }
        form = UserCreationForm(data = {
            'username': 'new_user',
            'password1': 'new_password',
            'password2': ''
        })
        self.assertFalse(form.is_valid())
        response = self.client.post(self.register_url, data, follow = True)
        self.assertEquals(response.status_code, 200)
        self.assertTemplateUsed(response, 'trips/register.html')



