import 'package:flutter/material.dart';

class PostItem extends StatelessWidget {
  const PostItem(
      {Key? key,
      required this.postId,
      required this.postBody,
      required this.postTitle})
      : super(key: key);
  final int postId;
  final String postTitle;
  final String postBody;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
              color: Colors.grey.shade400, width: 1, style: BorderStyle.solid)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 7, vertical: 5),
              decoration: BoxDecoration(
                color: Colors.grey.shade600,
                borderRadius: BorderRadius.all(
                  Radius.circular(15),
                ),
              ),
              child: Text(
                'post id : ${postId.toString()}',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey.shade200),
              ),
            ),
            SizedBox(
              height: 6,
            ),
            Text(
              ' ${postTitle.toString()}',
              maxLines: 2,
              style: TextStyle(fontSize: 14, overflow: TextOverflow.ellipsis),
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              ' ${postBody.toString()}',
              style: TextStyle(
                  fontSize: 14,
                  overflow: TextOverflow.ellipsis,
                  color: Colors.grey.shade500),
              maxLines: 5,
            )
          ],
        ),
      ),
    );
  }
}
