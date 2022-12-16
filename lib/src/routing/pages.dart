// Dart imports:

// Project imports:
import 'package:bookrabbit/src/common/widgets/webview.dart';
import 'package:bookrabbit/src/features/authentication/screens/login_email/page.dart';
import 'package:bookrabbit/src/features/authentication/screens/login_main/binding.dart';
import 'package:bookrabbit/src/features/authentication/screens/login_main/page.dart';
import 'package:bookrabbit/src/features/authentication/screens/registration/binding.dart';
import 'package:bookrabbit/src/features/authentication/screens/registration/page.dart';
import 'package:bookrabbit/src/features/contents/screens/club_list/binding.dart';
import 'package:bookrabbit/src/features/contents/screens/club_list/page.dart';
import 'package:bookrabbit/src/features/contents/screens/detail/binding.dart';
import 'package:bookrabbit/src/features/contents/screens/detail/page.dart';
import 'package:bookrabbit/src/features/entrypoint/screens/app_layout/binding.dart';
import 'package:bookrabbit/src/features/entrypoint/screens/app_layout/page.dart';
import 'package:bookrabbit/src/features/matches/screens/chatroom/binding.dart';
import 'package:bookrabbit/src/features/matches/screens/chatroom/page.dart';
import 'package:bookrabbit/src/features/products/screens/detail/binding.dart';
import 'package:bookrabbit/src/features/products/screens/setting/page.dart';
import 'package:bookrabbit/src/features/profiles/screens/my_profile/page.dart';
import 'package:bookrabbit/src/features/profiles/screens/my_profile_editor/binding.dart';
import 'package:bookrabbit/src/features/profiles/screens/my_profile_editor/page.dart';
import 'package:bookrabbit/src/features/profiles/screens/profile_list/binding.dart';
import 'package:bookrabbit/src/features/profiles/screens/profile_list/page.dart';
import 'package:bookrabbit/src/features/profiles/screens/user_profile/page.dart';
import 'package:bookrabbit/src/features/settings/screens/app_setting/page.dart';
import 'package:bookrabbit/src/routing/routes.dart';
import 'package:bookrabbit/src/utils/middlewares.dart';
import 'package:get/get.dart';

final middlewares = [AuthenticationRequired()];

abstract class AppPages {
  static final pages = [
    GetPage(
      name: AppRoutes.LOGIN,
      page: () => LoginPage(),
      binding: UserBinding(),
    ),
    GetPage(
      name: AppRoutes.LOGIN_WITH_EMAIL,
      page: () => LoginWithEmailPage(),
    ),
    GetPage(
      name: AppRoutes.REGISTRATION,
      page: () => RegistrationPage(),
      binding: RegistrationBinding(),
    ),
    GetPage(
      name: AppRoutes.INITIAL_PAGE,
      page: () => LandingPage(),
      binding: InitialBinding(),
      middlewares: [AuthenticationRequired()],
    ),
    GetPage(
      name: AppRoutes.COUSELOR_LIST,
      page: () => ProfileListPage(),
      binding: ProfileListBinding(),
      middlewares: [AuthenticationRequired()],
    ),
    GetPage(
      name: AppRoutes.CONTENT_LIST,
      page: () => ClubListPage(),
      binding: ClubListPageBinding(),
      middlewares: [AuthenticationRequired()],
    ),
    GetPage(
      name: AppRoutes.CHATROOM,
      page: () => ChatroomPage(),
      binding: ChatroomPageBinding(),
      middlewares: [AuthenticationRequired()],
    ),
    GetPage(
      name: AppRoutes.CONTENT_DETAIL,
      page: () => ContentDetailpage(),
      binding: ClubDetailBinding(),
      middlewares: [AuthenticationRequired()],
    ),
    GetPage(
      name: AppRoutes.PRODUCT_SETTINGS,
      page: () => ProductSettingPage(),
      binding: ProductViewerBinding(),
      middlewares: [AuthenticationRequired()],
    ),
    GetPage(
      name: AppRoutes.MY_PROFILE,
      page: () => MyProfilePage(),
      middlewares: [AuthenticationRequired()],
    ),
    GetPage(
      name: "${AppRoutes.USER_PROFILE}/:userId",
      page: () => UserProfilePage(),
      middlewares: [AuthenticationRequired()],
    ),
    GetPage(
      name: AppRoutes.SETTINGS,
      page: () => SettingPage(),
      middlewares: [AuthenticationRequired()],
    ),
    GetPage(
      name: AppRoutes.PROFILE_EDITOR,
      page: () => ProfileEditorPage(),
      binding: ProfileEditorBinding(),
      middlewares: [AuthenticationRequired()],
    ),
    GetPage(
      name: AppRoutes.WEBVIEW,
      page: () => ServiceCenterWebviewPage(),
    )
  ];
}
