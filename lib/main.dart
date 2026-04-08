import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

void main() {
  runApp(
    ProviderScope(
      // ProviderScope is the root of Riverpod.
      // It holds and manages the state of all providers in the app.
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
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // ref.watch() is used to listen to a provider.
    // When the provider value changes, the widget rebuilds automatically.
    final name = ref.watch(nameProvider);

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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Display current state value from the provider
            Text(
              name,
              style: TextStyle(fontSize: 30, color: Colors.white),
            ),

            SizedBox(height: 120),

            ElevatedButton(
              onPressed: () {
                // Create a shuffled copy of the names list
                final List<String> names = randomNames..shuffle();

                // ref.read() is used to access the provider without listening
                // .notifier gives access to the state controller
                // .state is used to update the value
                ref.read(nameProvider.notifier).state = names.first;
              },
              child: Icon(Icons.switch_access_shortcut_sharp),
            ),
          ],
        ),
      ),
    );
  }
}

// StateProvider is used to manage simple mutable state (like a variable).
// It allows reading and updating the state easily.
final nameProvider = StateProvider<String>((ref) {
  // Initial value of the state
  return 'Mahmoud';
});

// A list of names used to randomly update the state
List<String> randomNames = [
  'Mahmoud',
  'Ahmed',
  'Ali',
  'Sara',
  'Laila',
  'Omar',
  'Youssef',
  'Mona',
  'Hassan',
  'Nour'
];