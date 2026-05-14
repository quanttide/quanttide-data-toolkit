from rest_framework import serializers

from datasets.models import RADataSet


class RADataSetSerializer(serializers.ModelSerializer):
    class Meta:
        model = RADataSet
        fields = '__all__'
