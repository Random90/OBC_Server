from django.db import models


class Activity(models.Model):
    added = models.DateTimeField(auto_now_add=True)
    circumference = models.IntegerField('size of the wheel with tire')
    rotations = models.IntegerField()
    rideTime = models.IntegerField('total ride time in miliseconds')
    user = models.ForeignKey(
        'auth.User',
        related_name='activities',
        on_delete=models.CASCADE
    )

    class Meta:
        ordering = ['added']
