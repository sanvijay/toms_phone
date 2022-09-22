/// Author: Shahbaj Jamil
///profile: https://github.com/shahbajjamil

import 'package:flutter/material.dart';
import 'package:toms_phone/pages/gallery/preview_image.dart';

class GalleryScreen extends StatefulWidget {
  @override
  _GalleryScreenState createState() => _GalleryScreenState();
}

class _GalleryScreenState extends State<GalleryScreen> {
  final List galleryItems = [
    {
      'pic': 'assets/images/wallpaper.png',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Gallery'),
      ),
      body: GridView.builder(
        itemCount: galleryItems.length,
        gridDelegate:
        const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (BuildContext context, int i) {
          return Product(productImage: galleryItems[i]['pic']);
        },
      ),
    );
  }
}

class Product extends StatelessWidget {
  final String productImage;

  Product({required this.productImage});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Hero(
        tag: productImage,
        child: Material(
          child: InkWell(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) =>
                      PreviewImage(picDetails_view: productImage)));
            },
            child: GridTile(
              child: Image.asset(
                productImage,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
