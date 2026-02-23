import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

//check internet connection
abstract interface class ConnectionChecker {
  Future<bool> get isConnectionHas;
}

class ConnectionCheckerImpl implements ConnectionChecker {
  final InternetConnection internetConnection;

  ConnectionCheckerImpl({required this.internetConnection});

  @override
  Future<bool> get isConnectionHas async =>
      await internetConnection.hasInternetAccess;
}
