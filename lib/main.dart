// import 'dart:io';
import 'dart:io';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_wallpaper_manager/flutter_wallpaper_manager.dart';
import 'package:path_provider/path_provider.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:flutter_wallpaper_manager/flutter_wallpaper_manager.dart';
import 'package:todo/captureWidget.dart';

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
      home: Page(
        key: super.key,
      ),
    );
  }
}

class Page extends StatefulWidget {
  const Page({super.key});

  @override
  State<Page> createState() => _PageState();
}

class _PageState extends State<Page> {
  TextEditingController mainText = TextEditingController();
  final GlobalKey globalKey = GlobalKey();

  void reset() {
    print("Reset called");
    setState(() {
      mainText.text = "";
    });
  }

  Future<Uint8List> capture() async {
    final RenderRepaintBoundary boundary =
        globalKey.currentContext!.findRenderObject()! as RenderRepaintBoundary;

    if (boundary.debugNeedsPaint) {
      print("waiting.......");
      return capture();
    }

    final ui.Image image = await boundary.toImage(pixelRatio: 2);
    final ByteData? byteData =
        await image.toByteData(format: ui.ImageByteFormat.png);
    final Uint8List pngBytes = byteData!.buffer.asUint8List();
    print(pngBytes);
    return pngBytes;
  }

  Future<void> setWallpaper(Uint8List bytes) async {
    final directory = await getApplicationDocumentsDirectory();
    final File file = File('${directory.path}/my_file.png');
    await file.writeAsBytes(bytes);
    print(file.path);
    int location = WallpaperManager.BOTH_SCREEN; //can be Home/Lock Screen
    await WallpaperManager.setWallpaperFromFile(file.path, location);
  }

  void submit() async {
    FocusManager.instance.primaryFocus?.unfocus();
    Uint8List pngBytes = await capture();
    await setWallpaper(pngBytes);
    BuildContext context = globalKey.currentContext!;
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Wallpaper Set"),
      ));
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add notes below"),
        actions: [
          IconButton(onPressed: reset, icon: const Icon(Icons.restore_sharp)),
          IconButton(onPressed: submit, icon: const Icon(Icons.done_all_sharp))
        ],
      ),
      body: RepaintBoundary(
          key: globalKey, child: CaptureWidget(mainText: mainText)),
    );
  }
}
