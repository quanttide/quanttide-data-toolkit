from rest_framework import serializers

from datasets.models import RADataRecord, RADataSet
from .entry import RADataEntrySerializer


class RADataRecordSerializer(serializers.ModelSerializer):
    dataset_number = serializers.IntegerField(source='dataset.number')
    entries = RADataEntrySerializer(many=True, required=False)

    class Meta:
        model = RADataRecord
        exclude = ['dataset']
        read_only_fields = ['number']

    def create(self, validated_data):
        dataset_number = validated_data.pop('dataset')['number']
        parent_model_instance = RADataSet.objects.get(number=dataset_number)
        number = self.Meta.model.objects.filter(dataset__number=dataset_number).count() + 1
        validated_data['number'] = number
        return self.Meta.model.objects.create(dataset=parent_model_instance, **validated_data)
