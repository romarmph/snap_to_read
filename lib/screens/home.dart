import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../components/appbar.dart';
import '../components/tab_image.dart';
import '../components/tab_result.dart';
import '../providers/vision_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      body: Consumer<VisionProvider>(
        builder: (context, value, child) {
          return Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                SizedBox(
                  height: 56,
                  child: TabBar(
                    indicatorColor: Colors.indigoAccent,
                    labelColor: Colors.indigoAccent,
                    controller: _tabController,
                    tabs: const <Widget>[
                      Tab(
                        text: "Image",
                        icon: Icon(
                          Icons.image,
                        ),
                      ),
                      Tab(
                        text: "Text",
                        icon: Icon(
                          Icons.text_snippet,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: const [
                      TabImage(),
                      SingleChildScrollView(
                        child: SizedBox(
                          child: TabText(),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
