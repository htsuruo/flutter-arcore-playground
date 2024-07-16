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

            // `addArCoreNode`でNodeを配置
            _controller.addArCoreNode(
              // 配置するNodeの定義（位置、形状、色など）
              ArCoreNode(
                position: vector.Vector3(0, 0, -1),
                // Nodeの形状(cube, sphere, cylinder, etc.)
                shape: ArCoreSphere(
                  radius: 0.1,
                  materials: [
                    // ArCoreMaterialでカラーを指定
                    ArCoreMaterial(color: Colors.blue),
                  ],
                ),
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
