from django.test import TestCase

from datasets.models import RADataEntry
from datasets.serializers import RADataEntrySerializer


class RADataRecordSerializerTestCase(TestCase):
    fixtures = ['set.json', 'record.json', 'entry.json', 'member.json']
    serializer_class = RADataEntrySerializer

    @classmethod
    def setUpTestData(cls):
        cls.instance = RADataEntry.objects.get(number=1, record__number=1, record__dataset__number=1)

    def test_serialize(self):
        serializer = RADataEntrySerializer(instance=self.instance)
        print(serializer.data)

    def test_create(self):
        task_data = {
            'dataset_number': 1,
            'record_number': 1,
            # 'member': '39d6a1e6-e500-46c1-a6ed-acfcc6c485f6',
            'key': 'marked',
            'value': {'has_activities': True}
        }
        serializer = self.serializer_class(data=task_data)
        self.assertTrue(serializer.is_valid(raise_exception=True))
        serializer.save()
