import pytest
import uuid
from pydantic import ValidationError

from quanttide_data.datasets import Dataset

def test_dataset_creation():
    id = uuid.uuid4()
    name = "my_dataset"
    verbose_name = "My Dataset"
    readme = "This is the readme for my dataset"

    dataset = Dataset(id=id, name=name, verbose_name=verbose_name, readme=readme)

    assert dataset.id == id
    assert dataset.name == name
    assert dataset.verbose_name == verbose_name
    assert dataset.readme == readme

def test_invalid_name():
    id = uuid.uuid4()
    name = "Invalid Name!"
    verbose_name = "My Dataset"
    readme = "This is the readme for my dataset"

    with pytest.raises(ValidationError):
        dataset = Dataset(id=id, name=name, verbose_name=verbose_name, readme=readme)

def test_missing_fields():
    with pytest.raises(ValidationError):
        dataset = Dataset(id=uuid.uuid4(), verbose_name="My Dataset", readme="This is the readme for my dataset")
