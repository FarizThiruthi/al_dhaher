"""
URL configuration for aldhaher project.

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/4.2/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  path('', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  path('', Home.as_view(), name='home')
Including another URLconf
    1. Import the include() function: from django.urls import include, path
    2. Add a URL to urlpatterns:  path('blog/', include('blog.urls'))
"""
from django.contrib import admin
from django.urls import path
from . import views

urlpatterns = [

    path('userRegistrerAPI',views.userRegistrerAPI.as_view(),name='userRegistrerAPI'),
    path('LogiAPIView',views.LogiAPIView.as_view(),name='LogiAPIView'),
    path('ViewAllUsersAPI/', views.ViewAllUsersAPI.as_view(), name='ViewAllUsersAPI'),
    path('UpdateUserAPI/<int:user_id>',views.UpdateUserAPI.as_view(),name='UpdateUserAPI'),
    path('DeleteUserAPI/<int:user_id>',views.DeleteUserAPI.as_view(),name='DeleteUserAPI'),
    path('UserSearchAPI',views.UserSearchAPI.as_view(),name = 'UserSearchAPI'),
    
    path('resRegisterAPI',views.resRegisterAPI.as_view(),name='resRegisterAPI'),
    path('RestaurantLoginAPI',views.RestaurantLoginAPI.as_view(),name='RestaurantLoginAPI'),
    path('ViewAllRestaurantsAPI',views.ViewAllRestaurantsAPI.as_view(),name='ViewAllRestaurantsAPI'),
    path('ViewSingleRestaurantAPI/<int:restaurant_id>',views.ViewSingleRestaurantAPI.as_view(),name='ViewSingleRestaurantAPI'),
    path('UpdateRestaurantAPI/<int:restaurant_id>',views.UpdateRestaurantAPI.as_view(),name='UpdateRestaurantAPI'),
    path('DeleteRestaurantAPI/<int:restaurant_id>',views.DeleteRestaurantAPI.as_view(),name='DeleteRestaurantAPI'),
    path('RestaurantSearchAPI',views.RestaurantSearchAPI.as_view(),name='RestaurantSearchAPI'),


    path('FoodCreateAPI', views.FoodCreateAPI.as_view(), name='FoodCreateAPI'),
    path('ViewAllFoodsAPI/', views.ViewAllFoodsAPI.as_view(), name='ViewAllFoodsAPI'),
    path('ViewSingleFoodAPI/<int:food_id>/', views.ViewSingleFoodAPI.as_view(), name='ViewSingleFoodAPI'),
    path('UpdateFoodAPI/<int:food_id>/', views.UpdateFoodAPI.as_view(), name='UpdateFoodAPI'),
    path('DeleteFoodAPI/<int:food_id>/', views.DeleteFoodAPI.as_view(), name='DeleteFoodAPI'),
    path('ViewCartItemsAPI/<int:user_id>',views.ViewCartItemsAPI.as_view(),name='ViewCartItemsAPI'),
    path('DeleteCartAPI/<int:user_id>',views.DeleteCartAPI.as_view(),name='DeleteCartAPI'),
    
    path('ViewAllRestaurantFoodsAPI/<int:restaurant_id>/', views.ViewAllRestaurantFoodsAPI.as_view(), name='ViewAllRestaurantFoodsAPI'),
    path('RestaurantCartAPI', views.RestaurantCartAPI.as_view(), name='RestaurantCartAPI'),

    path('FoodSearchAPI', views.FoodSearchAPI.as_view(), name='FoodSearchAPI'),
]
