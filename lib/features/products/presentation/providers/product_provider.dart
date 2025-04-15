import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';

import '../viewmodels/product_viewmodel.dart';
import '../../domain/entities/product.dart';
import '../../data/repositories/product_repository_impl.dart';
import '../../data/datasources/product_remote_datasource_impl.dart';

final dioProvider = Provider<Dio>((ref) => Dio(BaseOptions(
  baseUrl: 'http://10.0.2.2:8080/api', // Altere aqui para sua baseURL
)));

final productProvider = StateNotifierProvider<ProductViewModel, AsyncValue<List<Product>>>((ref) {
  final dio = ref.watch(dioProvider);
  final datasource = ProductRemoteDatasourceImpl(dio);
  final repository = ProductRepositoryImpl(datasource);
  return ProductViewModel(repository);
});
