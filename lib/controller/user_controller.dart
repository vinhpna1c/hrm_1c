import 'package:get/get.dart';

enum AccountType { MANAGER, EMPLOYEE }

class UserController extends GetxController {
  String username = "";
  String password = "";

  AccountType accountType = AccountType.EMPLOYEE;
}
