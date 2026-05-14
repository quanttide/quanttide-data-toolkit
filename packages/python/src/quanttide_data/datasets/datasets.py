"""
数据集
"""

import uuid

from pydantic import BaseModel, constr


class Dataset(BaseModel):
    """
    数据集领域模型
    """
    id: uuid.UUID
    name: constr(regex=r'^[a-z0-9]+(?:-[a-z0-9]+)*$')  # 使用slug格式的字符串
    verbose_name: str
    readme: str
