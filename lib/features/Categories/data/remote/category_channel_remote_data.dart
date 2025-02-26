import 'dart:developer';

import '../../../../core/networking/api_client.dart';
import '../../../../core/networking/api_constants.dart';
import '../../../../core/networking/exception.dart';
import '../models/category_channels_model.dart';
import '../models/category_model.dart';
import '../models/category_whith_channel_model.dart';

abstract class CategoryRemoteDate {
  Future<List<CategoryWithChannels>> getAllCategorywithChannel();
  Future getAllCategory();
  Future<bool> createCategory({required String name});
  Future<bool> deleteCategory({required int categoryId});
  Future<bool> addChannelToCategory(
      {required int categoryId,
      required int channelId,
      required String channelName});
  Future<bool> addLinkeToChannelInCategory(
      {required int categoryId,
      required int channelId,
      required String linkName,
      required String linkUrl});
  Future<bool> removeLinkInChannelInCategory(
      {required int categoryId,
      required int channelId,
      required String linkUrl});
  Future<bool> removeChannelFromCategory(
      {required int categoryId, required int channelId});
  Future getAllChannelInCategoryById({required int categoryId});
  Future<bool> updateCategory(
      {required int categoryId, required String newName});
}

class CategoryRemoteDateImplHttp implements CategoryRemoteDate {
  final ApiClent apiClent;

  CategoryRemoteDateImplHttp({required this.apiClent});

  @override
  Future<List<CategoryWithChannels>> getAllCategorywithChannel() async {
    final resalt = await apiClent.getData(
        uri: ApiConstants.apiBaseUrl +
            ApiConstants.categories +
            ApiConstants.allCategoriesWithChannels);
    if (resalt.statusCode == 200) {
      final List<CategoryWithChannels> category =
          CategoryWithChannels.fromJsonList(resalt.body);
      return category;
    } else {
      log(resalt.body.toString());
      throw ServerException(message: "${resalt.statusCode}");
    }
  }

  @override
  Future<List<Category>> getAllCategory() async {
    final resalt = await apiClent.getData(
        uri: ApiConstants.apiBaseUrl + ApiConstants.categories);
    if (resalt.statusCode == 200) {
      final List<Category> category = Category.fromJsonList(resalt.body);
      return category;
    } else {
      log(resalt.body.toString());
      throw ServerException(message: "${resalt.statusCode}");
    }
  }

  @override
  Future<CategoryChannels> getAllChannelInCategoryById(
      {required int categoryId}) async {
    final resalt = await apiClent.getData(
        //categories/:id/channels

        uri:
            '${ApiConstants.apiBaseUrl}${ApiConstants.categories}/$categoryId${ApiConstants.channels}');
    if (resalt.statusCode == 200) {
      final CategoryChannels channellist =
          CategoryChannels.fromJson(resalt.body);
      return channellist;
    } else {
      log(resalt.body.toString());
      throw ServerException(message: "${resalt.statusCode}");
    }
  }

  @override
  Future<bool> addChannelToCategory(
      {required int categoryId,
      required int channelId,
      required String channelName}) async {
    final resalt = await apiClent.posData(
        body: {
          "categoryId": categoryId,
          "channelId": channelId,
          "channelName": channelName,
        },

        ///api/categories/addChannel

        uri:
            '${ApiConstants.apiBaseUrl}${ApiConstants.categories}${ApiConstants.addChannel}');
    if (resalt.statusCode == 201) {
      return true;
    } else {
      log(resalt.body.toString());
      throw ServerException(message: "${resalt.statusCode}");
    }
  }

  @override
  Future<bool> addLinkeToChannelInCategory(
      {required int categoryId,
      required int channelId,
      required String linkName,
      required String linkUrl}) async {
    final resalt = await apiClent.posData(
        body: {
          "categoryId": categoryId,
          "channelId": channelId,
          "linkName": linkName,
          "linkUrl": linkUrl,
        },

        ///api/categories/channel/link

        uri:
            '${ApiConstants.apiBaseUrl}${ApiConstants.categories}${ApiConstants.channelLink}');
    if (resalt.statusCode == 201) {
      return true;
    } else {
      log(resalt.body.toString());
      throw ServerException(message: "${resalt.statusCode}");
    }
  }

  @override
  Future<bool> removeLinkInChannelInCategory(
      {required int categoryId,
      required int channelId,
      required String linkUrl}) async {
    final resalt = await apiClent.deleteData(
        body: {
          "categoryId": categoryId,
          "channelId": channelId,
          "linkUrl": linkUrl,
        },

        ///api/categories/channel/link

        uri:
            '${ApiConstants.apiBaseUrl}${ApiConstants.categories}${ApiConstants.channelLink}');
    if (resalt.statusCode == 201) {
      return true;
    } else {
      log(resalt.body.toString());
      throw ServerException(message: "${resalt.statusCode}");
    }
  }

  @override
  Future<bool> createCategory({required String name}) async {
    final resalt = await apiClent.posData(
        uri: ApiConstants.apiBaseUrl + ApiConstants.categories,
        body: {"name": name});
    if (resalt.statusCode == 201) {
      return true;
    } else {
      log(resalt.body.toString());
      throw ServerException(message: "${resalt.statusCode}");
    }
  }

  @override
  Future<bool> deleteCategory({required int categoryId}) async {
    final resalt = await apiClent.deleteData(
      uri: "${ApiConstants.apiBaseUrl}${ApiConstants.categories}/$categoryId",
    );
    if (resalt.statusCode == 200) {
      return true;
    } else {
      log(resalt.body.toString());
      throw ServerException(message: "${resalt.statusCode}");
    }
  }

  @override
  Future<bool> updateCategory(
      {required int categoryId, required String newName}) async {
    final resalt = await apiClent.putData(
        uri: "${ApiConstants.apiBaseUrl}${ApiConstants.categories}/$categoryId",
        body: {"name": newName});
    if (resalt.statusCode == 200) {
      return true;
    } else {
      log(resalt.body.toString());
      throw ServerException(message: "${resalt.statusCode}");
    }
  }

  @override
  Future<bool> removeChannelFromCategory(
      {required int categoryId, required int channelId}) async {
    final resalt = await apiClent.deleteData(
      uri:
          "${ApiConstants.apiBaseUrl}${ApiConstants.categories}/${categoryId.toString()}${ApiConstants.channels}/${channelId.toString()}",
    );
    if (resalt.statusCode == 200) {
      return true;
    } else {
      log(resalt.body.toString());
      throw ServerException(message: "${resalt.statusCode}");
    }
  }
}
