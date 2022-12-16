// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

// Project imports:
import 'package:bookrabbit/src/constants/size.dart';
import 'package:bookrabbit/src/features/authentication/models/user.dart';
import 'package:bookrabbit/src/routing/routes.dart';
import 'package:bookrabbit/src/themes/custom_colors.dart';

class ProfieImage extends StatelessWidget {
  final String? imageUrl;
  final double? size;
  const ProfieImage({super.key, this.imageUrl, this.size});

  @override
  Widget build(BuildContext context) {
    var imageSize = this.size ?? PROFILE_THUMBNAIL_LOGO_SIZE;
    return CachedNetworkImage(
      imageUrl: this.imageUrl ?? '',
      errorWidget: (context, url, error) => CircleAvatar(
        radius: imageSize,
        backgroundColor: CustomColors.grayScale[200],
        child: SvgPicture.asset(
          'assets/icon/common/rabbit.svg',
          width: imageSize,
          color: CustomColors.white,
        ),
      ),
      imageBuilder: (context, imageProvider) => CircleAvatar(
        radius: imageSize,
        backgroundImage: imageProvider,
      ),
    );
  }
}

class SimpleAvatarWidget extends StatelessWidget {
  final UserSummaryModel? user;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry padding;
  final bool isLarge;
  final Widget? badge;

  const SimpleAvatarWidget({
    this.user,
    this.onTap,
    this.padding = const EdgeInsets.all(0.0),
    this.isLarge = false,
    this.badge,
  });

  @override
  Widget build(BuildContext context) {
    final avatar = SizedBox(
      width: 40,
      child: Column(
        // mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Stack(
            children: [
              ProfieImage(
                imageUrl: user?.profileThumbnail,
                size: 18.0,
              ),
              Align(
                alignment: Alignment.topRight,
                child: badge ?? Container(),
              )
            ],
          ),
          Text(
            user?.nickname ?? '',
            overflow: TextOverflow.fade,
            maxLines: 1,
            style: Theme.of(context).textTheme.overline!.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
        ],
      ),
    );

    return Padding(
      padding: this.padding,
      child: GestureDetector(
        child: avatar,
        onTap: () {
          Get.toNamed("${AppRoutes.USER_PROFILE}/${user?.id}");
        },
      ),
    );
  }
}

// NOTE: 추후 포스팅 기능 구현을 위해 남겨둔다.
class AvatarWidget extends StatelessWidget {
  final UserSummaryModel user;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry padding;
  final bool isLarge;
  final bool isShowingUsernameLabel;
  final bool isCurrentUserStory;

  const AvatarWidget({
    required this.user,
    this.onTap,
    this.padding = const EdgeInsets.all(8.0),
    this.isLarge = false,
    this.isShowingUsernameLabel = true,
    this.isCurrentUserStory = false,
  });

  static const _gradientBorderDecoration = BoxDecoration(
    shape: BoxShape.circle,
    // https://brandpalettes.com/instagram-color-codes/
    gradient: SweepGradient(
      colors: [
        Color(0xFF833AB4), // Purple
        Color(0xFFF77737), // Orange
        Color(0xFFE1306C), // Red-pink
        Color(0xFFC13584), // Red-purple
      ],
    ),
  );
  static const _whiteBorderDecoration = BoxDecoration(
    shape: BoxShape.circle,
    border: Border.fromBorderSide(BorderSide(color: Colors.white, width: 3.0)),
  );
  static const _greyBoxShadowDecoration = BoxDecoration(
    shape: BoxShape.circle,
    boxShadow: [
      BoxShadow(color: Colors.grey, blurRadius: 1.0, spreadRadius: 1.0)
    ],
  );

  @override
  Widget build(BuildContext context) {
    final radius = isLarge ? 28.0 : 14.0;
    final avatar = Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          height: radius * 2 + 9.0,
          width: radius * 2 + 9.0,
          decoration: _gradientBorderDecoration,
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Container(
                decoration: _whiteBorderDecoration,
                child: Container(
                  decoration: _greyBoxShadowDecoration,
                  child: CircleAvatar(
                    radius: radius,
                    child: user.profileThumbnail.isEmpty
                        ? CachedNetworkImage(
                            imageUrl: user.profileThumbnail,
                          )
                        : SvgPicture.asset(
                            'assets/icon/common/rabbit.svg',
                            width: 30,
                            color: CustomColors.white,
                          ),
                  ),
                ),
              ),
            ],
          ),
        ),
        if (isShowingUsernameLabel)
          Padding(
            padding: const EdgeInsets.only(top: 4.0),
            child: Text(
              isCurrentUserStory ? 'Your Story' : user.nickname,
              textScaleFactor: 0.9,
            ),
          ),
      ],
    );

    return Padding(
      padding: this.padding,
      child: GestureDetector(child: avatar, onTap: onTap),
    );
  }
}
