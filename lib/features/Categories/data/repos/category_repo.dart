import 'dart:developer';

import 'package:dartz/dartz.dart';

import '../../../../core/helpers/check_internet.dart';
import '../../../../core/helpers/enums.dart';
import '../../../../core/helpers/snackbar_error_message.dart';
import '../../../../core/networking/exception.dart';
import '../models/category_channels_model.dart';
import '../models/category_model.dart';
import '../models/category_whith_channel_model.dart';
import '../remote/category_channel_remote_data.dart';

abstract class CategoryRepo {
  Future getAllCategory();
  Future<Either<StatusRequest, List<CategoryWithChannels>>>
      getAllCategorywithChannel();

  Future<bool> deleteCategory({required int categoryId});
  Future createCategory({required String name});
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

class CategoryRepoImpHttp implements CategoryRepo {
  final CategoryRemoteDateImplHttp categoryRemote;

  CategoryRepoImpHttp({required this.categoryRemote});

  @override
  Future<Either<StatusRequest, List<Category>>> getAllCategory() async {
    if (await checkInternet()) {
      try {
        final remotData = await categoryRemote.getAllCategory();

        log('from Server  ==>  Get All Category');

        return right(remotData);
      } on ServerException catch (e) {
        showErrorMessage(e.message);

        return left(StatusRequest.serverFailure);
      }
    } else {
      showNetworkError();
      return left(StatusRequest.serverFailure);
    }
  }

  @override
  Future<Either<StatusRequest, List<CategoryWithChannels>>>
      getAllCategorywithChannel() async {
    if (await checkInternet()) {
      try {
        final remotData = await categoryRemote.getAllCategorywithChannel();

        log('from Server  ==>  Get All Category With Channels');

        return right(remotData);
      } on ServerException catch (e) {
        showErrorMessage(e.message);

        return left(StatusRequest.serverFailure);
      }
    } else {
      showNetworkError();
      return left(StatusRequest.serverFailure);
    }
  }

  @override
  Future<Either<StatusRequest, CategoryChannels>> getAllChannelInCategoryById(
      {required int categoryId}) async {
    if (await checkInternet()) {
      try {
        final remotData = await categoryRemote.getAllChannelInCategoryById(
            categoryId: categoryId);

        log('from Server  ==>  Get All Channel in Category');

        return right(remotData);
      } on ServerException catch (e) {
        showErrorMessage(e.message);

        return left(StatusRequest.serverFailure);
      }
    } else {
      showNetworkError();
      return left(StatusRequest.serverFailure);
    }
  }

  @override
  Future<bool> createCategory({required String name}) async {
    if (await checkInternet()) {
      try {
        final result = await categoryRemote.createCategory(name: name);

        log('TO Server  ==>  Create Category');

        return result;
      } on ServerException catch (e) {
        showErrorMessage(e.message);

        return false;
      }
    } else {
      showNetworkError();
      return false;
    }
  }

  @override
  Future<bool> deleteCategory({required int categoryId}) async {
    if (await checkInternet()) {
      try {
        final result =
            await categoryRemote.deleteCategory(categoryId: categoryId);

        log('TO Server  ==> Delete Category');

        return result;
      } on ServerException catch (e) {
        showErrorMessage(e.message);

        return false;
      }
    } else {
      showNetworkError();
      return false;
    }
  }

  @override
  Future<bool> addChannelToCategory(
      {required int categoryId,
      required int channelId,
      required String channelName}) async {
    if (await checkInternet()) {
      try {
        final result = await categoryRemote.addChannelToCategory(
            categoryId: categoryId,
            channelId: channelId,
            channelName: channelName);

        log('TO Server  ==> Add Channel To Category');

        return result;
      } on ServerException catch (e) {
        showErrorMessage(e.message);

        return false;
      }
    } else {
      showNetworkError();
      return false;
    }
  }

  @override
  Future<bool> removeChannelFromCategory(
      {required int categoryId, required int channelId}) async {
    if (await checkInternet()) {
      try {
        final result = await categoryRemote.removeChannelFromCategory(
            categoryId: categoryId, channelId: channelId);

        log('TO Server  ==> Remove Channel From Category');

        return result;
      } on ServerException catch (e) {
        showErrorMessage(e.message);
        return false;
      }
    } else {
      showNetworkError();
      return false;
    }
  }

  @override
  Future<bool> updateCategory(
      {required int categoryId, required String newName}) async {
    if (await checkInternet()) {
      try {
        final result = await categoryRemote.updateCategory(
            categoryId: categoryId, newName: newName);

        log('TO Server  ==> update  Category');

        return result;
      } on ServerException catch (e) {
        showErrorMessage(e.message);
        return false;
      }
    } else {
      showNetworkError();
      return false;
    }
  }

  @override
  Future<bool> addLinkeToChannelInCategory(
      {required int categoryId,
      required int channelId,
      required String linkName,
      required String linkUrl}) async {
    if (await checkInternet()) {
      try {
        final result = await categoryRemote.addLinkeToChannelInCategory(
          categoryId: categoryId,
          channelId: channelId,
          linkName: linkName,
          linkUrl: linkUrl,
        );

        log('TO Server  ==>  add Linke To Channel In Category');

        return result;
      } on ServerException catch (e) {
        showErrorMessage(e.message);

        return false;
      }
    } else {
      showNetworkError();
      return false;
    }
  }

  @override
  Future<bool> removeLinkInChannelInCategory(
      {required int categoryId,
      required int channelId,
      required String linkUrl}) async {
    if (await checkInternet()) {
      try {
        final result = await categoryRemote.removeLinkInChannelInCategory(
          categoryId: categoryId,
          channelId: channelId,
          linkUrl: linkUrl,
        );

        log('TO Server  ==>  remove Link In Channel In Category');

        return result;
      } on ServerException catch (e) {
        showErrorMessage(e.message);

        return false;
      }
    } else {
      showNetworkError();
      return false;
    }
  }
}
