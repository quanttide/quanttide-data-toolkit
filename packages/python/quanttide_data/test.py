import unittest

from quanttide_data.crawlers import BaseCrawler
from quanttide_data.processors import BaseProcessor


class TestCase(unittest.TestCase):
    def setUp(self):
        pass

    def tearDown(self):
        pass


class CrawlerTestCase(TestCase):
    crawler_class: BaseCrawler = BaseCrawler

    def setUp(self):
        super().setUp()

    def tearDown(self):
        super().tearDown()


class ProcessorTestCase(TestCase):
    processor_class: BaseProcessor = BaseProcessor

    def setUp(self):
        super().setUp()

    def tearDown(self):
        super().tearDown()
