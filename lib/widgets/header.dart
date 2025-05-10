

import 'package:bookhub_prjct/providers/theme_provider.dart';
import 'package:bookhub_prjct/services/auth_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class Header extends ConsumerWidget implements PreferredSizeWidget {
  final bool forceBackButton;

  const Header({super.key, this.forceBackButton = true});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider);

    return AppBar(
      leading: forceBackButton 
          ? IconButton(
              icon: const Icon(Icons.arrow_back, ),
              onPressed: () {
                print('Back button pressed, navigating back'); 
                context.go('/home');
              },
            )
          : null,
      title: const Text(
        'BookHUB',
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
      centerTitle: true,
      actions: [
         IconButton(
          icon: Icon(
            themeMode == ThemeMode.light ? Icons.dark_mode : Icons.light_mode,
          ),
          onPressed: () async {
            print('Toggling theme'); 
            await ref.read(themeModeProvider.notifier).toggleTheme();
          },
          tooltip: 'Toggle Theme',
        ),
        Stack(
          children: [
            IconButton(
              icon: const Icon(Icons.shopping_cart),
              onPressed: () {
                print('Navigating to CartScreen (/cart)'); // Debug logging
                context.go('/cart');
              },
              tooltip: 'View Cart',
            ),
           
          ],
        ),
        PopupMenuButton<String>(
          icon: const Icon(Icons.menu),
          onSelected: (value) async {
            switch (value) {
              case 'Top Rated':
                print('Navigating to Top Rated (/home)');
                context.go('/home');
                break;
              case 'Bookshelf':
                print('Navigating to Bookshelf (/search)'); 
                context.go('/search');
                break;
              case 'Logout':
                print('Logging out user'); 
                await AuthService().logout();
                context.go('/login');
                break;
          
            }
          },
          itemBuilder: (context) => [
            const PopupMenuItem(
              value: 'Top Rated',
              child: Text('Top Rated'),
            ),
            const PopupMenuItem(
              value: 'Bookshelf',
              child: Text('Bookshelf'),
            ),
            const PopupMenuItem(
              value: 'Logout',
              child: Text('Logout'),
            ),
          ],
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}