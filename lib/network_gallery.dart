import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:network_gallery/util.dart';

import 'gallery_Item_model.dart';
import 'gallery_Item_thumbnail.dart';
import 'gallery_image_view_wrapper.dart';

class NetworkGallery extends StatefulWidget {
  final List<String> imageUrls;
  final String titleGallery;

  NetworkGallery({required this.imageUrls, required this.titleGallery});

  @override
  _NetworkGalleryState createState() => _NetworkGalleryState();
}

class _NetworkGalleryState extends State<NetworkGallery> {
  List<GalleryItemModel> galleryItems = <GalleryItemModel>[];

  void initState() {
    buildItemsList(widget.imageUrls);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: galleryItems.isEmpty
          ? getEmptyWidget()
          : GridView.builder(
              primary: false,
              itemCount: galleryItems.length > 3 ? 3 : galleryItems.length,
              padding: EdgeInsets.all(0),
              semanticChildCount: 1,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 0,
                crossAxisSpacing: 5,
              ),
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) {
                return ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  child: galleryItems.length > 3 && index == 2
                      ? buildImageNumbers(index)
                      : GalleryItemThumbnail(
                          galleryItem: galleryItems[index],
                          onTap: () {
                            openImageFullScreen(index);
                          },
                        ),
                );
              },
            ),
    );
  }

  Widget buildImageNumbers(int index) {
    return GestureDetector(
      onTap: () {
        openImageFullScreen(index);
      },
      child: Stack(
        alignment: AlignmentDirectional.center,
        fit: StackFit.expand,
        children: <Widget>[
          GalleryItemThumbnail(
            galleryItem: galleryItems[index],
          ),
          Container(
            color: Colors.black.withOpacity(.7),
            child: Center(
              child: Text(
                "+${galleryItems.length - index}",
                style: TextStyle(color: Colors.white, fontSize: 40),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void openImageFullScreen(final int indexOfImage) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => GalleryImageViewWrapper(
          titleGallery: widget.titleGallery,
          galleryItems: galleryItems,
          backgroundDecoration: const BoxDecoration(
            color: Colors.black,
          ),
          initialIndex: indexOfImage,
          scrollDirection: Axis.horizontal,
        ),
      ),
    );
  }

// clear and build list
  buildItemsList(List<String> items) {
    galleryItems.clear();
    items.forEach((item) {
      galleryItems.add(
        GalleryItemModel(id: item, imageUrl: item),
      );
    });
  }
}
