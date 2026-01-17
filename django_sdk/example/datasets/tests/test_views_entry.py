from rest_framework.test import APITestCase
from rest_framework import status
from django.urls import reverse

from datasets.models import RADataEntry


class RADataEntryTestCase(APITestCase):
    router_basename = 'entry'
    fixtures = ['set.json', 'record.json', 'entry.json', 'member.json']

    @classmethod
    def setUpTestData(cls):
        cls.entry = RADataEntry.objects.get(number=1, record__number=1, record__dataset__number=1)
        # URL
        cls.list_url = reverse(f'datasets:{cls.router_basename}-list', kwargs={
            'dataset_number': cls.entry.record.dataset.number,
            'record_number': cls.entry.record.number,
        })
        cls.detail_url = reverse(f'datasets:{cls.router_basename}-detail',kwargs={
            'dataset_number': cls.entry.record.dataset.number,
            'record_number': cls.entry.record.number,
            'number': cls.entry.number
        })

    def test_list(self):
        response = self.client.get(self.list_url, format='json')
        self.assertEqual(response.status_code, status.HTTP_200_OK)
        self.assertEqual(len(response.data), 2)
