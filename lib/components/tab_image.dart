import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../components/button.dart';
import '../providers/vision_provider.dart';

class TabImage extends StatelessWidget {
  const TabImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<VisionProvider>(
      builder: (context, provider, child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: provider.getImageFile.isEmpty
                  ? const Center(
                      child: Text("No image selected."),
                    )
                  : Image.file(
                      File(provider.getImageFile),
                      fit: BoxFit.contain,
                    ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.all(24),
                backgroundColor: Colors.white,
                foregroundColor: Colors.indigo,
              ),
              onPressed: () {
                showModal(context);
              },
              child: Text(
                provider.getSourceanguage,
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      backgroundColor: Colors.indigo,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.all(16),
                    ),
                    onPressed: () {
                      provider.fromCamera(provider.getSourceIndex);
                    },
                    icon: const Icon(Icons.camera_alt),
                    label: const Text(
                      "Camera",
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      backgroundColor: Colors.indigo,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.all(16),
                    ),
                    onPressed: () {
                      provider.fromGallery(provider.getSourceIndex);
                    },
                    icon: const Icon(Icons.image),
                    label: const Text(
                      "Gallery",
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  void showModal(BuildContext context) {
    List<String> buttons = [
      "English",
      "Chinese",
      "Japanese",
      "Korean",
    ];
    showBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          height: 320,
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          child: Center(
            child: SizedBox(
              width: 300,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      elevation: 8,
                      child: ListView.builder(
                        itemCount: buttons.length,
                        itemBuilder: (context, index) {
                          return SnapButton(
                            text: buttons[index],
                            onPressed: () {
                              final provder = Provider.of<VisionProvider>(
                                context,
                                listen: false,
                              );
                              provder.setSourceLanguage = index;
                              Navigator.of(context).pop();
                            },
                          );
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      elevation: 16,
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.indigo,
                      padding: const EdgeInsets.all(16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text(
                      "Cancel",
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
