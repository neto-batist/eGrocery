import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/product.dart';
import '../../domain/repositories/product_repository.dart';

class ProductViewModel extends StateNotifier<AsyncValue<List<Product>>> {
  final ProductRepository repository;
  final int categoryId;

  ProductViewModel(this.repository, this.categoryId)
      : super(const AsyncValue.loading()) {
    fetchProducts();
  }

  Future<void> fetchProducts() async {
    try {
      final products = await repository.getProductsByCategory(categoryId);
      state = AsyncValue.data(products);
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }
}
