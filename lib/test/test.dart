import 'package:flutter/material.dart';
import 'package:flutter_tips/main.dart';
import 'package:provider/provider.dart';

class TestValueScreen extends StatelessWidget {
  const TestValueScreen({super.key});

  @override
  Widget build(BuildContext context) {
    MyModel asd = Provider.of(context);
    return Scaffold(
      body: Center(
        child: Text("Value :${asd.someValue}"),
      ),
    );
  }
}
