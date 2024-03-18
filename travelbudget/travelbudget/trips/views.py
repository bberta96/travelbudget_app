from django.shortcuts import render, redirect 
from django.http import HttpResponseRedirect
from django.urls import reverse
from django.contrib import messages
from django.db.models import Avg, Max, Min, Value, Sum, F, FloatField, Prefetch, Q
from django.contrib.auth.forms import UserCreationForm, AuthenticationForm
from django.contrib.auth import login, authenticate, logout
from django.contrib.auth.models import User
from .models import Flight, Trip, Cost, Country

# Create your views here.
class Parameters:
    # The Parameters class stores the searching parameters.
    def __init__(self, origin, destination, number_of_days, number_of_travellers):
        self.origin = origin
        self.destination = destination
        self.number_of_days = number_of_days
        self.number_of_travellers = number_of_travellers
def index(request, id):
    context = {
        "countries": Country.objects.all(),
        "id": id,
        "newtrip": Trip.objects.filter(user_id_id=id).prefetch_related('cost_id')
    }
    if request.method == "POST":
        # Flight information reached from the form data submitted by the user.
        origin = request.POST.get('origin')
        origin_id = Country.objects.only('id').get(country=origin).id
        destination = request.POST.get('destination')
        destination_id = Country.objects.only('id').get(country=destination).id
        # Check whether a Flight object already exists in the database with the above parameters.
        # If it does not exists, a new Flight object can be created.
        check_flight = Flight.objects.filter(origin_id=origin_id,destination_id=destination_id)
        reverse_flight = False
        if not check_flight:
            check_flight_reverse = Flight.objects.filter(origin_id=destination_id,destination_id=origin_id)
            if not check_flight_reverse:
                Flight.objects.create(origin_id=origin_id,destination_id=destination_id)
            else:
                reverse_flight = True
        if reverse_flight == False:
            flight_id = Flight.objects.only('id').get(origin_id=origin_id,destination_id=destination_id).id
        else:
            flight_id = Flight.objects.only('id').get(origin_id=destination_id,destination_id=origin_id).id
        # Details of the trip reached from the form data submitted by the user.
        number_of_days = int(request.POST.get('number_of_days'))
        number_of_travellers = int(request.POST.get('number_of_travellers'))
        # Cost components of the trip reached from the form data submitted by the user.
        # The cost components per person per day will be stored in the database.
        flight_cost = int(request.POST.get('flight_cost'))/number_of_travellers
        hotel_cost = int(request.POST.get('hotel_cost'))/number_of_days/number_of_travellers
        food_cost = int(request.POST.get('food_cost'))/number_of_days/number_of_travellers
        fun_cost = int(request.POST.get('fun_cost'))/number_of_days/number_of_travellers
        travel_cost = int(request.POST.get('travel_cost'))/number_of_days/number_of_travellers
        visa_cost = int(request.POST.get('visa_cost'))/number_of_travellers
        vaccine_cost = int(request.POST.get('vaccine_cost'))/number_of_travellers
        other_cost = int(request.POST.get('other_cost'))/number_of_days/number_of_travellers
        # Check whether a Cost object already exists in the database with the above parameters.
        # If it does not exists, a new Cost object can be created.
        check_cost = Cost.objects.filter(flight_cost=flight_cost,hotel_cost=hotel_cost,food_cost=food_cost,fun_cost=fun_cost,travel_cost=travel_cost,visa_cost=visa_cost,vaccine_cost=vaccine_cost,other_cost=other_cost)
        if not check_cost:
            Cost.objects.create(flight_cost=flight_cost,hotel_cost=hotel_cost,food_cost=food_cost,fun_cost=fun_cost,travel_cost=travel_cost,visa_cost=visa_cost,vaccine_cost=vaccine_cost,other_cost=other_cost)
        cost_id = Cost.objects.only('id').get(flight_cost=flight_cost,hotel_cost=hotel_cost,food_cost=food_cost,fun_cost=fun_cost,travel_cost=travel_cost,visa_cost=visa_cost,vaccine_cost=vaccine_cost,other_cost=other_cost).id
        # Check whether a Trip object already exists in the database with the given parameters.
        # If it does not exists, a new Trip object can be created.
        user_id = id
        trip_name = request.POST.get('trip_name')
        check_trip = Trip.objects.filter(number_of_days=number_of_days,number_of_travellers = number_of_travellers, trip_name=trip_name,user_id_id=user_id,flight_id_id =flight_id,cost_id_id=cost_id)
        if not check_trip:
            if not reverse_flight:
                Trip.objects.create(number_of_days=number_of_days,number_of_travellers = number_of_travellers, trip_name=trip_name,reverse = False, user_id_id=user_id,flight_id_id =flight_id,cost_id_id=cost_id)
            else:
                Trip.objects.create(number_of_days=number_of_days,number_of_travellers = number_of_travellers, trip_name=trip_name,reverse = True, user_id_id=user_id,flight_id_id =flight_id,cost_id_id=cost_id)
        messages.success(request, 'New trip successfully added!')
    return render(request, "trips/index.html", context)

def searchtrip(request):
    if request.method == "POST":
        # Searching parameters reached from the form data submitted by the user.
        origin = request.POST.get('origin')
        origin_id = Country.objects.only('id').get(country=origin).id
        destination = request.POST.get('destination')
        destination_id = Country.objects.only('id').get(country=destination).id
        number_of_days = request.POST.get('number_of_days')
        number_of_travellers = int(request.POST.get('number_of_travellers'))
        parameter = Parameters(origin, destination, number_of_days, number_of_travellers)
        # Determination of the airfare by retrieving information from the database.
        # Check whether a Flight object exists in the database with the above parameters.
        get_flight = Flight.objects.filter(origin_id=origin_id,destination_id=destination_id)
        flight_exists = True
        reverse_flight = False
        searchedflights = get_flight
        if not get_flight:
            get_flight_reverse = Flight.objects.filter(origin_id=destination_id,destination_id=origin_id)
            if not get_flight_reverse:
                flight_exists = False
            else:
                reverse_flight = True
                searchedflights = get_flight_reverse
        flight_list_id = 0
        tripexists = False
        # Retrieve those Trip objects to which the searched Flight object belongs.
        if flight_exists:
            tripexists = True
            if not reverse_flight:
                flight_list_id = Flight.objects.only('id').get(origin_id=origin_id,destination_id=destination_id).id
            else:
                flight_list_id = Flight.objects.only('id').get(origin_id=destination_id,destination_id=origin_id).id
        searchedtrips = Trip.objects.filter(flight_id_id=flight_list_id)
        # Retrieve the Cost objects belong to the particular Trip objects.
        # Determine the average, maximum and minimum of the flight cost fields of the selected Cost objects.
        searchedcostids = []
        for onetrip in searchedtrips:
            cost_id = onetrip.cost_id_id
            searchedcostids.append(cost_id)
        searchedflightcosts = Cost.objects.filter(pk__in=searchedcostids)
        averagetotalflightcost = Cost.objects.filter(pk__in=searchedcostids).aggregate(flight_cost=Avg(F('flight_cost')*Value(number_of_travellers),output_field=FloatField()))
        maxtotalflightcost = Cost.objects.filter(pk__in=searchedcostids).aggregate(flight_cost=Max(F('flight_cost')*Value(number_of_travellers),output_field=FloatField()))
        mintotalflightcost = Cost.objects.filter(pk__in=searchedcostids).aggregate(flight_cost=Min(F('flight_cost')*Value(number_of_travellers),output_field=FloatField()))
        # Determination of the living costs at the destination by retrieving information from the database.
        # Retrieve those Flight objects where one of the parameters is the searched destination country.
        searcheddestination = Flight.objects.filter(destination_id=destination_id)
        searchedreversedestination = Flight.objects.filter(origin_id=destination_id)
        if not flight_exists: 
            if searcheddestination is not None:
                tripexists = True
            elif searchedreversedestination is not None:
                tripexists = True
        # Retrieve those Trip objects to which the searched Flight objects belongs.
        searchedcountrycostids = []
        for onecountry in searcheddestination:
            oneflight_id = onecountry.id
            destinationtrip = Trip.objects.filter(flight_id_id=oneflight_id)
            for onedestination in destinationtrip:
                if not onedestination.reverse:
                    destination_cost_id = onedestination.cost_id_id
                    searchedcountrycostids.append(destination_cost_id)
        for reversecountry in searchedreversedestination:
            reverseflight_id = reversecountry.id
            reversedestinationtrip = Trip.objects.filter(flight_id_id=reverseflight_id)
            for reversedestination in reversedestinationtrip:
                if reversedestination.reverse:
                    reversedestination_cost_id = reversedestination.cost_id_id
                    searchedcountrycostids.append(reversedestination_cost_id)
        # Retrieve the Cost objects belong to the particular Trip objects.
        # Determine the average, maximum and minimum of the particular cost fields of the selected Cost objects.
        searchedcosts = Cost.objects.filter(pk__in=searchedcountrycostids)
        averagecosts = Cost.objects.filter(pk__in=searchedcountrycostids).aggregate(hotel_cost=Avg('hotel_cost'),food_cost=Avg('food_cost'),fun_cost=Avg('fun_cost'),travel_cost=Avg('travel_cost'),visa_cost=Avg('visa_cost'),vaccine_cost=Avg('vaccine_cost'),other_cost=Avg('other_cost'))
        maxcosts = Cost.objects.filter(pk__in=searchedcountrycostids).aggregate(hotel_cost=Max('hotel_cost'),food_cost=Max('food_cost'),fun_cost=Max('fun_cost'),travel_cost=Max('travel_cost'),visa_cost=Max('visa_cost'),vaccine_cost=Max('vaccine_cost'),other_cost=Max('other_cost'))
        mincosts = Cost.objects.filter(pk__in=searchedcountrycostids).aggregate(hotel_cost=Min('hotel_cost'),food_cost=Min('food_cost'),fun_cost=Min('fun_cost'),travel_cost=Min('travel_cost'),visa_cost=Min('visa_cost'),vaccine_cost=Min('vaccine_cost'),other_cost=Min('other_cost'))
        averagetotalcost = Cost.objects.filter(pk__in=searchedcountrycostids).aggregate(hotel_cost=Avg(F('hotel_cost')*Value(number_of_days),output_field=FloatField()),food_cost=Avg(F('food_cost')*Value(number_of_days),output_field=FloatField()),fun_cost=Avg(F('fun_cost')*Value(number_of_days),output_field=FloatField()),travel_cost=Avg(F('travel_cost')*Value(number_of_days),output_field=FloatField()),visa_cost=Avg('visa_cost'),vaccine_cost=Avg('vaccine_cost'),other_cost=Avg(F('other_cost')*Value(number_of_days),output_field=FloatField()))
        maxtotalcost = Cost.objects.filter(pk__in=searchedcountrycostids).aggregate(hotel_cost=Max(F('hotel_cost')*Value(number_of_days),output_field=FloatField()),food_cost=Max(F('food_cost')*Value(number_of_days),output_field=FloatField()),fun_cost=Max(F('fun_cost')*Value(number_of_days),output_field=FloatField()),travel_cost=Max(F('travel_cost')*Value(number_of_days),output_field=FloatField()),visa_cost=Max('visa_cost'),vaccine_cost=Max('vaccine_cost'),other_cost=Max(F('other_cost')*Value(number_of_days),output_field=FloatField()))
        mintotalcost = Cost.objects.filter(pk__in=searchedcountrycostids).aggregate(hotel_cost=Min(F('hotel_cost')*Value(number_of_days),output_field=FloatField()),food_cost=Min(F('food_cost')*Value(number_of_days),output_field=FloatField()),fun_cost=Min(F('fun_cost')*Value(number_of_days),output_field=FloatField()),travel_cost=Min(F('travel_cost')*Value(number_of_days),output_field=FloatField()),visa_cost=Min('visa_cost'),vaccine_cost=Min('vaccine_cost'),other_cost=Min(F('other_cost')*Value(number_of_days),output_field=FloatField()))
        context = {
            "searchedflights": searchedflights,
            "flights": Flight.objects.all(),
            "countries": Country.objects.all(),
            "searchedtrips": searchedtrips,
            "searchedcosts": searchedcosts,
            "averagecosts": averagecosts,
            "maxcosts": maxcosts,
            "mincosts": mincosts,
            "averagetotalcost": averagetotalcost,
            "maxtotalcost": maxtotalcost,
            "mintotalcost": mintotalcost,
            "searchedflightcosts": searchedflightcosts,
            "averagetotalflightcost": averagetotalflightcost,
            "maxtotalflightcost": maxtotalflightcost,
            "mintotalflightcost": mintotalflightcost,
            "tripexists": tripexists,
            "parameter": parameter
        }
        return render(request, "trips/searchtrip.html", context)
    else:
        context = {
        "flights": Flight.objects.all(),
        "countries": Country.objects.all()
        }
        return render(request, "trips/searchtrip.html", context)
def register(response):
    # Registration of new users if the registration form is filled out correctly.
    if response.method == "POST":
        form = UserCreationForm(response.POST)
        if form.is_valid():
            form.save()
            messages.success(request, 'You have been successfully created a new account!')
            return redirect("login")
    else:
        form = UserCreationForm()
    return render(response, "trips/register.html", {"form":form})
def user_login(request):
    # Login of the user if the provided username and password combination is valid.
    if request.method == "POST":
        form = AuthenticationForm(request=request,data=request.POST) 
        if form.is_valid():
            user=authenticate(username=request.POST["username"], password=request.POST["password"])
            if user is not None:
                login(request, user)
                messages.success(request, 'You have been successfully logged in!')
                return redirect("index", id=user.id)
            else:
                for error in list(form.errors.values()):
                    messages.error(request, error)
    else:
        form = AuthenticationForm()
    return render(request=request, template_name="trips/login.html", context={'form': form})
def user_logout(request):
    # Logout of the user.
    logout(request)
    messages.info(request, 'You have been successfully logged out!')
    return redirect("login")