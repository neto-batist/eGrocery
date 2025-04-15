import 'package:dio/dio.dart';
import 'package:grocery/features/products/domain/entities/product.dart';
import '../models/product_model.dart';
import 'product_remote_datasource.dart';

class ProductRemoteDatasourceImpl implements ProductRemoteDatasource {
  final Dio _dio;

  ProductRemoteDatasourceImpl(this._dio);

  @override
  Future<List<ProductModel>> getProducts() async {
    try {
      final response = await _dio.get('/products');

      if (response.statusCode == 200) {
        final List data = response.data['content']; // <- Aqui está a correção
        return data.map((json) => ProductModel.fromJson(json)).toList();
      } else {
        throw Exception('Erro ao buscar produtos: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Erro ao buscar produtos: $e');
    }
  }

  @override
  Future<List<Product>> fetchProducts() async {
    try {
      final productModels = await getProducts();

      return productModels.map((model) => model.toEntity()).toList();
    } catch (e) {
      throw Exception('Erro ao buscar entidades de produtos: $e');
    }
  }
}
