import 'package:circle_nav_bar/circle_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fortnite_flutter/core/theme/fortnite_theme.dart';
import 'package:fortnite_flutter/presentation/cubits/auth/auth_cubit.dart';
import 'package:fortnite_flutter/presentation/cubits/auth/auth_state.dart';
import 'package:fortnite_flutter/presentation/pages/profile/profile_page.dart';
import 'package:fortnite_flutter/presentation/pages/shop/shop_page.dart';
import 'package:fortnite_flutter/presentation/pages/transactions/transactions_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const ShopPage(),
    const ProfilePage(),
    const TransactionsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthUnauthenticated) {
          // Navigate to login when unauthenticated
          Navigator.of(context).pushReplacementNamed('/login');
        }
      },
      child: Scaffold(
        backgroundColor: FortniteTheme.darkBackground,
        body: IndexedStack(index: _currentIndex, children: _pages),
        bottomNavigationBar: CircleNavBar(
          activeIcons: const [
            Icon(Icons.store, color: Colors.white),
            Icon(Icons.person, color: Colors.white),
            Icon(Icons.receipt_long, color: Colors.white),
          ],
          inactiveIcons: [
            Text('Loja', style: TextStyle(color: FortniteTheme.textPrimary)),
            Text('Perfil', style: TextStyle(color: FortniteTheme.textPrimary)),
            Text(
              'Histórico',
              style: TextStyle(color: FortniteTheme.textPrimary),
            ),
          ],
          color: FortniteTheme.darkBackground,
          circleColor: FortniteTheme.primaryPurple,
          height: 60,
          circleWidth: 60,
          padding: const EdgeInsets.only(left: 16, right: 16, bottom: 20),
          cornerRadius: const BorderRadius.only(
            topLeft: Radius.circular(8),
            topRight: Radius.circular(8),
            bottomRight: Radius.circular(24),
            bottomLeft: Radius.circular(24),
          ),

          circleShadowColor: FortniteTheme.primaryPurple,
          elevation: 10,
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              FortniteTheme.primaryPurple,
              FortniteTheme.primaryPurple,
              FortniteTheme.primaryBlue,
            ],
          ),
          circleGradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [FortniteTheme.primaryPurple, FortniteTheme.primaryBlue],
          ),
          activeIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
        ),
      ),
    );
  }
}
