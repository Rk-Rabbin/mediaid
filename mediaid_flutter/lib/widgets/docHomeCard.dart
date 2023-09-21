import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class docHomeCard extends StatelessWidget {
  final image;
  final title;
  final subtitle;
  final distance;
  final rating;

  const docHomeCard({Key? key, required this.image, this.title, this.subtitle, this.distance, this.rating}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 220,
        width: 150,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(6),
            boxShadow: const [BoxShadow(
              color: Colors.black12,
              blurRadius: 2.0,
              spreadRadius: 0.5,
            )]
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
                child: Container(
                  height: 75,
                  width: 75,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: image is String && image.startsWith('http') // Check if the image is a network URL
                                 ? NetworkImage(image)       // Use NetworkImage if it's a URL
                                 : AssetImage(image)
                                 as ImageProvider<Object>,
                          // image: NetworkImage(
                          //   image,
                          // ),
                          scale: 20,
                          fit: BoxFit.fill
                      )
                  ),
                ),
              ),
            ),
            SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.fromLTRB(13, 0, 0, 8),
              child: Text(title,
                style: TextStyle(
                    color: Colors.black45,
                    fontWeight: FontWeight.w500
                ),),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(13, 0, 0, 10),
              child: Text(subtitle,
                textAlign: TextAlign.start,
                style: TextStyle(
                    color: Colors.black38,
                    fontSize: 12
                ),),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
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
                            size: 12,
                          ),
                          Text(rating,
                            style: TextStyle(
                                color: Color(0xff38CC86),
                                fontWeight: FontWeight.w600,
                                fontSize: 10
                            ),),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
              child: Row(
                children: [
                    Icon(CupertinoIcons.location_solid,size: 12,color: Colors.black26,),
                    Flexible(
                      flex: 2,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal, // Make the text scroll horizontally
                        child: Text(
                          distance,
                          style: TextStyle(
                            color: Colors.black26,
                            fontWeight: FontWeight.w400,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ),
                    ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
