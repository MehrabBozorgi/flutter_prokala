import 'package:dio/dio.dart';

class ErrorExceptions implements Exception {
  fromError(DioException dioError) {
    switch (dioError.type) {
      case DioExceptionType.connectionTimeout:
        return "مشکلی در اتصال شبکه شما وجود دارد";
      case DioExceptionType.connectionError:
        return "مشکلی در اتصال شبکه شما وجود دارد";
      case DioExceptionType.badCertificate:
        return "مشکلی در اتصال شبکه شما وجود دارد";
      case DioExceptionType.sendTimeout:
        return "مشکلی در اتصال شبکه شما وجود دارد";
      case DioExceptionType.receiveTimeout:
        return "مشکلی در اتصال شبکه شما وجود دارد";
      case DioExceptionType.badResponse:
        return handleError(dioError.response?.statusCode);
      case DioExceptionType.cancel:
        return "ارسال درخواست به سرور لغو شد";

      case DioExceptionType.unknown:
        return "اتصال به سرور به دلیل متصل نبودن به اینترنت انجام نشد";
    }
  }

  String handleError(int? statusCode) {
    switch (statusCode) {
      case 400:
        return 'درخواست ارسال شده به سرور نادرست می باشد';
      case 403:
        return 'درخواست ارسال شده به سرور نادرست می باشد';
      case 404:
        return 'درخواست شما یافت نشد';
      case 429:
        return 'درخواست های خیلی زیاد انجام شده 5 دقیقه صبر کنید';
      case 500:
        return 'سرور با یک شرایط غیرمنتظره مواجه شد که مانع از انجام درخواست شد.';
      default:
        return 'مشکلی پیش آمد';
    }
  }
}
