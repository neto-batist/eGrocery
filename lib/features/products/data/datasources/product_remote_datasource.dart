import 'package:grocery/features/products/domain/entities/product.dart';

import '../models/product_model.dart';

abstract class ProductRemoteDatasource {
  Future<List<ProductModel>> getProducts();
  Future<List<Product>> fetchProducts();
}
