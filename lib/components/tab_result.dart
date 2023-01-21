import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../components/appbar.dart';
import '../components/button.dart';
import '../components/multiline_textfield.dart';
import '../providers/vision_provider.dart';

class TabText extends StatefulWidget {
  const TabText({super.key});

  @override
  State<TabText> createState() => _TabTextState();
}

class _TabTextState extends State<TabText> {
  final _sourceController = TextEditingController();
  final _outputController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final double height = appBar.preferredSize.height;

    return Consumer<VisionProvider>(
      builder: (context, provider, child) {
        _sourceController.text = provider.getRecognizedSource;
        _outputController.text = provider.getRecognizedOutput;

        return SizedBox(
          height: (MediaQuery.maybeOf(context)!.size.height -
                  MediaQuery.maybeOf(context)!.viewPadding.top) -
              MediaQuery.maybeOf(context)!.viewPadding.bottom -
              height -
              110,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.all(12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: const EdgeInsets.all(18),
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.indigo,
                        ),
                        onPressed: () {
                          showModalSource(context);
                        },
                        child: Text(
                          provider.getSourceanguage,
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            provider.setSource = _sourceController.text;
                            provider.speakSource();
                          },
                          icon: const Icon(
                            Icons.play_arrow,
                            color: Colors.indigoAccent,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            provider.pause();
                          },
                          icon: const Icon(
                            Icons.pause,
                            color: Colors.indigoAccent,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            provider.stop();
                          },
                          icon: const Icon(
                            Icons.stop,
                            color: Colors.indigoAccent,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SnapTextField(
                controller: _sourceController,
              ),
              TextButton.icon(
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.all(16),
                ),
                onPressed: () {
                  provider.setSource = _sourceController.text;
                  provider.translate();
                },
                icon: const Icon(Icons.refresh),
                label: const Text("Translate"),
              ),
              Padding(
                padding: const EdgeInsets.all(12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: const EdgeInsets.all(18),
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.indigo,
                        ),
                        onPressed: () {
                          showModalOut(context);
                        },
                        child: Text(
                          provider.getOutputlanguage,
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            provider.setOutput = _outputController.text;
                            provider.speakOutput();
                          },
                          icon: const Icon(
                            Icons.play_arrow,
                            color: Colors.indigoAccent,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            provider.pause();
                          },
                          icon: const Icon(
                            Icons.pause,
                            color: Colors.indigoAccent,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            provider.stop();
                          },
                          icon: const Icon(
                            Icons.stop,
                            color: Colors.indigoAccent,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SnapTextField(
                controller: _outputController,
              ),
            ],
          ),
        );
      },
    );
  }

  void showModalSource(BuildContext context) {
    List<String> buttons = [
      "English",
      "Chinese",
      "Japanese",
      "Korean",
    ];
    showBottomSheet(
      backgroundColor: const Color.fromARGB(0, 0, 0, 0),
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

  void showModalOut(BuildContext context) {
    List<String> buttons = [
      "English",
      "Chinese",
      "Japanese",
      "Korean",
    ];
    showBottomSheet(
      backgroundColor: const Color.fromARGB(0, 0, 0, 0),
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
                              provder.setOutputLanguage = index;
                              provder.translate();
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
