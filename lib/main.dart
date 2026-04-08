import 'package:flutter/material.dart';

void main(){
  runApp(TestState());
}
class TestState extends StatelessWidget {
  const TestState({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      
    );
  }
}