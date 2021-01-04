from django.db import models


class RideParams(models.Model):
    added = models.DateTimeField(auto_now_add=True)
    circumference = models.IntegerField('size of the wheel with tire')
    rotations = models.IntegerField()
    rideTime = models.IntegerField('total ride time in miliseconds')

    class Meta:
        ordering = ['added']
