import 'package:flutter_riverpod/flutter_riverpod.dart';

var isLoginLoadingProvider = StateProvider<bool>((_) => false);
var isSignUpLoadingProvider = StateProvider<bool>((_) => false);
