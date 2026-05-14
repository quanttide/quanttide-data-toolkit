import 'dart:async';

import '../schemas/record.dart';
import 'package:flutter_quanttide/flutter_quanttide.dart';


class DataRecordRepository {
  final ApiClient apiClient;

  DataRecordRepository({required this.apiClient});

  Future<List<DataRecord>> listDataRecords() async {
    try {
      // Make API call to fetch data records
      final data = await apiClient.request(httpMethod: 'GET', apiPath: '/records');

      // Convert API response to a list of DataRecord objects
      final List<DataRecord> dataRecords = (data).map((item) => DataRecord.fromJson(item)).toList();

      return dataRecords;
    } catch (e) {
      throw Exception('Failed to list data records: $e');
    }
  }

  Future<DataRecord> retrieveDataRecord(String id) async {
    try {
      // Make API call to fetch data record by ID
      final data = await apiClient.request(httpMethod: 'GET', apiPath: '/records/$id');

      // Convert API response to a DataRecord object
      final DataRecord dataRecord = DataRecord.fromJson(data);

      return dataRecord;
    } catch (e) {
      throw Exception('Failed to fetch data record: $e');
    }
  }

  Future<void> createDataRecord(DataRecord dataRecord) async {
    try {
      // Convert DataRecord object to JSON
      final jsonData = dataRecord.toJson();

      // Make API call to save data record
      await apiClient.request(httpMethod: 'POST', apiPath: '/records', data: jsonData);
    } catch (e) {
      throw Exception('Failed to save data record: $e');
    }
  }

  Future<void> deleteDataRecord(String id) async {
    try {
      // Make API call to delete data record by ID
      await apiClient.request(httpMethod: 'DELETE', apiPath: '/records/$id');
    } catch (e) {
      throw Exception('Failed to delete data record: $e');
    }
  }
}
