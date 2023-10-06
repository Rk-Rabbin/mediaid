import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
class PresCard2 extends StatelessWidget {
  final String image;
  final title;
  final category;
  final route;
  final details;
  final doctor;
  const PresCard2({Key? key, required this.image, this.title, this.category, this.route, this.details, required this.doctor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
      child: GestureDetector(
        onTap: (){
          _showImageDialog(context);
        },
        child: Container(
          height: 125,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: CupertinoColors.white,
              boxShadow: [BoxShadow(
                color: Colors.black12,
                blurRadius: 1.0,
                spreadRadius: 0.2,
              )]
          ),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image(
                    image: NetworkImage(
                      image,
                    ),
                    height: 115,
                    width: 115,
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 7,),
                  Text(title,
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: 20
                    ),),
                  SizedBox(height: 5,),
                  Text(category,
                    style: TextStyle(
                        color: Colors.black26,
                        fontWeight: FontWeight.w400,
                        fontSize: 14
                    ),),
                  SizedBox(height: 10,),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(7),
                      color:Color(0xffD8FCEB),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: Row(
                        children: [
                          Icon(Icons.star,
                            color:  Color(0xff38CC86),
                            size: 18,
                          ),
                          SizedBox(width: 5,),
                          Text('Doctor Id: ${doctor}',
                            style: TextStyle(
                                color: Color(0xff38CC86),
                                fontWeight: FontWeight.w600,
                                fontSize: 15
                            ),),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 10,),
                  Row(
                    children: [
                      Icon(
                        CupertinoIcons.building_2_fill,
                        size: 18,
                        color: Colors.black26,
                      ),
                      Container(
                        width: 150, // Set a maximum width or adjust this value as needed
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Text(
                            details,
                            style: TextStyle(
                              color: Colors.black26,
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
void _showImageDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        child: SizedBox(
          width: 300, // Adjust the width as needed
          height: 300, // Adjust the height as needed
          child: PhotoView(
            imageProvider: NetworkImage(image), // Load the image from a URL
            minScale: PhotoViewComputedScale.contained,
            maxScale: PhotoViewComputedScale.covered * 2,
          ),
        ),
      );
    },
  );
}
}