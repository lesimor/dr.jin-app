import 'package:bookrabbit/src/features/matches/models/reservation.dart';
import 'package:bookrabbit/src/routing/routes.dart';
import 'package:bookrabbit/src/themes/custom_colors.dart';
import 'package:bookrabbit/src/utils/image.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class Chatroom extends StatelessWidget {
  final DateFormat dateFormatter = DateFormat('yyyy-MM-dd HH:mm');
  final AVATOR_WIDTH = 30.0;
  final ReservationOutModel reservation;
  Chatroom({
    super.key,
    required this.reservation,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.toNamed(
        AppRoutes.CHATROOM,
        arguments: {
          'channelId': reservation.uid,
          'reservation': reservation,
        },
      ),
      child: Container(
        padding: EdgeInsets.only(left: 16, right: 16, top: 10, bottom: 10),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Row(
                children: <Widget>[
                  CachedNetworkImage(
                    imageUrl:
                        reservation.content.creator?.profileThumbnail ?? '',
                    errorWidget: (context, url, error) => CircleAvatar(
                      radius: AVATOR_WIDTH,
                      backgroundColor: CustomColors.grayScale[200],
                      backgroundImage: Image.asset(
                        randomProfileImageAssetGenerator(),
                        fit: BoxFit.cover,
                      ).image,
                    ),
                    imageBuilder: (context, imageProvider) => CircleAvatar(
                      radius: AVATOR_WIDTH,
                      backgroundImage: imageProvider,
                    ),
                  ),
                  SizedBox(
                    width: 16,
                  ),
                  Expanded(
                    child: Container(
                      color: Colors.transparent,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            reservation.content.creator?.realName ?? '',
                            style: TextStyle(fontSize: 16),
                          ),
                          SizedBox(
                            height: 6,
                          ),
                          Text(reservation.content.title ?? '',
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.grey.shade600,
                              ),),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
