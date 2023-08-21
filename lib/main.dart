import 'dart:ui';

import 'package:flutter/material.dart';

void main() {
  runApp(ImageList());
}

class ImageList extends StatefulWidget {
  @override
  ImageListState createState() => ImageListState();
}

class ImageListState extends State<ImageList> {
  List<String> _imagePath = [
    'assets/images/apple.png',
    'assets/images/pineapple.png',
    'assets/images/Cherries.png',
    'assets/images/pear.png',
    'assets/images/Kiwi.png',
  ];

  List<String> _images = [];

  List<bool> _isBlur = [];

  void _addImage() {
    setState(
      () {
        if (_images.length < _imagePath.length) {
          _images.add(_imagePath[_images.length]);
          _isBlur.add(true);
        }
      },
    );
  }

  void _removeImage(int i) {
    setState(() {
      _images.removeAt(i);
      _isBlur.removeAt(i);
    });
  }

  void _deleteImage() {
    setState(() {
      _images.removeLast();
    });
  }

  void _clearImage() {
    setState(() {
      _images.clear();
      _isBlur.clear();
    });
  }

  void deblurImage(int i) {
    setState(() {
      _isBlur[i] = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.teal,
          title: Text(
            "Image Show",
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _deleteImage,
          child: Icon(Icons.delete),
          backgroundColor: Colors.teal,
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 25.0),
          child: Center(
            child: Column(
              children: [
                ElevatedButton(
                  onPressed: _addImage,
                  child: Text('Add Image'),
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.teal),
                    fixedSize: MaterialStateProperty.all<Size>(
                      Size(150, 50),
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: _images.length,
                    itemBuilder: (context, index) {
                      return Stack(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Container(
                              padding: EdgeInsets.all(10),
                              child: Stack(
                                children: [
                                  ImageFiltered(
                                    imageFilter: _isBlur[index]
                                        ? ImageFilter.blur(
                                            sigmaX: 4.0, sigmaY: 4.0)
                                        : ImageFilter.blur(
                                            sigmaX: 0.0, sigmaY: 0.0),
                                    child: Stack(
                                      children: [
                                        Image.asset(
                                          _images[index],
                                        ),
                                      ],
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 0.0,
                                    right: 0.0,
                                    left: 0.0,
                                    child: Center(
                                      child: TextButton(
                                        onPressed: () {
                                          deblurImage(index);
                                        },
                                        child: Text('Remove Blur'),
                                        style: ButtonStyle(
                                          shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(
                                            RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(18.0),
                                            ),
                                          ),
                                          backgroundColor:
                                              MaterialStateProperty.all<Color>(
                                            Colors.cyan,
                                          ),
                                          foregroundColor:
                                              MaterialStateProperty.all<Color>(
                                                  Colors.black54),
                                          elevation:
                                              MaterialStateProperty.all<double>(
                                                  10),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Positioned(
                            child: IconButton(
                              icon: Icon(Icons.close),
                              onPressed: () => _removeImage(index),
                            ),
                            right: 0.0,
                          ),
                        ],
                      );
                    },
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.restart_alt_rounded),
                  iconSize: 30,
                  onPressed: _clearImage,
                  style: ButtonStyle(
                    iconSize: MaterialStateProperty.all<double>(150),
                    backgroundColor: MaterialStateProperty.all<Color>(
                      Colors.redAccent,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
