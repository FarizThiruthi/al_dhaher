from django.contrib import admin
from .models import login,user,restaurant,food

# Register your models here.
admin.site.register(user)
admin.site.register(login)
admin.site.register(restaurant)
admin.site.register(food)