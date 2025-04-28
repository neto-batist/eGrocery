import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';

import '../viewmodels/product_viewmodel.dart';
import '../../domain/entities/product.dart';
import '../../data/repositories/product_repository_impl.dart';
import '../../data/datasources/product_remote_datasource_impl.dart';

// Provider para o Dio
final dioProvider = Provider<Dio>((ref) => Dio(BaseOptions(
  baseUrl: 'http://192.168.18.151:8080/api', // <-- aqui atualizado!
)));

// Provider para o ProductRepository
final productRepositoryProvider = Provider<ProductRepositoryImpl>((ref) {
  final dio = ref.watch(dioProvider);
  final datasource = ProductRemoteDatasourceImpl(dio);
  return ProductRepositoryImpl(datasource);
});

// Provider para o ProductViewModel (agora usa categoryId dinâmico)
final productProvider = StateNotifierProvider.family<ProductViewModel, AsyncValue<List<Product>>, int>(
      (ref, categoryId) {
    final repository = ref.watch(productRepositoryProvider);
    return ProductViewModel(repository, categoryId);
  },
);
