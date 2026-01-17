from rest_framework import viewsets
from rest_framework_nested import viewsets as nested_viewsets

from datasets.models import RADataEntry
from datasets.serializers import RADataEntrySerializer


class RADataEntryViewSet(nested_viewsets.NestedViewSetMixin, viewsets.ModelViewSet):
    queryset = RADataEntry.objects.all()
    serializer_class = RADataEntrySerializer
    lookup_field = 'number'
    parent_lookup_kwargs = {
        'dataset_number': 'record__dataset__number',
        'record_number': 'record__number',
    }
