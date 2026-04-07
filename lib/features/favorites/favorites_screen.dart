import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'favorites_viewmodel.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<FavoritesViewModel>(context);

    return Scaffold(
      appBar: AppBar(title: const Text("Favorites")),
      body: ListView.builder(
        itemCount: vm.favorites.length,
        itemBuilder: (context, index) {
          final item = vm.favorites[index];
          return ListTile(
            title: Text(item.title),
            subtitle: Text("₹${item.price}"),
          );
        },
      ),
    );
  }
}