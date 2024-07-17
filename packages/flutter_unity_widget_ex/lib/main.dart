// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_unity_widget/flutter_unity_widget.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: _UnityView());
  }
}

class _UnityView extends StatefulWidget {
  const _UnityView();

  @override
  State<_UnityView> createState() => _UnityViewState();
}

class _UnityViewState extends State<_UnityView> {
  late UnityWidgetController _controller;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Unity on Flutter'),
      ),
      body: Center(
        child: UnityWidget(
          onUnityCreated: (controller) {
            _controller = controller;
          },
          onUnitySceneLoaded: (scene) {
            if (scene != null) {
              print('Received scene loaded from unity: ${scene.name}');
              print(
                  'Received scene loaded from unity buildIndex: ${scene.buildIndex}');
            } else {
              print('Received scene loaded from unity: null');
            }
          },
        ),
      ),
    );
  }
}
