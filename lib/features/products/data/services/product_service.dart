import 'package:dio/dio.dart';
import 'package:grocery/features/products/data/models/product_model.dart';

class ProductService {
  final Dio dioClient;

  ProductService({Dio? dioClient}) : dioClient = dioClient ?? Dio();

  Future<List<ProductModel>> fetchProducts() async {
    try {
      final response = await dioClient.get('http://10.0.2.2:8080/api/products');

      final List<dynamic> content = response.data['content'];

      // Faz o parse corretamente
      return content.map((json) => ProductModel.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Erro ao buscar produtos: $e');
    }
  }
}
