import 'package:flutter/material.dart';

class LoaderPage extends StatelessWidget {
  static const String route = '/loader';
  const LoaderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF3D808A),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Image(
                image: AssetImage('assets/icons/ic_clouds.png'),
                width: 100,
                color: Color(0xFF3D808A),
              ),
            ),
            const Text(
              'Weather Apps',
              style: TextStyle(
                color: Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 40),
            const LinearProgressIndicator(
              color: Colors.white,
              backgroundColor: Colors.white70,
            )
          ],
        ),
      ),
    );
  }
}
