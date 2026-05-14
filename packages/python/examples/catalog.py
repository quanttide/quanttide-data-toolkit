import uuid
from typing import List, Optional

from pydantic import BaseModel

class DataSpace(BaseModel):
    id:uuid.UUID
    name: str

class DataDirectory(BaseModel):
    id:uuid.UUID
    name: str
    filename: str
    description: Optional[str] = None
    label:Optional[str] = None
    confidentiality_level:Optional[str] = None
    data_space:DataSpace

class DataProcessor(BaseModel):
    id:uuid.UUID
    name:str
    url:Optional[str] = None
    reference_file:Optional[str] = None
    data_space:DataSpace

class DataSet(BaseModel):
    id:uuid.UUID
    name:str
    filename:str
    data_space:DataSpace

class DataDocuments(BaseModel):
    id:uuid.UUID
    title:str
    filename:str
    data_space:DataSpace

class Catalog(BaseModel):
    id:uuid.UUID
    name: str
    description: str
    all_data_spaces:List[DataSpace]
    all_data_directory:List[DataDirectory]
    all_data_processors:List[DataProcessor]
    all_data_sets:List[DataSet]
    all_data_documents:List[DataDocuments]

if __name__ == '__main__':
    # 创建 DataSpace 实例
    data_space1 = DataSpace(id=uuid.uuid4(), name="space1")
    data_space2 = DataSpace(id=uuid.uuid4(), name="space2")
    data_space3 = DataSpace(id=uuid.uuid4(), name="space3")

    # 创建 DataDirectory 实例
    data_directory1 = DataDirectory(
        id=uuid.uuid4(),
        name="Directory A",
        filename="file1.json",
        description="123123..",
        label="label1",
        confidentiality_level="",
        data_space=data_space2
    )

    # 创建 DataProcessor 实例
    data_processor1 = DataProcessor(
        id=uuid.uuid4(),
        name="processor1",
        url="",
        reference_filename="",
        data_space=data_space3
    )

    # 创建 DataSet 实例
    data_set1 = DataSet(
        id=uuid.uuid4(),
        name="dataset1.csv.rar",
        filename="dataset1.csv.rar",
        data_space=data_space2
    )

    # 创建 DataDocuments 实例
    data_document1 = DataDocuments(
        id=uuid.uuid4(),
        title="title1",
        filename="file1.json",
        data_space=data_space1
    )

    # 创建 Catalog 实例
    catalog1 = Catalog(
        id=uuid.uuid4(),
        name="catalog1",
        description="",
        all_data_spaces=[data_space1, data_space2,data_space3],
        all_data_directory=[data_directory1],
        all_data_processors=[data_processor1],
        all_data_sets=[data_set1],
        all_data_documents=[data_document1]
    )

    # 打印实例
    print(catalog1)