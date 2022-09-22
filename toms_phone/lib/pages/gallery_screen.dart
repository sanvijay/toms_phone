/**
 * Author: Shahbaj Jamil
 *profile: https://github.com/shahbajjamil
 */

import 'package:flutter/material.dart';
import 'package:toms_phone/pages/gallery/preview_image.dart';

class GalleryScreen extends StatefulWidget {
  @override
  _GalleryScreenState createState() => _GalleryScreenState();
}

class _GalleryScreenState extends State<GalleryScreen> {
  final List_Item = [
    {
      'pic': 'assets/images/wallpaper.png',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Gallery'),
      ),
      body: Container(
        child: GridView.builder(
          itemCount: List_Item.length,
          gridDelegate:
          SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
          itemBuilder: (BuildContext context, int i) {
            return Product(product_image: List_Item[i]['pic']);
          },
        ),
      ),
    );
  }
}

class Product extends StatelessWidget {
  final product_image;

  Product({this.product_image});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Hero(
        tag: product_image,
        child: Material(
          child: InkWell(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) =>
                      PreviewImage(picDetails_view: product_image)));
            },
            child: GridTile(
              child: Image.asset(
                product_image,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
