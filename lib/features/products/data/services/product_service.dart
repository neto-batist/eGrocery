import 'package:dio/dio.dart';
import 'package:grocery/features/products/data/models/product_model.dart';

class ProductService {
  final Dio dioClient;

  ProductService({Dio? dioClient}) : dioClient = dioClient ?? Dio();

  Future<List<ProductModel>> fetchProducts({int? categoryId}) async {
    try {
      final response = await dioClient.get(
        'http://192.168.18.151:8080/api/products',
        queryParameters: {
          if (categoryId != null) 'categoryId': categoryId,
        },
      );

      final List<dynamic> content = response.data['content'];
      return content.map((json) => ProductModel.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Erro ao buscar produtos: $e');
    }
  }
}