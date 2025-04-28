import 'package:flutter/material.dart';

import '../../core/components/app_back_button.dart';
import '../../core/components/product_tile_square.dart';
import '../../core/constants/constants.dart';

import 'package:grocery/features/products/data/models/product_model.dart' as data_model;
import 'package:grocery/core/models/dummy_product_model.dart' as core_model;

import 'package:grocery/features/products/data/services/product_service.dart';

class CategoryProductPage extends StatefulWidget {
  final int? categoryId; // recebe categoryId opcional

  const CategoryProductPage({super.key, this.categoryId});

  static const categoryNames = {
    1: 'Vegetables',
    2: 'Meat And Fish',
    3: 'Medicine',
    4: 'Baby Care',
    5: 'Office Supplies',
    6: 'Beauty',
    7: 'Gym Equipment',
    8: 'Gardening Tools',
    9: 'Pet Care',
    10: 'Eye Wears',
    11: 'Pack',
    12: 'Others',
  };

  @override
  State<CategoryProductPage> createState() => _CategoryProductPageState();
}

class _CategoryProductPageState extends State<CategoryProductPage> {
  final ProductService _productService = ProductService();

  List<data_model.ProductModel> products = [];
  bool loading = true;
  late int categoryId;

  @override
  void initState() {
    super.initState();

    // Recebe categoryId do widget (pode ser null, então define default)
    categoryId = widget.categoryId ?? 1;

    loadProducts();
  }

  Future<void> loadProducts() async {
    setState(() {
      loading = true;
    });

    try {
      final fetchedProducts = await _productService.fetchProducts(categoryId: categoryId);

      setState(() {
        products = fetchedProducts;
        loading = false;
      });
    } catch (e) {
      print('Erro ao carregar produtos: $e');
      setState(() {
        loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final categoryName = CategoryProductPage.categoryNames[categoryId] ?? 'Category';

    final coreModelProducts = products.map((p) => core_model.ProductModel(
      id: p.id,
      name: p.name,
      weight: '',
      cover: p.imageUrl,   // corrigido aqui, sem aspas
      images: [p.imageUrl],
      price: p.price,
      mainPrice: p.price,
    )).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(categoryName),
        leading: const AppBackButton(),
      ),
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : coreModelProducts.isEmpty
          ? const Center(child: Text('No products found in this category'))
          : SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: GridView.builder(
            padding: const EdgeInsets.only(top: AppDefaults.padding),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 16,
              childAspectRatio: 0.85,
            ),
            itemCount: coreModelProducts.length,
            itemBuilder: (context, index) {
              final product = coreModelProducts[index];
              return ProductTileSquare(data: product);
            },
          ),
        ),
      ),
    );
  }
}
