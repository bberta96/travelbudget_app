from django.db import models
from django.contrib.auth.models import User

# Create your models here.
class Country(models.Model):
    # The Country model stores the available countries.
    country = models.CharField(max_length=64)
    class Meta:
        db_table="country_table"
class Flight(models.Model):
    # The Flight model stores the flight information.
    origin = models.ForeignKey(Country, default = 1, on_delete=models.CASCADE, related_name="departure")
    destination = models.ForeignKey(Country, default = 1, on_delete=models.CASCADE, related_name="arrival")
    class Meta:
        db_table="flight_table"
        unique_together = ('origin','destination')
class Cost(models.Model):
    # The Cost model stores the cost components of the trip.
    flight_cost = models.IntegerField()
    hotel_cost = models.IntegerField()
    food_cost = models.IntegerField()
    fun_cost = models.IntegerField()
    travel_cost = models.IntegerField()
    visa_cost = models.IntegerField()
    vaccine_cost = models.IntegerField()
    other_cost = models.IntegerField()
    class Meta:
        db_table="cost_table"
class Trip(models.Model):
    # The Trip model stores the details of the trip.
    user_id = models.ForeignKey(User, on_delete=models.CASCADE, related_name="users", null=True)
    flight_id = models.ForeignKey(Flight, on_delete=models.CASCADE, related_name="flights")
    cost_id = models.ForeignKey(Cost, on_delete=models.CASCADE, related_name="costs")
    number_of_days = models.IntegerField()
    number_of_travellers = models.IntegerField()
    trip_name = models.CharField(max_length=64)
    reverse = models.BooleanField(default=True)
    class Meta:
        db_table="trip_table"
