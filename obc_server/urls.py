"""OBC_Server URL Configuration"""

from django.contrib import admin
from django.urls import include, path
from obc_server.obc_sync import views

urlpatterns = [
    path('api-auth/', include('rest_framework.urls', namespace='rest_framework')),
    path('admin/', admin.site.urls),
    path('activities/', views.ActivityList.as_view()),
    path('activities/<int:pk>/', views.ActivityDetails.as_view()),
]
