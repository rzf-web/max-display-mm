//API URL
import 'package:dio/dio.dart';
import 'package:dio/dio.dart' as dio;
import 'package:get/get.dart';
import 'package:max_display_app/helper/dialog.dart';

var url = "";
var ip = "";
const port = "1934";
const testing = "/test";
const user = "/user";
const rack = "/rak";
const product = "/produk/maxdisplay";

//Function Helper
BaseOptions getOptionTimeOut(int seconds) {
  BaseOptions options = BaseOptions(
    receiveDataWhenStatusError: true,
    connectTimeout: Duration(seconds: seconds),
    receiveTimeout: Duration(seconds: seconds),
  );
  return options;
}

getHeader({Map<String, dynamic>? header}) {
  var dataHeader = {"Accept": "application/json"};

  if (header != null) {
    for (var key in header.keys) {
      dataHeader[key] = header[key];
    }
  }

  return dataHeader;
}

dynamic getDataResponse(dynamic data) {
  var response = (data as dio.Response).data;
  return response;
}

Future<bool> manageResponse(
  dynamic data, {
  bool success = false,
  bool error = true,
}) async {
  if (data is dio.Response) {
    var response = data;
    return await _succesResponse(response, success);
  } else {
    var exception = data as DioException;
    return await _errorResponse(exception, error);
  }
}

Future<bool> _succesResponse(dio.Response data, bool showMsg) async {
  var response = data.data;
  if (showMsg == true) {
    succesDialog(response['message'], () => Get.back());
  }
  return true;
}

Future<bool> _errorResponse(DioException exception, bool showMsg) async {
  var response = exception.response?.data;
  if (response != null) {
    if (showMsg) {
      warningDialog(response["message"], () => Get.back());
    }
    return false;
  }
  if (exception.message != null) {
    errorDialog(exception.message!, () => Get.back());
    return false;
  } else {
    errorDialog(exception.error.toString(), () => Get.back());
    return false;
  }
}
