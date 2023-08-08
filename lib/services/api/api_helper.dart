//API URL
import 'package:dio/dio.dart';
import 'package:max_display_app/helper/dialog.dart';

import '../../widget/dialog_content.dart';

var urlImg = "https://www.rzfsoftware.com/member/admin/v1/upload-profile";
var url = "https://rzfkomputer.com/pos/api/v1/";
// var url = "http://192.168.100.31/rzf-pos-api/v1/";
// var url = "http://192.168.8.118/rzf-pos-api/v1/";
var authUrl = "login";
var productUrl = "product";
var categoryUrl = "category";
var customerUrl = "customer";
var tableUrl = "table";
var saleUrl = "sale";
var profileUrl = "profile";
var receiptUrl = "design-receipt";

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

dynamic getDataResponse(Response data) {
  var response = data.data;
  return response;
}

Future<bool> manageResponse(
  dynamic data, {
  bool success = false,
  bool error = true,
}) async {
  if (data is Response) {
    var response = data;
    return await _succesResponse(response, success);
  } else {
    var exception = data as DioException;
    return await _errorResponse(exception, error);
  }
}

Future<bool> _succesResponse(Response data, bool showMsg) async {
  var response = data.data;
  if (showMsg == true) {
    actionDialog(response['message']);
  }
  return true;
}

Future<bool> _errorResponse(DioException exception, bool showMsg) async {
  var response = exception.response?.data;
  if (response != null) {
    if (showMsg) {
      actionDialog(response["message"], actionDialog: ActionDialog.error);
    }
    return false;
  }
  if (exception.message != null) {
    actionDialog(exception.message!, actionDialog: ActionDialog.error);
    return false;
  } else {
    actionDialog(
      exception.error.toString(),
      actionDialog: ActionDialog.error,
    );
    return false;
  }
}
