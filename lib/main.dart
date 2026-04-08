import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:test_state/product.dart';

void main() {
  runApp(
    ProviderScope(
      // ProviderScope is the root of Riverpod state management.
      // It stores and manages all providers' states across the app.
      child: TestState(),
    ),
  );
}

class TestState extends StatelessWidget {
  const TestState({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // Main entry screen of the app
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // ConsumerWidget gives access to WidgetRef (ref)
    // ref is used to read/watch providers

    return Scaffold(
      backgroundColor: Colors.blueAccent,
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: Text(
          'Riverpod',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),

      body: Center(
        child: ListView.builder(
          // itemCount is required to avoid RangeError
          // It defines how many items will be built
          itemCount: ref.watch(productsProvider).length,

          itemBuilder: (context, index) {
            // ref.watch() listens to the provider
            // When data changes, UI rebuilds automatically
            final product = ref.watch(productsProvider)[index];

            return ListTile(
              // Display product name
              title: Text(
                product.name,
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),

              // Display product price formatted to 2 decimal places
              subtitle: Text(
                "${product.price.toStringAsFixed(2)} \$",
                style: TextStyle(fontSize: 16, color: Colors.black),
              ),
            );
          },
        ),
      ),

      // Dropdown used to change sorting type (name or price)
      floatingActionButton: DropdownButton<ProductSortType>(
        // Current selected value from provider
        value: ref.watch(sortProvider),

        // Dropdown options
        items: [
          DropdownMenuItem(
            value: ProductSortType.name,
            child: Icon(Icons.abc),
          ),
          DropdownMenuItem(
            value: ProductSortType.price,
            child: Icon(Icons.price_change),
          ),
        ],

        onChanged: (value) {
          // ref.read() is used to update provider without rebuilding immediately
          // notifier gives access to the state controller
          ref.read(sortProvider.notifier).state =
              value ?? ProductSortType.name;
        },
      ),
    );
  }
}

// StateProvider is used for simple mutable state (can change over time)
// Here it stores the current sorting type
final sortProvider = StateProvider<ProductSortType>((ref) {
  return ProductSortType.name; // default sorting is by name
});

// Provider is used for computed/derived state (read-only)
// It depends on sortProvider to return sorted product list
final productsProvider = Provider<List<Product>>((ref) {
  // Watch current sorting type
  final sortType = ref.watch(sortProvider);

  // Create a copy of original products list
  // to avoid modifying the original data
  List<Product> sortedProducts = List.from(products);

  // Sort based on selected type
  if (sortType == ProductSortType.name) {
    // Sort alphabetically by name
    sortedProducts.sort((a, b) => a.name.compareTo(b.name));
  } else if (sortType == ProductSortType.price) {
    // Sort numerically by price
    sortedProducts.sort((a, b) => a.price.compareTo(b.price));
  }

  // Return sorted list
  return sortedProducts;
});