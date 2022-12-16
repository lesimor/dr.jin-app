// Package imports:
import 'package:get/get.dart';

// Project imports:
import 'package:bookrabbit/src/features/matches/screens/chat_list/repository.dart';

class ChatListPageController extends GetxController with StateMixin {
  final ChatListPageRepository repository = ChatListPageRepository();
  ChatListPageController();

  final _obj = ''.obs;
  set obj(value) => this._obj.value = value;
  get obj => this._obj.value;

  final _users = [].obs;

  get userList => this._users;
  set userList(value) => this._users.value = value;

  get users => this._users;

  @override
  onInit() {
    getData();
    super.onInit();
  }

  getData() {
    change(null, status: RxStatus.loading());
    change(null, status: RxStatus.success());
  }
}
