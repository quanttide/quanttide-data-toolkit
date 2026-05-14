from django.urls import path, include
from rest_framework_nested import routers

from datasets.views import RADataSetViewSet, RADataRecordViewSet, RADataEntryViewSet


app_name = 'datasets'

router = routers.DefaultRouter()
router.register(r'datasets', RADataSetViewSet, basename='dataset')

dataset_router = routers.NestedDefaultRouter(router, r'datasets', lookup='dataset')
dataset_router.register(r'records', RADataRecordViewSet, basename='record')

record_router = routers.NestedDefaultRouter(dataset_router, r'records', lookup='record')
record_router.register(r'entries', RADataEntryViewSet, basename='entry')

urlpatterns = [
    path('', include(router.urls)),
    path('', include(dataset_router.urls)),
    path('', include(record_router.urls)),
]
