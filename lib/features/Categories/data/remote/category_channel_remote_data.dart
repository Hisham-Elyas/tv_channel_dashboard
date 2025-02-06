import 'dart:developer';

import '../../../../core/networking/api_client.dart';
import '../../../../core/networking/api_constants.dart';
import '../../../../core/networking/exception.dart';
import '../models/category_channels_model.dart';
import '../models/category_model.dart';

abstract class CategoryRemoteDate {
  Future getAllCategory();
  Future getAllChannelInCategoryById({required String categoryId});
}

class CategoryRemoteDateImplHttp implements CategoryRemoteDate {
  final ApiClent apiClent;

  CategoryRemoteDateImplHttp({required this.apiClent});
  @override
  Future<List<Category>> getAllCategory() async {
    final resalt = await apiClent.getData(
        uri: ApiConstants.apiBaseUrl + ApiConstants.categories);
    if (resalt.statusCode == 200) {
      final List<Category> category = Category.fromJsonList(resalt.body);
      return category;
    } else {
      log(resalt.body);
      throw ServerException(message: "${resalt.statusCode}");
    }
  }

  @override
  Future<CategoryChannels> getAllChannelInCategoryById(
      {required String categoryId}) async {
    final resalt = await apiClent.getData(
        //categories/:id/channels
        uri:
            '${ApiConstants.apiBaseUrl}${ApiConstants.categories}/$categoryId${ApiConstants.channels}');
    if (resalt.statusCode == 200) {
      final CategoryChannels channellist =
          CategoryChannels.fromJson(resalt.body);
      return channellist;
    } else {
      log(resalt.body);
      throw ServerException(message: "${resalt.statusCode}");
    }
  }
}
