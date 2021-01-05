from django.contrib.auth.models import User, Group
from rest_framework import serializers
from obc_server.obc_sync.models import Activity


class UserSerializer(serializers.HyperlinkedModelSerializer):
    # rides = serializers.PrimaryKeyRelatedField(
    #     many=True,
    #     queryset=Activity.objects.all()
    # )

    class Meta:
        model = User
    #    fields = ['url', 'username', 'email', 'groups', 'rides']
        fields = ['url', 'username', 'email', 'groups']


class GroupSerializer(serializers.HyperlinkedModelSerializer):
    class Meta:
        model = Group
        fields = ['url', 'name']


class ActivitySerializer(serializers.ModelSerializer):
    class Meta:
        model = Activity
        fields = ['id', 'added', 'circumference', 'rotations', 'rideTime']
