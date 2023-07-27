import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final localeProvider = Provider<Locale>((ref) {
  return ref.watch(selectedLocaleProvider);
});

final selectedLocaleProvider = StateProvider<Locale>((ref) {
  return Locale('tr'); // Set the default locale
});

class L10n {
  static final all = [
    const Locale('en'),
    const Locale('tr'),
  ];
}
