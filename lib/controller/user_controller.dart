import 'package:get/get.dart';

enum AccountType { MANAGER, EMPLOYEE }

class UserController extends GetxController {
  AccountType accountType = AccountType.MANAGER;
}
