import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// navigator  system is coded with flutter riverpod
class my_navigator_bar extends ConsumerWidget {
  const my_navigator_bar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pageIndex = ref.watch(pageIndexProvider);
    return BottomNavigationBar(
      items: [
        BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Kayıt Ol",
            backgroundColor: Colors.blue),
        BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Giriş Yap",
            backgroundColor: Colors.blue),
      ],
      currentIndex: pageIndex,
      onTap: (index) {
        ref.read(pageIndexProvider.notifier).state = index;
      },
    );
  }
}

final pageIndexProvider = StateProvider<int>((ref) => 0);
