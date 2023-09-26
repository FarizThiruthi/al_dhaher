from django.db import models

# Create your models here.
class login(models.Model):
    phonenumber = models.CharField(max_length =50,unique = True)
    password = models.CharField(max_length =50)
    role = models.CharField(max_length =50)


    def __str__(self):
        return self.phonenumber

class user(models.Model):
    name = models.CharField(max_length =50,null = True)
    phonenumber = models.CharField(max_length =50,unique = True)
    password = models.CharField(max_length =50)
    mailid = models.CharField(max_length =50,unique = True)
    pincode = models.CharField(max_length =50)
    location = models.CharField(max_length =50)
    role = models.CharField(max_length =50)  
    profile_pic = models.ImageField(upload_to='food_images/',null=True)
    login_id = models.ForeignKey(login,on_delete=models.CASCADE)  


    def __str__(self):
        return self.name
    

class restaurant(models.Model):
    name = models.CharField(max_length=100)
    location = models.CharField(max_length=200)
    phonenumber = models.CharField(max_length=15)
    mailid = models.CharField(max_length =50,unique = True)
    password = models.CharField(max_length =50)
    role = models.CharField(max_length =50)
    login_id = models.ForeignKey(login,on_delete=models.CASCADE)

    def __str__(self):
        return self.name
   

class food(models.Model):
    restaurant_name = models.CharField(max_length=50)
    restaurant_id = models.CharField(max_length=20)
    food_name = models.CharField(max_length=100)
    quantity = models.CharField(max_length=50)
    price = models.CharField(max_length=20)
    category = models.CharField(max_length=50)
    image = models.ImageField(upload_to='food_images/')
    def __str__(self):
        return self.food_name