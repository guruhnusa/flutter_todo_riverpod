import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sabani_tech_test/src/features/home/presentation/pages/home_page.dart';
import 'package:sabani_tech_test/src/features/main/presentation/controllers/selected_index_provider.dart';
import 'package:sabani_tech_test/src/features/main/presentation/widgets/nav_item.dart';
import 'package:sabani_tech_test/src/features/profile/presentation/pages/profile_page.dart';

class MainPage extends HookConsumerWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    int selectedIndex = ref.watch(selectedIndexNavBarProvider);

    final List<Widget> selectedPage = [
      const HomePage(),
      const ProfilePage(),
    ];
    void onItemTapped(int index) {
      ref.read(selectedIndexNavBarProvider.notifier).update((state) => index);
    }

    return Scaffold(
      extendBody: true,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: selectedPage[selectedIndex],
      bottomNavigationBar: IntrinsicHeight(
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 10,
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              NavItem(
                iconPath: Icons.home,
                label: 'Home',
                isActive: selectedIndex == 0,
                onTap: () => onItemTapped(0),
              ),
              NavItem(
                iconPath: Icons.person,
                label: 'Profile',
                isActive: selectedIndex == 1,
                onTap: () => onItemTapped(1),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
