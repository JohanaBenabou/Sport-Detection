import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:tflite/tflite.dart';
import 'package:image_picker/image_picker.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool _loading = true;
  late File _image;
  List _output = [];
  final picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    loadModel().then((value) {
      setState(() {});
    });
  }

  _detectImage(File image) async {
    final output = await Tflite.runModelOnImage(
        path: image.path,
        numResults: 73,
        threshold: 0.6,
        imageMean: 127.5,
        imageStd: 127.5);
    setState(() {
      _output = output!;
      _loading = false;
    });
  }

  loadModel() async {
    await Tflite.loadModel(
        model: 'assets/model_unquant.tflite', labels: 'assets/labels.txt');
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  pickImage(ImageSource imageSource) async {
    final image = await picker.pickImage(source: imageSource);
    if (image == null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Error! Retry'),
      ));
      return null;
    }

    _image = File(image.path);

    _detectImage(_image);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SizedBox(height: 50),
            const Text(
              'Project Cellularim',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            const SizedBox(height: 5),
            const Text(
              'Sport Detection App',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 30),
            ),
            const SizedBox(height: 50),
            Center(
              child: _loading
                  ? Column(
                      children: <Widget>[
                        Image.asset('assets/sport2.jpeg'),
                        const SizedBox(height: 50),
                      ],
                    )
                  : Column(
                      children: <Widget>[
                        Image.file(
                          _image,
                          height: 250,
                        ),
                        const SizedBox(height: 20),
                        _output.isNotEmpty
                            ? Text(
                                'Detected Sport : ${_output[0]['label']}',
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 15),
                              )
                            : const SizedBox.shrink(),
                        const SizedBox(height: 20),
                      ],
                    ),
            ),
            const Spacer(),
            Center(
              child: ElevatedButton.icon(
                  onPressed: () => showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                            title: const Text('Select a photo'),
                            content: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                    pickImage(ImageSource.camera);
                                  },
                                  child: const Text(
                                    'Take a photo',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                    pickImage(ImageSource.gallery);
                                  },
                                  child: const Text(
                                    'Choose from gallery',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                          )),
                  icon: const Icon(Icons.photo),
                  label: const Text('Select a photo')),
            ),
            const SizedBox(
              height: 24,
            ),
          ],
        ),
      ),
    );
  }
}
