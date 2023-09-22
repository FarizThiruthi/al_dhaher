from django.shortcuts import render,redirect
from rest_framework import generics
from.serializers import loginUserSerializer,UserSerializer,RestaurantSerializer,FoodSerializer
from.models import user,login,restaurant,food


from rest_framework.response import Response
from rest_framework import status
from rest_framework.generics import GenericAPIView


 # Create your views here.

class userRegistrerAPI(GenericAPIView):
    serializer_class = UserSerializer
    serializer_class_login = loginUserSerializer

    def post(self, request):
        name = request.data.get('name')
        phone = request.data.get('phonenumber')
        mailid = request.data.get('mailid')
        pincode = request.data.get('pincode')
        location = request.data.get('location')
        password = request.data.get('password')
        profile = request.data.get('image')
        role = 'user'

        if login.objects.filter(phonenumber=phone):
            return Response({'message': 'Phone number already exists'}, status=status.HTTP_400_BAD_REQUEST)
        else:
            serializer_login = self.serializer_class_login(data={'phonenumber': phone, 'password': password, 'role': role})

            if serializer_login.is_valid():
                login_instance = serializer_login.save()
                login_id = login_instance.id  # Get the generated login_id here

                serializer = self.serializer_class(
                    data={
                        'login_id': login_id,
                        'name': name,
                        'phonenumber': phone,
                        'mailid': mailid,
                        'pincode': pincode,
                        'location': location,
                        'password': password,
                        'role': role,
                        'profile_pic': profile,
                    }
                )

                if serializer.is_valid():
                    serializer.save()
                    return Response({'data': serializer.data, 'message': 'Registration successful', 'success': True},
                                    status=status.HTTP_201_CREATED)
                else:
                    # Rollback login creation if registration fails
                    login_instance.delete()
                    return Response({'message': 'Registration error', 'success': False}, status=status.HTTP_400_BAD_REQUEST)
            else:
                return Response({'message': 'Login creation error', 'success': False}, status=status.HTTP_400_BAD_REQUEST)


class LogiAPIView(GenericAPIView):
    serializer_class = loginUserSerializer

    def post(self, request):
        u_id = ''
        phone = request.data.get('phone')
        password = request.data.get('password')
        print(phone)
        print(password)

        # Check if the user exists with the given phone number
        logreg = login.objects.filter(phonenumber=phone)
        if logreg.count() > 0:
            # Check if the password matches
            logreg = logreg.filter(password=password)
            if logreg.count() > 0:
                read_serializer = loginUserSerializer(logreg, many=True)

                for i in read_serializer.data:
                    id = i['id']
                    print(id)
                    role = i['role']
                    print(role)
                    regdata = user.objects.all().filter(login_id=id).values()
                    print(regdata, "vvgvggfgg")

                    for i in regdata:
                        u_id = i['id']
                        name = i['name']
                        # l_status = i['userstatus']
                        print(u_id)

                    regdata = restaurant.objects.all().filter(login_id=id).values()
                    print(regdata)
                    for i in regdata:
                        u_id = i['id']
                        name = i['name']
                        print(u_id)

                    return Response({
                        'data': {
                            'login_id': id,
                            'username': phone,
                            'password': password,
                            'role': role,
                            'userid': u_id,
                            
                            # 'status':l_status
                        },
                        'success': True,
                        'message': 'Logged in successfully'
                    }, status=status.HTTP_200_OK)
            else:
                return Response({
                    'message': 'Password not valid',
                    'success': False
                }, status=status.HTTP_400_BAD_REQUEST)
        else:
            return Response({
                'message': 'Phone number not valid',
                'success': False
            }, status=status.HTTP_400_BAD_REQUEST)


# class LogiAPIView(GenericAPIView):
#     serializer_class = loginUserSerializer

#     def post (self,request):
#         u_id = ' '
#         phone = request.data.get('phone')
#         password = request.data.get('password')
#         print(phone)
#         print(password)
#         logreg=login.objects.filter(phonenumber=phone,password=password)
#         if(logreg.count()>0):
#             read_serializer = loginUserSerializer(logreg,many = True)

#             for i in read_serializer.data:
#                 id = i['id']
#                 print (id)
#                 role = i['role']
#                 print(role)
#                 regdata = user.objects.all().filter(login_id=id).values()
#                 print(regdata,"vvgvggfgg")

#                 for i in regdata:
#                     u_id = i['id']
#                     name = i['name']
#                     #l_status = i['userstatus']
#                     print(u_id)

#                 regdata= restaurant.objects.all().filter(login_id=id).values()
#                 print(regdata)
#                 for i in regdata:
#                     u_id = i['id']
#                     name = i['name']
#                     print(u_id)

#                 return Response({
#                     'data':{
#                         'login_id': id,
#                         'username':phone,
#                         'password':password,
#                         'role':role,
#                         'userid':u_id,
#                         #'status':l_status
#                     },
#                     'success': True,
#                     'message':'Logged in successfullly'
#                 },status=status.HTTP_200_OK)
#         else:
#             return Response({
#                     'message':'Phone number not valid',
#                     'success':False
#                 },status = status.HTTP_400_BAD_REQUEST)
  

class ViewAllUsersAPI(GenericAPIView):
    serializer_class = UserSerializer

    def get(self, request):
        users = user.objects.all()
        serializer = self.serializer_class(users, many=True)
        return Response({'data': serializer.data, 'message': 'All users data', 'success': True}, status=status.HTTP_200_OK)

class ViewSingleUserAPI(GenericAPIView):
    serializer_class = UserSerializer

    def get(self, request, user_id):
        try:
            single_user = user.objects.get(pk=user_id)
            serializer = self.serializer_class(single_user)
            return Response({'data': serializer.data, 'message': 'Single user data', 'success': True}, status=status.HTTP_200_OK)
        except user.DoesNotExist:
            return Response({'message': 'User not found', 'success': False}, status=status.HTTP_404_NOT_FOUND)

class UpdateUserAPI(GenericAPIView):
    serializer_class = UserSerializer

    def put(self, request, user_id):
        try:
            single_user = user.objects.get(pk=user_id)
            serializer = self.serializer_class(instance=single_user, data=request.data, partial=True)
            if serializer.is_valid():
                serializer.save()
                return Response({'data': serializer.data, 'message': 'User updated successfully', 'success': True}, status=status.HTTP_200_OK)
            else:
                return Response({'data': 'User update failed', 'success': False}, status=status.HTTP_400_BAD_REQUEST)
        except user.DoesNotExist:
            return Response({'message': 'User not found', 'success': False}, status=status.HTTP_404_NOT_FOUND)

class DeleteUserAPI(GenericAPIView):

    def delete(self, request, user_id):
        try:
            single_user = user.objects.get(pk=user_id)
            single_user.delete()
            return Response({'message': 'User deleted successfully', 'success': True}, status=status.HTTP_200_OK)
        except user.DoesNotExist:
            return Response({'message': 'User not found', 'success': False}, status=status.HTTP_404_NOT_FOUND)

class UserSearchAPI(GenericAPIView):
    def post(self, request):
        query = request.data.get('query')
        print(query)
        # Perform the user search based on the query
        users = user.objects.filter(name__icontains=query) | user.objects.filter(phonenumber__icontains=query)
        
        # for i in users:
        #     print(i)
        # Serialize the user data
        user_data = [{'name': u.name, 'phonenumber': u.phonenumber} for u in users]

        return Response({'data': user_data, 'message': 'User search successful', 'success': True}, status=status.HTTP_200_OK)

class resRegisterAPI(GenericAPIView):
    serializer_class = RestaurantSerializer
    serializer_class_login = loginUserSerializer

    def post(self, request):
        name = request.data.get('name')
        phone = request.data.get('phonenumber')
        mailid = request.data.get('mailid')
        location = request.data.get('location')
        password = request.data.get('password')
        role = 'restaurant'

        if login.objects.filter(phonenumber=phone):
            return Response({'message': 'Phone number already exists'}, status=status.HTTP_400_BAD_REQUEST)
        else:
            serializer_login = self.serializer_class_login(data={'phonenumber': phone, 'password': password, 'role': role})

            if serializer_login.is_valid():
                # Attempt to create the login record
                login_instance = serializer_login.save()
                login_id = login_instance.id  # Get the generated login_id here

                serializer = self.serializer_class(
                    data={
                        'login_id': login_id,
                        'name': name,
                        'phonenumber': phone,
                        'mailid': mailid,
                        'location': location,
                        'password': password,
                        'role': role,
                    }
                )

                if serializer.is_valid():
                    serializer.save()
                    return Response({'data': serializer.data, 'message': 'Registration successful', 'success': True},
                                    status=status.HTTP_201_CREATED)
                else:
                    # Rollback login creation if restaurant registration fails
                    login_instance.delete()
                    print("Serializer Errors:", serializer.errors)
            else:
                print("Serializer Errors:", serializer_login.errors)
            return Response({'message': 'Registration error', 'success': False}, status=status.HTTP_400_BAD_REQUEST)


class RestaurantLoginAPI(GenericAPIView):
    serializer_class = loginUserSerializer

    def post(self, request):
        u_id = ' '
        phone = request.data.get('phone')
        password = request.data.get('password')
        print(phone)
        print(password)
        logreg = login.objects.filter(phonenumber=phone, password=password)
        if logreg.count() > 0:
            read_serializer = loginUserSerializer(logreg, many=True)

            for i in read_serializer.data:
                id = i['id']
                print(id)
                role = i['role']
                print(role)
                regdata = user.objects.all().filter(login_id=id).values()
                print(regdata, "vvgvggfgg")

                for i in regdata:
                    u_id = i['id']
                    name = i['name']
                    # l_status = i['userstatus']
                    print(u_id)

                regdata = restaurant.objects.all().filter(login_id=id).values()
                print(regdata)
                for i in regdata:
                    u_id = i['id']
                    name = i['name']
                    print(u_id)

                return Response({
                    'data': {
                        'login_id': id,
                        'username': phone,
                        'password': password,
                        'role': role,
                        'userid': u_id,
                        # 'status':l_status
                    },
                    'success': True,
                    'message': 'Logged in successfully'
                }, status=status.HTTP_200_OK)
        else:
            return Response({
                'message': 'Username not valid',
                'success': False
            }, status=status.HTTP_400_BAD_REQUEST)


class ViewAllRestaurantsAPI(GenericAPIView):
    serializer_class = RestaurantSerializer

    def get(self, request):
        restaurants = restaurant.objects.all()
        serializer = self.serializer_class(restaurants, many=True)
        return Response({'data': serializer.data, 'message': 'All restaurants data', 'success': True}, status=status.HTTP_200_OK)

class ViewSingleRestaurantAPI(GenericAPIView):
    serializer_class = RestaurantSerializer

    def get(self, request, restaurant_id):
        try:
            single_restaurant = restaurant.objects.get(pk=restaurant_id)
            serializer = self.serializer_class(single_restaurant)
            return Response({'data': serializer.data, 'message': 'Single restaurant data', 'success': True}, status=status.HTTP_200_OK)
        except restaurant.DoesNotExist:
            return Response({'message': 'Restaurant not found', 'success': False}, status=status.HTTP_404_NOT_FOUND)

class UpdateRestaurantAPI(GenericAPIView):
    serializer_class = RestaurantSerializer

    def put(self, request, restaurant_id):
        try:
            single_restaurant = restaurant.objects.get(pk=restaurant_id)
            serializer = self.serializer_class(instance=single_restaurant, data=request.data, partial=True)
            if serializer.is_valid():
                serializer.save()
                return Response({'data': serializer.data, 'message': 'Restaurant updated successfully', 'success': True}, status=status.HTTP_200_OK)
            else:
                return Response({'data': 'Restaurant update failed', 'success': False}, status=status.HTTP_400_BAD_REQUEST)
        except restaurant.DoesNotExist:
            return Response({'message': 'Restaurant not found', 'success': False}, status=status.HTTP_404_NOT_FOUND)

class DeleteRestaurantAPI(GenericAPIView):

    def delete(self, request, restaurant_id):
        try:
            single_restaurant = restaurant.objects.get(pk=restaurant_id)
            single_restaurant.delete()
            return Response({'message': 'Restaurant deleted successfully', 'success': True}, status=status.HTTP_200_OK)
        except restaurant.DoesNotExist:
            return Response({'message': 'Restaurant not found', 'success': False}, status=status.HTTP_404_NOT_FOUND)

class RestaurantSearchAPI(GenericAPIView):
    def post(self, request):
        query = request.data.get('query')
        print(query)
        # Perform the restaurant search based on the query
        restaurants = restaurant.objects.filter(name__icontains=query) | restaurant.objects.filter(phonenumber__icontains=query)
        
        # Serialize the restaurant data
        restaurant_data = [{'name': r.name, 'phonenumber': r.phonenumber} for r in restaurants]

        return Response({'data': restaurant_data, 'message': 'Restaurant search successful', 'success': True}, status=status.HTTP_200_OK)

            
class FoodCreateAPI(GenericAPIView):
    serializer_class = FoodSerializer
    serializer_class_login = loginUserSerializer

    def post(self, request):
        restaurant_name =''
        restaurant_id = request.data.get('restaurant_id')
        food_name=request.data.get('food_name')
        quantity = request.data.get('quantity')
        price = request.data.get('price')
        category = request.data.get('category')
        image = request.data.get('image')

        data = restaurant.objects.filter(id = restaurant_id).values()
        print(data)
        for i in data:
            restaurant_name = i['name']
            print(restaurant_name)


        serializer = self.serializer_class(data={
            'food_name':food_name,
            'price':price,
            'quantity':quantity,
            'category':category,
            'image':image,
            'restaurant_name':restaurant_name,
            'restaurant_id':restaurant_id})
        print(serializer)
        print(image,"sagsfgsfgfsfgsfgs")
        if(serializer.is_valid()):
            serializer.save()
            return Response({'data':serializer.data,'message':'Food added successfully','success':True},
            status=status.HTTP_201_CREATED)
        return Response({'data':serializer.data,'message':'Food adding failed','success':False},
        status=status.HTTP_400_BAD_REQUEST)


class ViewAllFoodsAPI(GenericAPIView):
    serializer_class = FoodSerializer

    def get(self, request):
        foods = food.objects.all()
        serializer = self.serializer_class(foods, many=True)
        return Response({'data': serializer.data, 'message': 'All foods data', 'success': True}, status=status.HTTP_200_OK)

class ViewSingleFoodAPI(GenericAPIView):
    serializer_class = FoodSerializer

    def get(self, request, food_id):
        try:
            single_food = food.objects.get(pk=food_id)
            serializer = self.serializer_class(single_food)
            return Response({'data': serializer.data, 'message': 'Single food data', 'success': True}, status=status.HTTP_200_OK)
        except food.DoesNotExist:
            return Response({'message': 'Food not found', 'success': False}, status=status.HTTP_404_NOT_FOUND)
        
class ViewAllRestaurantFoodsAPI(generics.ListAPIView):
    serializer_class = FoodSerializer

    def get_queryset(self):
        restaurant_id = self.kwargs['restaurant_id']
        return food.objects.filter(restaurant_id=restaurant_id)

    def list(self, request, *args, **kwargs):
        queryset = self.get_queryset()
        serializer = self.get_serializer(queryset, many=True)
        return Response({'data': serializer.data, 'message': 'All restaurant foods data', 'success': True}, status=status.HTTP_200_OK)

class UpdateFoodAPI(GenericAPIView):
    serializer_class = FoodSerializer

    def put(self, request, food_id):
        try:
            single_food = food.objects.get(pk=food_id)
            serializer = self.serializer_class(instance=single_food, data=request.data, partial=True)
            if serializer.is_valid():
                serializer.save()
                return Response({'data': serializer.data, 'message': 'Food updated successfully', 'success': True}, status=status.HTTP_200_OK)
            else:
                return Response({'data': 'Food update failed', 'success': False}, status=status.HTTP_400_BAD_REQUEST)
        except food.DoesNotExist:
            return Response({'message': 'Food not found', 'success': False}, status=status.HTTP_404_NOT_FOUND)

class FoodSearchAPI(GenericAPIView):
    serializer_class = FoodSerializer

    def post(self, request):
        query = request.data.get('query')
        print(query)
        
        # Perform the food search based on the query
        foods = food.objects.filter(food_name__icontains=query) | food.objects.filter(category__icontains=query)
        
        # Serialize the food data
        food_data = self.serializer_class(foods, many=True).data

        return Response({'data': food_data, 'message': 'Food search successful', 'success': True}, status=status.HTTP_200_OK)

class DeleteFoodAPI(GenericAPIView):

    def delete(self, request, food_id):
        try:
            single_food = food.objects.get(pk=food_id)
            single_food.delete()
            return Response({'message': 'Food deleted successfully', 'success': True}, status=status.HTTP_200_OK)
        except food.DoesNotExist:
            return Response({'message': 'Food not found', 'success': False}, status=status.HTTP_404_NOT_FOUND)
