from rest_framework import viewsets
from rest_framework_nested import viewsets as nested_viewsets

from datasets.models import RADataRecord
from datasets.serializers import RADataRecordSerializer


class RADataRecordViewSet(nested_viewsets.NestedViewSetMixin, viewsets.ModelViewSet):
    queryset = RADataRecord.objects.all()
    serializer_class = RADataRecordSerializer
    lookup_field = 'number'
    parent_lookup_kwargs = {
        'dataset_number': 'dataset__number'  # Map project_name to project__name
    }
