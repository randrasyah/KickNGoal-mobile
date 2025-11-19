import 'package:flutter/material.dart';
import 'package:kickngoal/models/product_entry.dart';
import 'package:kickngoal/widgets/left_drawer.dart';
import 'package:kickngoal/screens/product_detail.dart';
import 'package:provider/provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';

class ProductListPage extends StatefulWidget {
  const ProductListPage({super.key});

  @override
  State<ProductListPage> createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  String _currentFilter = 'all'; // Track current filter

  Future<List<ProductEntry>> fetchProducts(CookieRequest request, String filter) async {
    String endpoint;
    if (filter == 'my') {
      endpoint = 'http://localhost:8000/json-filtered/'; // Only user's products
    } else {
      endpoint = 'http://localhost:8000/json/'; // All products
    }
    
    try {
      final response = await request.get(endpoint);
      
      // Handle the response
      var data = response;
      if (data == null) {
        return [];
      }
      
      List<ProductEntry> listProduct = [];
      for (var d in data) {
        if (d != null) {
          try {
            listProduct.add(ProductEntry.fromJson(d));
          } catch (e) {
            // Skip problematic data
          }
        }
      }
      return listProduct;
    } catch (e) {
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Products'),
        backgroundColor: const Color(0xFFDCEDC8),
        foregroundColor: Colors.black,
      ),
      drawer: const LeftDrawer(),
      body: Column(
        children: [
          // Filter Section
          Container(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _currentFilter = 'all';
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _currentFilter == 'all' 
                          ? const Color(0xFF4CAF50) 
                          : Colors.white,
                      foregroundColor: _currentFilter == 'all' 
                          ? Colors.white 
                          : Colors.black,
                      side: BorderSide(
                        color: const Color(0xFF4CAF50),
                        width: 1,
                      ),
                    ),
                    child: const Text('All Products'),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _currentFilter = 'my';
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _currentFilter == 'my' 
                          ? const Color(0xFF4CAF50) 
                          : Colors.white,
                      foregroundColor: _currentFilter == 'my' 
                          ? Colors.white 
                          : Colors.black,
                      side: BorderSide(
                        color: const Color(0xFF4CAF50),
                        width: 1,
                      ),
                    ),
                    child: const Text('My Products'),
                  ),
                ),
              ],
            ),
          ),
          // Product List
          Expanded(
            child: FutureBuilder(
              key: ValueKey(_currentFilter), // Force rebuild when filter changes
              future: fetchProducts(request, _currentFilter),
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.error, size: 64, color: Colors.red),
                        const SizedBox(height: 16),
                        Text('Error: ${snapshot.error}'),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () => setState(() {}),
                          child: const Text('Retry'),
                        ),
                      ],
                    ),
                  );
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.shopping_bag_outlined,
                          size: 64,
                          color: Colors.grey,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          _currentFilter == 'my' 
                              ? 'Belum ada produk milik Anda di KickNGoal.'
                              : 'Belum ada produk di KickNGoal.',
                          style: const TextStyle(fontSize: 20, color: Colors.grey),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 8),
                      ],
                    ),
                  );
                } else {
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (_, index) => Container(
                      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      padding: const EdgeInsets.all(20.0),
                      child: Card(
                        elevation: 4,
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ProductDetailPage(
                                  product: snapshot.data![index],
                                ),
                              ),
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Product Image
                                Container(
                                  height: 200,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: Colors.grey[200],
                                    image: snapshot.data![index].thumbnail.isNotEmpty
                                        ? DecorationImage(
                                            image: NetworkImage(snapshot.data![index].thumbnail),
                                            fit: BoxFit.cover,
                                          )
                                        : null,
                                  ),
                                  child: snapshot.data![index].thumbnail.isEmpty
                                      ? const Icon(
                                          Icons.image_not_supported,
                                          size: 50,
                                          color: Colors.grey,
                                        )
                                      : null,
                                ),
                                const SizedBox(height: 12),
                                
                                // Product Name
                                Text(
                                  "${snapshot.data![index].name}",
                                  style: const TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                
                                // Price
                                Text(
                                  "Rp ${snapshot.data![index].price}",
                                  style: const TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF4CAF50),
                                  ),
                                ),
                                const SizedBox(height: 8),
                                
                                // Category
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFDCEDC8),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Text(
                                    "${snapshot.data![index].category}",
                                    style: const TextStyle(
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 8),
                                
                                // Description
                                Text(
                                  "${snapshot.data![index].description}",
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(fontSize: 14.0),
                                ),
                                const SizedBox(height: 8),
                                
                                // Featured badge
                                if (snapshot.data![index].isFeatured)
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                    decoration: BoxDecoration(
                                      color: Colors.orange,
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: const Text(
                                      "Featured",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}