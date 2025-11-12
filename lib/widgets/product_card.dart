import 'package:flutter/material.dart';
import 'package:kickngoal/screens/product_form.dart';

class ItemHomepage {
    final String name;
    final IconData icon;
    final Color color;

    ItemHomepage(this.name, this.icon, this.color);
}

class ItemCard extends StatelessWidget {
    // Show the item details in the card

    final ItemHomepage item; 

    const ItemCard(this.item, {super.key}); 

    @override
    Widget build(BuildContext context) {
        return Material(
            // Use the custom color for each button
            color: item.color,
            // Make the card corners rounded.
            borderRadius: BorderRadius.circular(12),

            child: InkWell(
                // Action when the card is tapped.
                onTap: () {
                    // Show a SnackBar message when the card is tapped.
                    ScaffoldMessenger.of(context)
                        ..hideCurrentSnackBar()
                        ..showSnackBar(
                            SnackBar(content: Text("Kamu telah menekan tombol ${item.name}!"))
                        );

                    // Navigate to ProductFormPage when "Add Product" is pressed
                    if (item.name == "Add Product") {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const ProductFormPage(),
                            ),
                        );
                    }
                },
                // Container to hold Icon and Text
                child: Container(
                    padding: const EdgeInsets.all(8),
                    child: Center(
                        child: Column(
                            // Arrange icon and text in the center of the card.
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