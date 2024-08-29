import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pagination/product_controller.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: ProductGridScreen(),
    );
  }
}

class ProductGridScreen extends StatelessWidget {
  final ProductController productController = Get.put(ProductController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Produtos'),
      ),
      body: Obx(() {
        if (productController.products.isEmpty &&
            productController.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return NotificationListener<ScrollNotification>(
            onNotification: (ScrollNotification scrollInfo) {
              if (!productController.isLoading.value &&
                  scrollInfo.metrics.pixels >=
                      scrollInfo.metrics.maxScrollExtent - 100) {
                productController.fetchProducts();
              }
              return true;
            },
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 3 / 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: productController.products.length +
                    (productController.isLoading.value ? 1 : 0),
                itemBuilder: (ctx, index) {
                  if (index < productController.products.length) {
                    return GridTile(
                      child: Container(
                        alignment: Alignment.center,
                        color: Colors.blueAccent,
                        child: Text(productController.products[index]),
                      ),
                    );
                  } else {
                    // Centralizando o CircularProgressIndicator
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            ),
          );
        }
      }),
    );
  }
}
