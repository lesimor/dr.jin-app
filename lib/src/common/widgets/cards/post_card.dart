// Dart imports:
import 'dart:async';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:carousel_slider/carousel_slider.dart';

// Project imports:
import 'package:bookrabbit/src/common/widgets/user_image.dart';
import 'package:bookrabbit/src/common/data/model/review.dart';
import 'package:bookrabbit/src/features/authentication/models/user.dart';
import 'package:bookrabbit/src/utils/ui_utils.dart';

class PostWidget extends StatefulWidget {
  final ReviewModel post;

  PostWidget(this.post);

  @override
  _PostWidgetState createState() => _PostWidgetState();
}

class _PostWidgetState extends State<PostWidget> {
  final StreamController<void> _doubleTapImageEvents =
      StreamController.broadcast();
  int _currentImageIndex = 0;

  void _updateImageIndex(int index, _) {
    setState(() => _currentImageIndex = index);
  }

  @override
  void dispose() {
    _doubleTapImageEvents.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        // User Details
        Row(
          children: <Widget>[
            AvatarWidget(user: widget.post.writer),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(widget.post.writer.nickname, style: bold),
                Text('서울')
              ],
            ),
            Spacer(),
            IconButton(
              icon: Icon(Icons.more_vert),
              onPressed: () => showSnackbar(context, 'More'),
            )
          ],
        ),
        // Photo Carosuel
        if (widget.post.images.length > 0)
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                child: Stack(
                  alignment: Alignment.center,
                  children: <Widget>[
                    CarouselSlider(
                      items: widget.post.images.map((url) {
                        return FadeInImage.assetNetwork(
                          image: url,
                          placeholder: 'assets/images/default-avatar.png',
                          fit: BoxFit.fitWidth,
                          width: MediaQuery.of(context).size.width,
                        );
                      }).toList(),
                      options: CarouselOptions(
                        autoPlay: false,
                        viewportFraction: 1.0,
                        enableInfiniteScroll: false,
                        onPageChanged: _updateImageIndex,
                      ),
                    ),
                  ],
                ),
              ),
              if (widget.post.images.length > 1)
                PhotoCarouselIndicator(
                  photoCount: widget.post.images.length,
                  activePhotoIndex: _currentImageIndex,
                ),
            ],
          ),
        // Action Bar
        Padding(
          padding: const EdgeInsets.only(left: 8.0, bottom: 16.0, top: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                widget.post.productReview,
                style: TextStyle(fontSize: 18.0),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class PhotoCarouselIndicator extends StatelessWidget {
  final int photoCount;
  final int activePhotoIndex;

  PhotoCarouselIndicator({
    required this.photoCount,
    required this.activePhotoIndex,
  });

  Widget _buildDot({bool isActive = false}) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.only(left: 3.0, right: 3.0),
        child: Container(
          height: isActive ? 7.5 : 6.0,
          width: isActive ? 7.5 : 6.0,
          decoration: BoxDecoration(
            color: isActive ? Colors.blue : Colors.grey,
            borderRadius: BorderRadius.circular(4.0),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(photoCount, (i) => i)
              .map((i) => _buildDot(isActive: i == activePhotoIndex))
              .toList(),
        );
      },
    );
  }
}

class AddCommentModal extends StatefulWidget {
  final UserSummaryModel user;
  final ValueChanged<String> onPost;

  AddCommentModal({required this.user, required this.onPost});

  @override
  _AddCommentModalState createState() => _AddCommentModalState();
}

class _AddCommentModalState extends State<AddCommentModal> {
  final _textController = TextEditingController();
  bool _canPost = false;

  @override
  void initState() {
    _textController.addListener(() {
      setState(() => _canPost = _textController.text.isNotEmpty);
    });
    super.initState();
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        AvatarWidget(user: widget.user),
        Expanded(
          child: TextField(
            controller: _textController,
            autofocus: true,
            decoration: InputDecoration(
              hintText: 'Add a comment...',
              border: InputBorder.none,
            ),
          ),
        ),
        TextButton(
          child: Opacity(
            opacity: _canPost ? 1.0 : 0.4,
            child: Text('Post', style: TextStyle(color: Colors.blue)),
          ),
          onPressed:
              _canPost ? () => widget.onPost(_textController.text) : null,
        )
      ],
    );
  }
}
