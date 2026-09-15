import 'package:flutter/material.dart';
import 'package:machine_test_tinos_software/screens/cart_screen.dart';
import 'package:machine_test_tinos_software/screens/product_detailscreen.dart';
import 'package:provider/provider.dart';
import '../providers/product_provider.dart';

import '../widgets/product_card.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final searchController = TextEditingController();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        context.read<ProductProvider>().getProducts();
      }
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    int columns = 2;

    if (width > 900) {
      columns = 4;
    } else if (width > 600) {
      columns = 3;
    }

    return Scaffold(
      backgroundColor: const Color(0xfff4f6fc),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.menu,
            color: Color(0xffe81745),
          ),
        ),
        titleSpacing: 0,
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Hello, Alex!',
              style: TextStyle(
                fontSize: 10,
                color: Colors.grey,
              ),
            ),
            Text(
              'ShopEase',
              style: TextStyle(
                color: Color(0xffe81745),
                fontWeight: FontWeight.bold,
                fontSize: 17,
              ),
            ),
          ],
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 15),
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.grey[200],
            ),
            child: const Icon(
              Icons.person,
              size: 21,
              color: Colors.grey,
            ),
          ),
        ],
      ),
      body: Consumer<ProductProvider>(
        builder: (context, productProvider, child) {
          return RefreshIndicator(
            onRefresh: productProvider.getProducts,
            child: ListView(
              padding: const EdgeInsets.fromLTRB(
                16,
                14,
                16,
                30,
              ),
              children: [
                TextField(
                  controller: searchController,
                  onChanged: productProvider.searchProducts,
                  decoration: InputDecoration(
                    hintText: 'Search for products...',
                    hintStyle: const TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                    prefixIcon: const Icon(
                      Icons.search,
                      size: 21,
                    ),
                    filled: true,
                    fillColor: const Color(0xffeaf0fc),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(13),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  height: 42,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: productProvider.categories.length,
                    itemBuilder: (context, index) {
                      final category =
                          productProvider.categories[index];

                      return GestureDetector(
                        onTap: () {
                          productProvider.filterByCategory(category);
                        },
                        child: Container(
                          margin: const EdgeInsets.only(right: 9),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 17,
                          ),
                          decoration: BoxDecoration(
                            color:
                                productProvider.selectedCategory ==
                                        category
                                    ? const Color(0xffe81745)
                                    : Colors.white,
                            borderRadius: BorderRadius.circular(21),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.shopping_bag_outlined,
                                size: 15,
                                color:
                                    productProvider.selectedCategory ==
                                            category
                                        ? Colors.white
                                        : Colors.grey[700],
                              ),
                              const SizedBox(width: 6),
                              Text(
                                category,
                                style: TextStyle(
                                  fontSize: 12,
                                  color:
                                      productProvider.selectedCategory ==
                                              category
                                          ? Colors.white
                                          : Colors.black,
                                  fontWeight:
                                      productProvider.selectedCategory ==
                                              category
                                          ? FontWeight.bold
                                          : FontWeight.normal,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 17),
                Container(
                  height: 160,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: const Color(0xffb90035),
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment:
                              CrossAxisAlignment.start,
                          mainAxisAlignment:
                              MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Text(
                              '20% OFF',
                              maxLines: 1,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 2),
                            const Text(
                              'First Order',
                              maxLines: 1,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 5),
                            const Text(
                              'Use code SHOP20',
                              maxLines: 1,
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 10,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 9,
                                vertical: 5,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.circular(7),
                              ),
                              child: const Text(
                                'Shop Now',
                                style: TextStyle(
                                  color: Color(0xffb90035),
                                  fontSize: 9,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 10),
                      SizedBox(
                        width: 92,
                        height: 92,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(14),
                          child: productProvider.products.isNotEmpty
                              ? Image.network(
                                  productProvider
                                      .products
                                      .first
                                      .image,
                                  fit: BoxFit.cover,
                                  errorBuilder:
                                      (context, error, stackTrace) {
                                    return Container(
                                      color:
                                          Colors.white.withOpacity(0.12),
                                      child: const Icon(
                                        Icons.shopping_bag,
                                        color: Colors.white,
                                        size: 40,
                                      ),
                                    );
                                  },
                                )
                              : Container(
                                  color:
                                      Colors.white.withOpacity(0.12),
                                  child: const Icon(
                                    Icons.shopping_bag,
                                    color: Colors.white,
                                    size: 40,
                                  ),
                                ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 23),
                Row(
                  mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Popular Products',
                      style: TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff172033),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        productProvider.filterByCategory('All');
                      },
                      child: const Text(
                        'See All',
                        style: TextStyle(
                          color: Color(0xffe81745),
                          fontSize: 11,
                        ),
                      ),
                    ),
                  ],
                ),
                if (productProvider.loading)
                  const Padding(
                    padding: EdgeInsets.all(45),
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  )
                else if (productProvider.filteredProducts.isEmpty)
                  const Padding(
                    padding: EdgeInsets.all(45),
                    child: Center(
                      child: Text('No products found'),
                    ),
                  )
                else
                  GridView.builder(
                    shrinkWrap: true,
                    physics:
                        const NeverScrollableScrollPhysics(),
                    itemCount:
                        productProvider.filteredProducts.length,
                    gridDelegate:
                        SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: columns,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      childAspectRatio: 0.70,
                    ),
                    itemBuilder: (context, index) {
                      final product =
                          productProvider.filteredProducts[index];

                      return ProductCard(
                        product: product,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) =>
                                  ProductDetailsScreen(
                                product: product,
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: SafeArea(
        top: false,
        child: Container(
          height: 68,
          color: Colors.white,
          child: Row(
            mainAxisAlignment:
                MainAxisAlignment.spaceAround,
            children: [
            _bottomItem(
  Icons.home_outlined,
  'Home',
  true,
  null,
),
_bottomItem(
  Icons.search,
  'Search',
  false,
  () {
    FocusScope.of(context).requestFocus();
  },
),
_bottomItem(
  Icons.shopping_cart_outlined,
  'Cart',
  false,
  () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const CartScreen(),
      ),
    );
  },
),
_bottomItem(
  Icons.person_outline,
  'Profile',
  false,
  null,
),
            ],
          ),
        ),
      ),
    );
  }

 Widget _bottomItem(
  IconData icon,
  String title,
  bool selected,
  VoidCallback? onTap,
) {
  return GestureDetector(
    onTap: onTap,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          icon,
          size: 21,
          color: selected
              ? const Color(0xffe81745)
              : Colors.grey,
        ),
        const SizedBox(height: 3),
        Text(
          title,
          style: TextStyle(
            fontSize: 9,
            color: selected
                ? const Color(0xffe81745)
                : Colors.grey,
          ),
        ),
      ],
    ),
  );
}
}