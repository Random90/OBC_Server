from rest_framework import serializers
from obc_server.obc_sync.models import Activity


class ActivitySerializer(serializers.ModelSerializer):

    class Meta:
        model = Activity
        fields = ['id', 'added', 'circumference', 'rotations', 'rideTime']
