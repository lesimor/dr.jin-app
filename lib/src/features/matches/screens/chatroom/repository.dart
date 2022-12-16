import 'package:bookrabbit/src/common/data/provider.dart';
import 'package:bookrabbit/src/features/matches/models/reservation.dart';
import 'package:bookrabbit/src/utils/dio_client.dart';
import 'package:dio/dio.dart';

class ChatroomPageRepository
    extends ResourceProviderV2<ReservationInModel, ReservationOutModel> {
  ChatroomPageRepository({super.resourceName = 'reservations'});

  Future<List<ChatModel>?> getChatList(String id) async {
    var response = await DioClient().dio.get(
          "${generateUrl(resourceName)}/$id/chats",
          options: Options(
            headers: await generateHeader(),
          ),
        );
    return response.data.map<ChatModel>((e) => ChatModel.fromJson(e)).toList();
  }
}
