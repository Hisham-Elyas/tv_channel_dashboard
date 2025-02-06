import 'package:flutter/widgets.dart';

/// Extension on [BuildContext] to navigate to a new screen.
extension Navigation on BuildContext {
  /// Push the route with the given name onto the navigator that most tightly
  /// encloses the given context.
  ///
  /// This method uses the [Navigator.pushNamed] method to navigate to the new route.
  ///
  /// - Parameters:
  ///   - routeName: The name of the route to push.
  ///   - arguments: Optional arguments to pass to the route.
  ///
  /// - Returns: A Future that completes to the result value passed to [Navigator.pop]
  ///   when the pushed route is popped off the navigator.
  Future<dynamic> pushNamed(String routeName, {Object? arguments}) {
    return Navigator.of(this).pushNamed(routeName, arguments: arguments);
  }

  /// Replace the top-most route on the navigator that most
  /// tightly encloses the given context with a new route.
  ///
  /// This method uses the [Navigator.pushReplacementNamed] method to
  /// replace the current route with the new route.
  ///
  /// - Parameters:
  ///   - routeName: The name of the route to push.
  ///   - arguments: Optional arguments to pass to the route.
  ///
  /// - Returns: A Future that completes to the result value passed to [Navigator.pop]
  ///   when the pushed route is popped off the navigator.
  Future<dynamic> pushReplacementNamed(String routeName, {Object? arguments}) {
    return Navigator.of(this)
        .pushReplacementNamed(routeName, arguments: arguments);
  }

  /// Push the route with the given name onto the navigator that most tightly
  /// encloses the given context, and remove all the previous routes until
  /// the predicate returns true.
  ///
  /// This method uses the [Navigator.pushNamedAndRemoveUntil] method to
  /// navigate to the new route and remove the previous routes.
  ///
  /// - Parameters:
  ///   - routeName: The name of the route to push.
  ///   - arguments: Optional arguments to pass to the route.
  ///   - predicate: A function that returns true for routes that should remain
  ///     on the navigator.
  ///
  /// - Returns: A Future that completes to the result value passed to [Navigator.pop]
  ///   when the pushed route is popped off the navigator.
  Future<dynamic> pushNamedAndRemoveUntil(String routeName,
      {Object? arguments, required RoutePredicate predicate}) {
    return Navigator.of(this)
        .pushNamedAndRemoveUntil(routeName, predicate, arguments: arguments);
  }

  /// Pops the top-most route off the navigator that most tightly
  /// encloses the given context.
  ///
  /// This method uses the [Navigator.pop] method to remove the current
  /// route and return to the previous one in the navigation stack.
  void pop() => Navigator.of(this).pop();
}

/// Extension on [String] nullable type to provide utility methods.
extension StringExtension on String? {
  /// Checks if the string is null or empty.
  ///
  /// Returns `true` if the string is either `null` or an empty string (`""`).
  /// Otherwise, returns `false`.
  bool isNullOrEmpty() => this == null || this == "";
}

/// Extension on [List] nullable type to check if it is null or empty.
extension ListExtension<T> on List<T>? {
  /// Checks if the list is null or empty.
  ///
  /// Returns `true` if the list is null or empty, `false` otherwise.
  bool isNullOrEmpty() => this == null || this!.isEmpty;
}
