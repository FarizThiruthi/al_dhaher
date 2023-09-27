from rest_framework import serializers
from .models import login,user,restaurant,food,Cart,RestaurantCart


class loginUserSerializer (serializers.ModelSerializer):
    class Meta:
        model = login
        fields = '__all__'
    def create(self,validated_data):
        return login.objects.create(**validated_data)    

class UserSerializer (serializers.ModelSerializer):
    class Meta:
        model = user
        fields = '__all__'  
    def create(self,validated_data):
        return user.objects.create(**validated_data)      

class RestaurantSerializer(serializers.ModelSerializer):
    class Meta:
        model = restaurant
        fields = '__all__'    
    def create(self,validated_data):
        return restaurant.objects.create(**validated_data)   


class FoodSerializer(serializers.ModelSerializer):
    class Meta:
        model = food
        fields = '__all__'
    def create(self,validated_data):
        return food.objects.create(**validated_data)
    

class CartSerializer(serializers.ModelSerializer):
    class Meta:
        model = Cart
        fields = '__all__'

class RestaurantCartSerializer(serializers.ModelSerializer):
    restaurant_id = serializers.CharField(source='food.restaurant_id', read_only=True)
    restaurant_name = serializers.CharField(source='food.restaurant_name', read_only=True)

    class Meta:
        model = RestaurantCart
        fields = '__all__'