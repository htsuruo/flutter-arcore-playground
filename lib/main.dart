import 'package:arcore_flutter_plugin/arcore_flutter_plugin.dart';
import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart' as vector;

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  late var _controller = ArCoreController(id: 0);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: ArCoreView(
          onArCoreViewCreated: (controller) {
            _controller = controller;

            _controller.addArCoreNode(
              ArCoreNode(
                shape: ArCoreSphere(
                  radius: 0.1,
                  materials: [ArCoreMaterial(color: Colors.blue)],
                ),
                position: vector.Vector3(0, 0, -1),
              ),
            );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
