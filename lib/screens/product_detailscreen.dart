import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/product.dart';
import '../providers/cart_provider.dart';
import '../providers/product_provider.dart';

class ProductDetailsScreen extends StatefulWidget {
  final Product product;

  const ProductDetailsScreen({
    super.key,
    required this.product,
  });

  @override
  State<ProductDetailsScreen> createState() =>
      _ProductDetailsScreenState();
}

class _ProductDetailsScreenState
    extends State<ProductDetailsScreen> {
  int quantity = 1;

  @override
  Widget build(BuildContext context) {
    final product = widget.product;
    final products =
        context.read<ProductProvider>().products;

    final recommended = products
        .where((item) => item.id != product.id)
        .take(2)
        .toList();

    return Scaffold(
      backgroundColor: const Color(0xfff4f6fc),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Stack(
                    children: [
                      Image.network(
                        product.image,
                        width: double.infinity,
                        height: 310,
                        fit: BoxFit.cover,
                        errorBuilder:
                            (context, error, stackTrace) {
                          return Container(
                            width: double.infinity,
                            height: 310,
                            color: const Color(0xffe9ebf0),
                            child: const Icon(
                              Icons.shopping_bag,
                              size: 65,
                              color: Colors.grey,
                            ),
                          );
                        },
                      ),
                      Positioned(
                        top: 45,
                        left: 16,
                        child: _circleButton(
                          Icons.arrow_back,
                          () {
                            Navigator.pop(context);
                          },
                        ),
                      ),
                      Positioned(
                        top: 45,
                        right: 16,
                        child: _circleButton(
                          Icons.favorite_border,
                          () {},
                        ),
                      ),
                    ],
                  ),
                  Transform.translate(
                    offset: const Offset(0, -18),
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.fromLTRB(
                        20,
                        20,
                        20,
                        30,
                      ),
                      decoration: const BoxDecoration(
                        color: Color(0xfff4f6fc),
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(22),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment:
                            CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment:
                                CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Text(
                                  product.title,
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xff172033),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Text(
                                '\$${product.price.toStringAsFixed(2)}',
                                style: const TextStyle(
                                  color: Color(0xffe81745),
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              const Icon(
                                Icons.star,
                                size: 16,
                                color: Colors.orange,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                product.rating
                                    .toStringAsFixed(1),
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              ),
                              const SizedBox(width: 5),
                              const Text(
                                '(120+ Reviews)',
                                style: TextStyle(
                                  fontSize: 10,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 14),
                          Row(
                            children: [
                              _tag('Premium'),
                              const SizedBox(width: 7),
                              _tag(product.category),
                              const SizedBox(width: 7),
                              _tag('Quality'),
                            ],
                          ),
                          const SizedBox(height: 23),
                          const Text(
                            'Description',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            product.description,
                            style: const TextStyle(
                              color: Colors.grey,
                              height: 1.5,
                              fontSize: 12,
                            ),
                          ),
                          const SizedBox(height: 20),
                          Container(
                            height: 1,
                            color: Colors.grey[200],
                          ),
                          const SizedBox(height: 17),
                          Row(
                            children: [
                              const Expanded(
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Quantity',
                                      style: TextStyle(
                                        fontWeight:
                                            FontWeight.bold,
                                        fontSize: 13,
                                      ),
                                    ),
                                    SizedBox(height: 3),
                                    Text(
                                      'Adjust your quantity',
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 10,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding:
                                    const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 5,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                      BorderRadius.circular(12),
                                ),
                                child: Row(
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        if (quantity > 1) {
                                          setState(() {
                                            quantity--;
                                          });
                                        }
                                      },
                                      icon: const Icon(
                                        Icons.remove,
                                        color:
                                            Color(0xffe81745),
                                        size: 17,
                                      ),
                                      constraints:
                                          const BoxConstraints(),
                                      padding:
                                          const EdgeInsets.all(7),
                                    ),
                                    SizedBox(
                                      width: 25,
                                      child: Text(
                                        quantity.toString(),
                                        textAlign:
                                            TextAlign.center,
                                        style: const TextStyle(
                                          fontWeight:
                                              FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        setState(() {
                                          quantity++;
                                        });
                                      },
                                      icon: const Icon(
                                        Icons.add,
                                        color:
                                            Color(0xffe81745),
                                        size: 17,
                                      ),
                                      constraints:
                                          const BoxConstraints(),
                                      padding:
                                          const EdgeInsets.all(7),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Container(
                            height: 1,
                            color: Colors.grey[200],
                          ),
                          const SizedBox(height: 17),
                          const Text(
                            'Recommended for you',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(height: 12),
                          SizedBox(
                            height: 145,
                            child: recommended.isEmpty
                                ? const Center(
                                    child: Text(
                                      'No recommendations',
                                    ),
                                  )
                                : ListView.builder(
                                    scrollDirection:
                                        Axis.horizontal,
                                    itemCount:
                                        recommended.length,
                                    itemBuilder:
                                        (context, index) {
                                      final item =
                                          recommended[index];

                                      return GestureDetector(
                                        onTap: () {
                                          Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                              builder: (_) =>
                                                  ProductDetailsScreen(
                                                product: item,
                                              ),
                                            ),
                                          );
                                        },
                                        child: Container(
                                          width: 150,
                                          margin:
                                              const EdgeInsets.only(
                                            right: 12,
                                          ),
                                          decoration:
                                              BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius
                                                    .circular(13),
                                          ),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment
                                                    .start,
                                            children: [
                                              Expanded(
                                                child: ClipRRect(
                                                  borderRadius:
                                                      const BorderRadius
                                                          .vertical(
                                                    top:
                                                        Radius.circular(
                                                      13,
                                                    ),
                                                  ),
                                                  child:
                                                      Image.network(
                                                    item.image,
                                                    width:
                                                        double.infinity,
                                                    fit: BoxFit.cover,
                                                    errorBuilder:
                                                        (
                                                      context,
                                                      error,
                                                      stackTrace,
                                                    ) {
                                                      return const Center(
                                                        child: Icon(
                                                          Icons
                                                              .shopping_bag,
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets
                                                        .all(8),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment
                                                          .start,
                                                  children: [
                                                    Text(
                                                      item.title,
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow
                                                              .ellipsis,
                                                      style:
                                                          const TextStyle(
                                                        fontSize: 11,
                                                        fontWeight:
                                                            FontWeight
                                                                .bold,
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                        height: 4),
                                                    Text(
                                                      '\$${item.price.toStringAsFixed(2)}',
                                                      style:
                                                          const TextStyle(
                                                        color: Color(
                                                          0xffe81745,
                                                        ),
                                                        fontWeight:
                                                            FontWeight
                                                                .bold,
                                                        fontSize: 11,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SafeArea(
            top: false,
            child: Container(
              padding: const EdgeInsets.fromLTRB(
                18,
                12,
                18,
                12,
              ),
              color: const Color(0xfff4f6fc),
              child: SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton.icon(
                  onPressed: () {
                    final cart =
                        context.read<CartProvider>();

                    for (int i = 0; i < quantity; i++) {
                      cart.addToCart(product);
                    }

                    ScaffoldMessenger.of(context)
                        .showSnackBar(
                      const SnackBar(
                        content: Text(
                          'Product added to cart',
                        ),
                      ),
                    );
                  },
                  icon: const Icon(
                    Icons.shopping_bag_outlined,
                    size: 19,
                  ),
                  label: const Text(
                    'Add to Cart',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        const Color(0xffc9003a),
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _circleButton(
    IconData icon,
    VoidCallback onPressed,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 8,
          ),
        ],
      ),
      child: IconButton(
        onPressed: onPressed,
        icon: Icon(
          icon,
          size: 20,
          color: Colors.black87,
        ),
      ),
    );
  }

  Widget _tag(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 7,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 9,
          color: Colors.grey,
        ),
      ),
    );
  }
}