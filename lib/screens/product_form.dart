import 'package:flutter/material.dart';
import 'package:kickngoal/widgets/left_drawer.dart';
import 'dart:convert';
import 'package:provider/provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:kickngoal/screens/menu.dart';

class ProductFormPage extends StatefulWidget {
    const ProductFormPage({super.key});

    @override
    State<ProductFormPage> createState() => _ProductFormPageState();
}

class _ProductFormPageState extends State<ProductFormPage> {
    final _formKey = GlobalKey<FormState>();
    String _name = "";
    int _price = 0;
    String _description = "";
    String _thumbnail = "";
    String _category = "apparel";
    bool _isFeatured = false;
    int _stock = 0;
    String _brand = "";

    final List<String> _categories = [
      'apparel',
      'footwear',
      'equipment',
      'accessories',
      'balls',
      'training',
    ];

    @override
    Widget build(BuildContext context) {
        final request = context.watch<CookieRequest>();
        
        return Scaffold(
          appBar: AppBar(
            title: const Center(
              child: Text(
                'Add Product Form',
              ),
            ),
            backgroundColor: Theme.of(context).colorScheme.primary,
            foregroundColor: Colors.black,
          ),
          drawer: const LeftDrawer(),
          body: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // === Name ===
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        decoration: InputDecoration(
                          hintText: "Product Name",
                          labelText: "Product Name",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                        ),
                        onChanged: (String? value) {
                          setState(() {
                            _name = value!;
                          });
                        },
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return "Product name must not be empty!";
                          }
                          if (value.length > 255) {
                            return "Product name must not be more than 255 characters!";
                          }
                          return null;
                        },
                      ),
                    ),

                    // === Price ===
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        decoration: InputDecoration(
                          hintText: "Product Price",
                          labelText: "Product Price",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                        ),
                        keyboardType: TextInputType.number,
                        onChanged: (String? value) {
                          setState(() {
                            _price = int.tryParse(value!) ?? 0;
                          });
                        },
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return "Price must not be empty!";
                          }
                          if (int.tryParse(value) == null) {
                            return "Price must be a number!";
                          }
                          if (int.parse(value) <= 0) {
                            return "Price must be greater than 0!";
                          }
                          return null;
                        },
                      ),
                    ),

                    // === Description ===
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        maxLines: 5,
                        decoration: InputDecoration(
                          hintText: "Product Description",
                          labelText: "Product Description",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                        ),
                        onChanged: (String? value) {
                          setState(() {
                            _description = value!;
                          });
                        },
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return "Description must not be empty!";
                          }
                          return null;
                        },
                      ),
                    ),

                    // === Thumbnail URL ===
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        decoration: InputDecoration(
                          hintText: "URL Thumbnail (optional)",
                          labelText: "URL Thumbnail",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                        ),
                        onChanged: (String? value) {
                          setState(() {
                            _thumbnail = value ?? "";
                          });
                        },
                        validator: (String? value) {
                          if (value != null && value.isNotEmpty) {
                            if (!Uri.tryParse(value)!.hasAbsolutePath) {
                              return "URL is not valid!";
                            }
                          }
                          return null;
                        },
                      ),
                    ),

                    // === Category ===
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: DropdownButtonFormField<String>(
                        decoration: InputDecoration(
                          labelText: "Category",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                        ),
                        value: _category,
                        items: _categories
                            .map((cat) => DropdownMenuItem(
                                  value: cat,
                                  child: Text(
                                      cat[0].toUpperCase() + cat.substring(1)),
                                ))
                            .toList(),  
                        onChanged: (String? newValue) {
                          setState(() {
                            _category = newValue!;
                          });
                        },
                      ),
                    ),

                    // === Stock ===
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        decoration: InputDecoration(
                          hintText: "Stock Product",
                          labelText: "Stock Product",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                        ),
                        keyboardType: TextInputType.number,
                        onChanged: (String? value) {
                          setState(() {
                            _stock = int.tryParse(value!) ?? 0;
                          });
                        },
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return "Stock must not be empty!";
                          }
                          if (int.tryParse(value) == null) {
                            return "Stock must be a number!";
                          }
                          if (int.parse(value) < 0) {
                            return "Stock must not be negative!";
                          }
                          return null;
                        },
                      ),
                    ),

                    // === Brand ===
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        decoration: InputDecoration(
                          hintText: "Brand (optional)",
                          labelText: "Brand",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                        ),
                        onChanged: (String? value) {
                          setState(() {
                            _brand = value ?? "";
                          });
                        },
                        validator: (String? value) {
                          if (value != null && value.length > 100) {
                            return "Brand must not exceed 100 characters!";
                          }
                          return null;
                        },
                      ),
                    ),

                    // === Is Featured ===
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SwitchListTile(
                        title: const Text("Is Featured?"),
                        value: _isFeatured,
                        onChanged: (bool value) {
                          setState(() {
                            _isFeatured = value;
                          });
                        },
                      ),
                    ),

                    // === Tombol Save ===
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Theme.of(context).colorScheme.primary),
                          ),
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              // Show loading dialog
                              showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (BuildContext context) {
                                  return const AlertDialog(
                                    content: Row(
                                      children: [
                                        CircularProgressIndicator(),
                                        SizedBox(width: 20),
                                        Text("Saving product..."),
                                      ],
                                    ),
                                  );
                                },
                              );

                              try {
                                final response = await request.postJson(
                                  "http://localhost:8000/create-product-ajax/",
                                  jsonEncode(<String, String>{
                                    'name': _name,
                                    'price': _price.toString(),
                                    'description': _description,
                                    'thumbnail': _thumbnail,
                                    'category': _category,
                                    'stock': _stock.toString(),
                                    'brand': _brand,
                                    'is_featured': _isFeatured.toString(),
                                  }),
                                );

                                if (context.mounted) {
                                  Navigator.pop(context); // Close loading dialog
                                  
                                  if (response['status'] == 'success' || response != null) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text("Product berhasil disimpan!"),
                                        backgroundColor: Colors.green,
                                      ),
                                    );
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(builder: (context) => MyHomePage()),
                                    );
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text("Terdapat kesalahan, silakan coba lagi."),
                                        backgroundColor: Colors.red,
                                      ),
                                    );
                                  }
                                }
                              } catch (e) {
                                if (context.mounted) {
                                  Navigator.pop(context); // Close loading dialog
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text("Error: $e"),
                                      backgroundColor: Colors.red,
                                    ),
                                  );
                                }
                              }
                            }
                          },
                          child: const Text(
                            "Save",
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ),
          ),
        );
    }
}