import 'package:flutter/material.dart';

class LoaderPage extends StatelessWidget {
  static const String route = '/loader';
  const LoaderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Loader Page'),
      ),
      body: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
