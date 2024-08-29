import 'package:get/get.dart';

class ProductController extends GetxController {
  var products = <dynamic>[].obs;
  var offset = 0.obs;
  final int limit = 10;
  var isLoading = false.obs;

  @override
  void onInit() {
    fetchProducts();
    super.onInit();
  }

  Future<void> fetchProducts() async {
    if (isLoading.value) return;
    isLoading.value = true;

    try {
      await Future.delayed(const Duration(seconds: 2));

      List<dynamic> newProducts = List.generate(
          limit, (index) => 'Produto ${(offset.value + index + 1)}');

      products.addAll(newProducts);
      offset.value += limit;
    } catch (e) {
      print('Erro ao carregar produtos $e');
    } finally {
      isLoading.value = false;
    }
  }
}
