from django.http import Http404

from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework import status

from obc_server.obc_sync.serializers import ActivitySerializer
from obc_server.obc_sync.models import Activity


class ActivityList(APIView):
    """
    List all rides, or create a new one.
    """
    def get(self, request, format=None):
        rides = Activity.objects.all()
        serializer = ActivitySerializer(rides, many=True)
        return Response(serializer.data)

    def post(self, request, format=None):
        serializer = ActivitySerializer(data=request.data)
        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data, status=status.HTTP_201_CREATED)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)


class ActivityDetails(APIView):
    """
    Retrieve, update or delete a ride instance.
    """
    def get_object(self, pk):
        try:
            return Activity.objects.get(pk=pk)
        except Activity.DoesNotExist:
            raise Http404

    def get(self, request, pk, format=None):
        ride = self.get_object(pk)
        serializer = ActivitySerializer(ride)
        return Response(serializer.data)

    def put(self, request, pk, format=None):
        ride = self.get_object(pk)
        serializer = ActivitySerializer(ride, data=request.data)
        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

    def delete(self, request, pk, format=None):
        ride = self.get_object(pk)
        ride.delete()
        return Response(status=status.HTTP_204_NO_CONTENT)
