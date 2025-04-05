import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

WidgetRef? globalRef;
BuildContext? globalContext;

var currentScreenIndexProvider = StateProvider<int>((_) => 0);

var storeNameProvider = StateProvider<String>((_) => '');

var lastInvoicesExportDateProvider = StateProvider<String>((_) => '');
