import 'package:flutter/material.dart';
import 'package:kickngoal/widgets/left_drawer.dart';

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
        return Scaffold(
          appBar: AppBar(
            title: const Center(
              child: Text(
                'Add Product Form',
              ),
            ),
            backgroundColor: Theme.of(context).colorScheme.primary,
            foregroundColor: Colors.white,
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
                            _thumbnail = value!;
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
                            _brand = value!;
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
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: const Text('Product Successfully Saved!'),
                                    content: SingleChildScrollView(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text('Name: $_name'),
                                          Text('Price: Rp $_price'),
                                          Text('Description: $_description'),
                                          Text('Thumbnail: ${_thumbnail.isEmpty ? "No thumbnail" : _thumbnail}'),
                                          Text('Category: $_category'),
                                          Text('Stock: $_stock'),
                                          Text('Brand: ${_brand.isEmpty ? "No Brand" : _brand}'),
                                          Text(
                                              'Is Featured: ${_isFeatured ? "Yes" : "No"}'),
                                        ],
                                      ),
                                    ),
                                    actions: [
                                      TextButton(
                                        child: const Text('OK'),
                                        onPressed: () {
                                          Navigator.pop(context);
                                          _formKey.currentState!.reset();
                                          setState(() {
                                            _name = "";
                                            _price = 0;
                                            _description = "";
                                            _thumbnail = "";
                                            _category = "apparel";
                                            _isFeatured = false;
                                            _stock = 0;
                                            _brand = "";
                                          });
                                        },
                                      ),
                                    ],
                                  );
                                },
                              );
                            }
                          },
                          child: const Text(
                            "Save",
                            style: TextStyle(color: Colors.white),
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