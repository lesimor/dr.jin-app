// Package imports:
import 'dart:async';

import 'package:bookrabbit/environment.dart';
import 'package:bookrabbit/src/common/data/provider.dart';
import 'package:bookrabbit/src/common/data/respository.dart';
import 'package:bookrabbit/src/features/authentication/controllers/auth_controller.dart';
import 'package:bookrabbit/src/features/matches/models/reservation.dart';
import 'package:bookrabbit/src/utils/logger.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'dart:convert';

// Project imports:
import 'package:bookrabbit/src/features/matches/screens/chatroom/repository.dart';

class ChatroomPageController extends GetxController with StateMixin {
  final resourceRepository = ResourceRepository();
  ResourceProviderV2<ReservationInModel, ReservationOutModel>
      get reservationApi => resourceRepository.reservationApi;

  StreamController<List<ChatModel>?> streamController = StreamController();
  final ChatroomPageRepository repository = ChatroomPageRepository();
  final textInputController = TextEditingController();
  final FocusNode textInputFocus = FocusNode();
  late final WebSocketChannel? channel;

  final _channelId = Rx<String?>(null);
  set channelId(value) => this._channelId.value = value;
  get channelId => this._channelId.value;

  final _reservation = Rx<ReservationOutModel?>(null);
  set reservation(value) => this._reservation.value = value;
  get reservation => this._reservation.value;

  final _messages = RxList<ChatModel>();
  set messages(value) => this._messages.value = value;
  get messages => this._messages;

  ChatroomPageController();

  @override
  onInit() {
    ever(_channelId, (_) => establishSocketConnection(_ as String));
    ever(_channelId, (_) => fetchMessages(_ as String));
    super.onInit();
  }

  @override
  void dispose() {
    channel!.sink.close();
    super.dispose();
  }

  establishSocketConnection(String channelId) {
    change(null, status: RxStatus.loading());
    var url =
        'ws://${Environment().config.apiHost}/reservations/${channelId}/chats';
    logger.d(url);
    channel = WebSocketChannel.connect(
      Uri.parse(url),
    );
    logger.d('establishSocketConnection');
    change(null, status: RxStatus.success());
  }

  fetchMessages(String channelId) async {
    var messages = await repository.getChatList(channelId);
    streamController.add(messages);
  }

  appendMessage(String stringifiedJson) {
    var socket = SocketModel.fromJson(jsonDecode(stringifiedJson));
    if (socket.type == 'SEND') {}
    messages.add(socket);
    change(messages, status: RxStatus.success());
  }

  sendMessage(String message) {
    var authController = Get.find<AuthController>();
    channel!.sink.add(
      jsonEncode(
        {
          "type": "send",
          "data": {
            "content": message,
            "sender_uid": authController.currentUser?.id ?? ''
          }
        },
      ),
    );
  }

  Future<void> cancelReservation(String id) async {
    await reservationApi.deleteById(id);
  }
}
