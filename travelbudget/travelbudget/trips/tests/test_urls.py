from django.urls import reverse, resolve
from django.test import TestCase
from trips.views import index, searchtrip, register, user_login, user_logout

class TestUrls(TestCase):
    # Testing the URL configurations
    def test_index_url(self):
        url = reverse('index',args=[1])
        self.assertEquals(resolve(url).func, index)
    def test_searchtrip_url(self):
        url = reverse('searchtrip')
        self.assertEquals(resolve(url).func, searchtrip)
    def test_register_url(self):
        url = reverse('register')
        self.assertEquals(resolve(url).func, register)
    def test_login_url(self):
        url = reverse('login')
        self.assertEquals(resolve(url).func, user_login)
    def test_logout_url(self):
        url = reverse('logout')
        self.assertEquals(resolve(url).func, user_logout)
