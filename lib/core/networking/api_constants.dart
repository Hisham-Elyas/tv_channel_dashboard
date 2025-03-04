class ApiConstants {
  static const String apiBaseUrl = "http://172.105.81.117:3000/api";
  static const String groupsChannel = "/groups";

  static const String channels = "/channels";
  static const String addChannel = "/addChannel";
  static const String group = "/group";
  static const String categories = "/categories";
  static const String channelLink = "/channel/link";
  static const String todayMatches = "/today_matches";
  static const String allCategoriesWithChannels = "/all-with-channels";

  /// settings
  static const String settings = "/settings";
  static const String addSettings = "/add";
  static const String setAllowUse = "/set-allow-use";
  static const String getAllSettings = "/get-all-settings";
}

class ApiErrors {
  static const String badRequestError = "badRequestError";
  static const String noContent = "noContent";
  static const String forbiddenError = "forbiddenError";
  static const String unauthorizedError = "unauthorizedError";
  static const String notFoundError = "notFoundError";
  static const String conflictError = "conflictError";
  static const String internalServerError = "internalServerError";
  static const String unknownError = "unknownError";
  static const String timeoutError = "timeoutError";
  static const String defaultError = "defaultError";
  static const String cacheError = "cacheError";
  static const String noInternetError = "noInternetError";
  static const String loadingMessage = "loading_message";
  static const String retryAgainMessage = "retry_again_message";
  static const String ok = "Ok";
}
