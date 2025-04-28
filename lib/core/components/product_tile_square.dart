import 'package:flutter/material.dart';

import '../constants/constants.dart';
import '../models/dummy_product_model.dart';
import '../routes/app_routes.dart';
import 'network_image.dart';
import '../../features/products/data/models/product_model.dart' as feature_product;

class ProductTileSquare extends StatelessWidget {

  const ProductTileSquare({
    super.key,
    required this.data,
  });

  final ProductModel data;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppDefaults.padding / 2),
      child: Material(
        borderRadius: AppDefaults.borderRadius,
        color: AppColors.scaffoldBackground,
        child: InkWell(
          borderRadius: AppDefaults.borderRadius,
          onTap: () => Navigator.pushNamed(
            context,
            AppRoutes.productDetails,
            arguments: data,  // aqui você passa o produto clicado
          ),
          child: Container(
            width: 176,
            height: 296,
            padding: const EdgeInsets.all(AppDefaults.padding),
            decoration: BoxDecoration(
              border: Border.all(width: 0.1, color: AppColors.placeholder),
              borderRadius: AppDefaults.borderRadius,
            ),
            child: SingleChildScrollView( // <-- aqui o scroll
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(AppDefaults.padding / 2),
                    child: AspectRatio(
                      aspectRatio: 1 / 1,
                      child: NetworkImageWithLoader(
                        data.cover,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    data.name,
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(color: Colors.black),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    data.weight,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        '\$${data.price.toInt()}',
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge
                            ?.copyWith(color: Colors.black),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '\$${data.mainPrice}',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}