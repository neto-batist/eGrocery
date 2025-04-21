import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';

import '../viewmodels/product_viewmodel.dart';
import '../../domain/entities/product.dart';
import '../../data/repositories/product_repository_impl.dart';
import '../../data/datasources/product_remote_datasource_impl.dart';

// Provider para o Dio
final dioProvider = Provider<Dio>((ref) => Dio(BaseOptions(
  baseUrl: 'http://10.0.2.2:8080/api',
)));

// Provider para o ProductRepository
final productRepositoryProvider = Provider<ProductRepositoryImpl>((ref) {
  final dio = ref.watch(dioProvider);
  final datasource = ProductRemoteDatasourceImpl(dio);
  return ProductRepositoryImpl(datasource);
});

// ID fixo da categoria (por exemplo: 3)
const fixedCategoryId = 1;

// Provider para o ProductViewModel com categoryId fixo
final productProvider = StateNotifierProvider<ProductViewModel, AsyncValue<List<Product>>>((ref) {
  final repository = ref.watch(productRepositoryProvider);
  return ProductViewModel(repository, fixedCategoryId);
});
