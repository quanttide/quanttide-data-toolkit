import uuid

from django.db import models


class RADataSet(models.Model):
    id = models.UUIDField(primary_key=True, default=uuid.uuid4, editable=False, verbose_name='助研数据集ID')
    number = models.IntegerField(unique=True, verbose_name='助研数据集编号')
    title = models.CharField(max_length=100, verbose_name='助研数据集标题')
    description = models.TextField(verbose_name='助研数据集描述')
    created_at = models.DateTimeField(auto_now_add=True, verbose_name='创建时间')
    updated_at = models.DateTimeField(auto_now=True, verbose_name='更新时间')

    class Meta:
        verbose_name = '助研数据集'
