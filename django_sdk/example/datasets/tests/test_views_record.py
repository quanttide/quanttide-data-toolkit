from rest_framework.test import APITestCase
from rest_framework import status
from django.urls import reverse

from datasets.models import RADataRecord


class RADataRecordTestCase(APITestCase):
    router_basename = 'record'
    fixtures = ['set.json', 'record.json', 'member.json']

    @classmethod
    def setUpTestData(cls):
        cls.record = RADataRecord.objects.get(number=1, dataset__number=1)
        # URL
        cls.list_url = reverse(f'datasets:{cls.router_basename}-list', kwargs={'dataset_number': cls.record.dataset.number})
        cls.detail_url = reverse(f'datasets:{cls.router_basename}-detail',
                                  kwargs={'dataset_number': cls.record.dataset.number, 'number': cls.record.number})

    def test_list(self):
        response = self.client.get(self.list_url, format='json')
        self.assertEqual(response.status_code, status.HTTP_200_OK)
        self.assertEqual(len(response.data), 1)
