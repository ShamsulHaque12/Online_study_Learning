import 'package:get/get.dart';
import 'package:online_study/features/notification/model/notification_model.dart';

class NotificationController extends GetxController {
  // Sample notifications
  var notifications = <NotificationModel>[
    NotificationModel(message: "Lorem ipsum dolor sit amet consectetur. Cursus sit non diam."),
    NotificationModel(message: "Lorem ipsum dolor sit amet consectetur. Cursus sit non diam.", isNew: true),
    NotificationModel(message: "Lorem ipsum dolor sit amet consectetur. Cursus sit non diam.", isNew: true),
    NotificationModel(message: "Lorem ipsum dolor sit amet consectetur. Cursus sit non diam."),
  ].obs;
}
