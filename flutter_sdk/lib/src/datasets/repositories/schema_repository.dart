import 'dart:async';

import '../schemas/schema.dart';
import 'package:flutter_quanttide/flutter_quanttide.dart';


class DataSchemaRepository {
  final ApiClient apiClient;

  DataSchemaRepository({required this.apiClient});

  Future<List<DataSchema>> list() async {
    try {
      // Make API call to fetch data schemas
      final data = await apiClient.request(httpMethod: 'GET', apiPath: '/schemas') as  List<Map<String, dynamic>>;

      // Convert API response to a list of DataSchema objects
      final List<DataSchema> dataSchemas = (data).map((item) => DataSchema.fromJson(item)).toList();

      return dataSchemas;
    } catch (e) {
      throw Exception('Failed to list data schemas: $e');
    }
  }

  Future<DataSchema> retrieve(String name) async {
    try {
      // Make API call to fetch data schema by ID
      final data = await apiClient.request(httpMethod: 'GET', apiPath: '/schemas/$name') as Map<String, dynamic>;

      // Convert API response to a DataSchema object
      final DataSchema dataSchema = DataSchema.fromJson(data);

      return dataSchema;
    } catch (e) {
      throw Exception('Failed to fetch data schema: $e');
    }
  }

  Future<void> create(DataSchema dataSchema) async {
    try {
      // Make API call to save data schema
      await apiClient.request(httpMethod: 'POST', apiPath: '/schemas', data: dataSchema.toJson()) as Map<String, dynamic>;
    } catch (e) {
      throw Exception('Failed to save data schema: $e');
    }
  }

  Future<void> update(String name, DataSchema dataSchema) async {
    try {
      // Make API call to update data schema by ID
      await apiClient.request(httpMethod: 'PUT', apiPath: '/schemas/$name', data: dataSchema.toJson()) as Map<String, dynamic>;
    }
    catch (e) {
      throw Exception('Failed to update data schema: $e');
    }
  }

  Future<void> delete(String name) async {
    try {
      // Make API call to delete data schema by ID
      await apiClient.request(httpMethod: 'DELETE', apiPath: '/schemas/$name');
    } catch (e) {
      throw Exception('Failed to delete data schema: $e');
    }
  }
}
