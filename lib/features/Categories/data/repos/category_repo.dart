import 'dart:developer';

import 'package:dartz/dartz.dart';

import '../../../../core/helpers/check_internet.dart';
import '../../../../core/helpers/enums.dart';
import '../../../../core/helpers/snackbar_error_message.dart';
import '../../../../core/networking/exception.dart';
import '../models/category_channels_model.dart';
import '../models/category_model.dart';
import '../remote/category_channel_remote_data.dart';

abstract class CategoryRepo {
  Future getAllCategory();
  Future getAllChannelInCategoryById({required String categoryId});
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
  Future<Either<StatusRequest, CategoryChannels>> getAllChannelInCategoryById(
      {required String categoryId}) async {
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
}
