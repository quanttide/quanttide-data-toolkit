from rest_framework.test import APITestCase
from rest_framework import status
from django.urls import reverse

from datasets.models import RADataSet


class RADataSetTestCase(APITestCase):
    # general
    fixtures = ['set.json']
    # viewset
    model_class = RADataSet
    app_name = 'datasets'
    basename = 'dataset'
    lookups = {'number': 1}

    @classmethod
    def setUpTestData(cls):
        cls.model_instance = cls.model_class.objects.get(**cls.lookups)
        cls.list_url = reverse(f'{cls.app_name}:{cls.basename}-list')
        cls.detail_url = reverse(f'{cls.app_name}:{cls.basename}-detail', kwargs=cls.lookups)

    def test_list(self):
        response = self.client.get(self.list_url, format='json')
        self.assertEqual(response.status_code, status.HTTP_200_OK)
        self.assertEqual(len(response.data), 2)

    def test_retrieve(self):
        pass
