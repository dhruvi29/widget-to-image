import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:todo/Content.dart';
// import 'package:widgets_to_image/widgets_to_image.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_wallpaper_manager/flutter_wallpaper_manager.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // WidgetsToImageController to access widget
  // WidgetsToImageController controller = WidgetsToImageController();

  @override
  Widget build(BuildContext context) {
    return WidgetsToImage(
      controller: controller,
      child: GestureDetector(
        onHorizontalDragEnd: (details),
        child: const Scaffold(
          backgroundColor: Colors.black,
          body: const MyTable(),
        ),
      ),
    );
  }
}

void toImage() async {
  FocusManager.instance.primaryFocus?.unfocus();
  sleep(Durations.short1);
  const bytes = 's'; // add here

  final directory = await getApplicationDocumentsDirectory();

  SystemNavigator.pop();
  final File file = File('${directory.path}/my_file.png');
  print(directory.path);
  print(bytes);
  await file.writeAsBytes(bytes);
  print(file.path);
  int location = WallpaperManager.BOTH_SCREEN; //can be Home/Lock Screen
  bool result =
      await WallpaperManager.setWallpaperFromFile(file.path, location);
  print(result);
  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
    content: Text("Wallpaper Set"),
  ));
}
