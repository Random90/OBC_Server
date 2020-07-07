from django.contrib.auth.models import User, Group
from rest_framework import serializers
from obc_server.obc_sync.models import RideParams

class UserSerializer(serializers.HyperlinkedModelSerializer):
    class Meta:
        model = User
        fields = ['url', 'username', 'email', 'groups']


class GroupSerializer(serializers.HyperlinkedModelSerializer):
    class Meta:
        model = Group
        fields = ['url', 'name']


class RideParamsSerializer(serializers.ModelSerializer):
    class Meta:
        model = RideParams
        fields = ['id', 'added', 'circumference', 'rotations', 'rideTime']