import 'package:flutter/material.dart';
import 'package:flutter_demo/util/util.dart';

class CommentAndLike extends StatelessWidget {
  final int commentCount;
  final int thumbUpCount;
  final int readCount;
  const CommentAndLike({
    Key? key,
    this.commentCount = 0,
    this.thumbUpCount = 0,
    this.readCount = 0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Row(
      children: [
        Expanded(
            child: Row(
          children: [
            Image.asset(
              "assets/images/icons/comment.png",
              width: 20,
              color: Colors.black,
              fit: BoxFit.cover,
            ),
            Expanded(
              child: Text(
                Util.strCount(commentCount),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            )
          ],
        )),
        Expanded(
            child: Row(
          children: [
            Image.asset(
              "assets/images/icons/like.png",
              width: 20,
              color: Colors.black,
              fit: BoxFit.cover,
            ),
            Expanded(
              child: Text(
                Util.strCount(thumbUpCount),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            )
          ],
        )),
        Expanded(
            child: Row(
          children: [
            Image.asset(
              "assets/images/icons/read.png",
              width: 20,
              color: Colors.black,
              fit: BoxFit.cover,
            ),
            Expanded(
              child: Text(
                Util.strCount(readCount),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            )
          ],
        )),
      ],
    ));
  }
}
