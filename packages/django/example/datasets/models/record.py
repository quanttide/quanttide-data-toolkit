import uuid

from django.db import models

from .set import RADataSet


class RADataRecord(models.Model):
    id = models.UUIDField(primary_key=True, default=uuid.uuid4, editable=False, verbose_name='助研数据ID')
    number = models.IntegerField(unique=True, verbose_name='助研数据编号')
    dataset = models.ForeignKey(RADataSet, on_delete=models.CASCADE, verbose_name='关联数据集', related_name='entries')
    created_at = models.DateTimeField(auto_now_add=True, verbose_name='创建时间')
    updated_at = models.DateTimeField(auto_now=True, verbose_name='更新时间')

    class Meta:
        verbose_name = '助研数据'
