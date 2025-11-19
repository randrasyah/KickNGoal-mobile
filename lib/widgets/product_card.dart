import 'package:flutter/material.dart';
import 'package:kickngoal/screens/product_form.dart';
import 'package:kickngoal/screens/product_entry_list.dart';
import 'package:kickngoal/screens/login.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

class ItemHomepage {
    final String name;
    final IconData icon;
    final Color color;

    ItemHomepage(this.name, this.icon, this.color);
}

class ItemCard extends StatelessWidget {
    final ItemHomepage item;

    const ItemCard(this.item, {super.key});

    @override
    Widget build(BuildContext context) {
        final request = context.watch<CookieRequest>();
        
        return Material(
            color: item.color,
            borderRadius: BorderRadius.circular(12),
            child: InkWell(
                onTap: () async {
                    ScaffoldMessenger.of(context)
                        ..hideCurrentSnackBar()
                        ..showSnackBar(
                            SnackBar(content: Text("Kamu telah menekan tombol ${item.name}!"))
                        );
                    
                    // Navigate to appropriate pages
                    if (item.name == "All Products") {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const ProductListPage(),
                            ),
                        );
                    } else if (item.name == "Add Product") {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const ProductFormPage(),
                            ),
                        );
                    } else if (item.name == "Logout") {
                        // Show confirmation dialog
                        final shouldLogout = await showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text('Logout'),
                              content: const Text('Are you sure you want to logout?'),
                              actions: [
                                TextButton(
                                  child: const Text('Cancel'),
                                  onPressed: () => Navigator.pop(context, false),
                                ),
                                TextButton(
                                  child: const Text('Logout'),
                                  onPressed: () => Navigator.pop(context, true),
                                ),
                              ],
                            );
                          },
                        );

                        if (shouldLogout == true) {
                          final response = await request.logout(
                              "http://localhost:8000/auth/logout/");
                          String message = response["message"];
                          
                          if (context.mounted) {
                            if (response['status']) {
                              String uname = response["username"];
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text("$message Sampai jumpa, $uname."),
                              ));
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(builder: (context) => const LoginPage()),
                                (route) => false,
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(message),
                                ),
                              );
                            }
                          }
                        }
                    }
                },
                child: Container(
                    padding: const EdgeInsets.all(8),
                    child: Center(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                                Icon(
                                    item.icon,
                                    color: Colors.black,
                                    size: 30.0,
                                ),
                                const Padding(padding: EdgeInsets.all(3)),
                                Text(
                                    item.name,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(color: Colors.black),
                                ),
                            ],
                        ),
                    ),
                ),
            ),
        );
    }
}