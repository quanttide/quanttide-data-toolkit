from rest_framework import viewsets
from datasets.models import RADataSet
from datasets.serializers import RADataSetSerializer


class RADataSetViewSet(viewsets.ModelViewSet):
    queryset = RADataSet.objects.all()
    serializer_class = RADataSetSerializer
    lookup_field = 'number'
