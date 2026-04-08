import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(
    ProviderScope(
      // provider scope is used to manage the state of the providers in the app
      // provider scope must be the root of the app, it will be used to manage the state of the providers in the apps
      // overrides is used to override the providers in the app, we can use it to mock the providers in the tests 
      overrides: [
        nameProvider.overrideWithValue('Beso'),
        ageProvider.overrideWithValue(30),

      ],
      
      child: TestState()));
}

class TestState extends StatelessWidget {
  const TestState({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: HomeScreen());
  }
}

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final name = ref.watch(nameProvider);
    final age = ref.watch(ageProvider);
    return Scaffold(
      appBar: AppBar(title: Text('Provider State Management')),
      body: Center(child: Text('Name: $name, Age: $age')),
    );
  }
}

final nameProvider = Provider<String>((ref) => 'Mahmoud Bassem');
final ageProvider = Provider<int>((ref) => 22);
