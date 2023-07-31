"""
处理器框架
"""
import abc


class BaseProcessor(abc.ABC):
    """
    处理器基类
    """
    def read(self, *args, **kwargs):
        raise NotImplementedError()

    def process(self, *args, **kwargs):
        raise NotImplementedError()

    def save(self, *args, **kwargs):
        raise NotImplementedError()

    def run(self, *args, **kwargs):
        raise NotImplementedError()


class Processor(BaseProcessor):
    """
    处理器
    """
    def read_from_file(self):
        pass

    def save_to_file(self):
        pass

    def save_to_sql(self):
        pass

