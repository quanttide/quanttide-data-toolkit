from rest_framework import serializers

from datasets.models import RADataEntry, RADataRecord


class RADataEntrySerializer(serializers.ModelSerializer):
    dataset_number = serializers.IntegerField(source='record.dataset.number')
    record_number = serializers.IntegerField(source='record.number')

    class Meta:
        model = RADataEntry
        exclude = ['record']
        read_only_fields = ['number']

    def create(self, validated_data):
        # 获取编号
        record_data = validated_data.pop('record')
        record_number = record_data['number']
        dataset_number = record_data.pop('dataset')['number']
        # record对象
        parent_model_instance = RADataRecord.objects.get(dataset__number=dataset_number, number=record_number)
        # 增加编号
        number = self.Meta.model.objects.filter(record__dataset__number=dataset_number, record__number=record_number).count() + 1
        validated_data['number'] = number
        return self.Meta.model.objects.create(record=parent_model_instance, **validated_data)
