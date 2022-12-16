// Package imports:
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';

// Project imports:
import 'package:bookrabbit/src/utils/logger.dart';

class ShareManager {
  void shareProductViaKakaoTalk({
    required String link,
    required String title,
    required String imageUrl,
    String? description,
  }) async {
    bool isKakaoTalkSharingAvaliable =
        await ShareClient.instance.isKakaoTalkSharingAvailable();

    try {
      var template = _getTemplate(
        dynamicLink: link,
        title: title,
        imageUrl: imageUrl,
        description: description,
      );

      if (isKakaoTalkSharingAvaliable) {
        var uri = await ShareClient.instance.shareDefault(template: template);
        await ShareClient.instance.launchKakaoTalk(uri);
      } else {
        Uri shareUrl =
            await WebSharerClient.instance.makeDefaultUrl(template: template);
        await launchBrowserTab(shareUrl);
      }
    } catch (error) {
      logger.e(error);
    }
  }

  DefaultTemplate _getTemplate({
    required String dynamicLink,
    required String title,
    required String imageUrl,
    String? description,
  }) {
    Link link = Link(mobileWebUrl: Uri.parse(dynamicLink));

    Content content = Content(
      title: title,
      imageUrl: Uri.parse(imageUrl),
      link: link,
      description: description,
    );

    FeedTemplate template = FeedTemplate(
      content: content,
      buttons: [
        Button(
          title: "모임 참여하기",
          link: link,
        ),
      ],
    );

    return template;
  }
}
