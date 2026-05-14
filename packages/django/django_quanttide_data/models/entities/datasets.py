"""
数据集模型
"""

from django_quanttide import models as quanttide_models


class BaseDataSet(quanttide_models.Model):
    created_at = quanttide_models.CreatedAtField()
    updated_at = quanttide_models.UpdatedAtField()
    name = quanttide_models.NameField()
    verbose_name = quanttide_models.VerboseNameField()
    readme = quanttide_models.ReadmeField()

    class Meta:
        abstract = True
        verbose_name = '数据集'
        verbose_name_plural = '数据集列表'


class BaseDataSchema(quanttide_models.Model):
    created_at = quanttide_models.CreatedAtField()
    updated_at = quanttide_models.UpdatedAtField()

    class Meta:
        abstract = True
        verbose_name = '数据模型'
        verbose_name_plural = '数据模型列表'


class BaseDataRecord(quanttide_models.Model):
    created_at = quanttide_models.CreatedAtField()
    updated_at = quanttide_models.UpdatedAtField()

    class Meta:
        abstract = True
        verbose_name = '数据记录'
        verbose_name_plural = '数据记录列表'
