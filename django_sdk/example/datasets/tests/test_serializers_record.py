from django.test import TestCase

from datasets.models import RADataRecord
from datasets.serializers import RADataRecordSerializer


class RADataRecordSerializerTestCase(TestCase):
    fixtures = ['set.json', 'record.json', 'member.json']
    serializer_class = RADataRecordSerializer

    @classmethod
    def setUpTestData(cls):
        cls.instance = RADataRecord.objects.get(number=1, dataset__number=1)

    def test_serialize(self):
        serializer = RADataRecordSerializer(instance=self.instance)
        print(serializer.data)

    def test_create(self):
        task_data = {'dataset_number': 1}
        serializer = self.serializer_class(data=task_data)
        self.assertTrue(serializer.is_valid(raise_exception=True))
        serializer.save()
