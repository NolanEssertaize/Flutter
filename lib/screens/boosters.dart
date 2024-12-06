import 'package:flutter/material.dart';

class BoosterOpeningPage extends StatelessWidget {
  const BoosterOpeningPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Booster Opening'),
      ),
      body: const Center(
        child: Text('This is the Booster Opening page.'),
      ),
    );
  }
}
