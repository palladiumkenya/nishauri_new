import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ARTSitesScreen extends StatefulWidget {
  const ARTSitesScreen({super.key});

  @override
  State<ARTSitesScreen> createState() => _ARTSitesScreenState();
}

class _ARTSitesScreenState extends State<ARTSitesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: const Icon(Icons.chevron_left),
        ),
        title: const Text("ART Sites"),
      ),
    );
  }
}
