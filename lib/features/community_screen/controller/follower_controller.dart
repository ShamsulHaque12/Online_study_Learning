
import 'package:get/get.dart';
import '../../../core/app_icons.dart';
import '../../../core/app_images.dart';
import '../model/follower_model.dart';

class FollowerController extends GetxController {
  var followers = <FollowerModel>[].obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    followers.addAll([
      FollowerModel(
        image: AppImages.pakhi1,
        tittle: 'John Doe',
        subtile: 'Beginner',
        flag: AppImages.uk,
        icone: AppIcons.arrow,
      ),
      FollowerModel(
        image: AppImages.pakhi1,
        tittle: 'Jane Smith',
        subtile: 'Intermittent',
        flag: AppImages.uk,
        icone: AppIcons.arrow,
      ),
      FollowerModel(
        image: AppImages.putul,
        tittle: 'Jane Smith',
        subtile: 'Beginner',
        flag: AppImages.uk,
        icone: AppIcons.arrow,
      ),
      FollowerModel(
        image: AppImages.putul,
        tittle: 'Jane Smith',
        subtile: 'Beginner',
        flag: AppImages.uk,
        icone: AppIcons.arrow,
      ),
      FollowerModel(
        image: AppImages.putul,
        tittle: 'Jane Smith',
        subtile: 'Beginner',
        flag: AppImages.uk,
        icone: AppIcons.arrow,
      ),
    ]);
  }
}
