import 'package:flutter/material.dart';
import 'features/home/presentation/screens/home_dashboard_screen.dart';
import 'features/home/presentation/screens/deliveries_list_screen.dart';
import 'features/home/presentation/screens/payments_dashboard_screen.dart';
import 'features/home/presentation/screens/analytics_screen.dart';
import 'features/home/presentation/screens/profile_screen.dart';
import 'features/onboarding/presentation/screens/splash_screen.dart';

class AppUserSession {
  static String activeRole = 'Farmer'; // Default to Farmer
}

void main() {
  runApp(const FarmGatePayApp());
}

class FarmGatePayApp extends StatelessWidget {
  const FarmGatePayApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FarmGate Pay',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF2E7D32),
          primary: const Color(0xFF2E7D32),
          secondary: const Color(0xFF10B981),
        ),
      ),
      home: const SplashScreen(),
    );
  }
}

class MainTabShell extends StatefulWidget {
  const MainTabShell({super.key});

  @override
  _MainTabShellState createState() => _MainTabShellState();
}

class _MainTabShellState extends State<MainTabShell> {
  int _currentIndex = 0;
  late final List<Widget> _screens;

  @override
  void initState() {
    super.initState();
    _screens = [
      HomeDashboardScreen(onNavigateToTab: _onNavigateToTab),
      DeliveriesListScreen(onBack: () => _onNavigateToTab(0)),
      PaymentsDashboardScreen(onBack: () => _onNavigateToTab(0)),
      AnalyticsScreen(onBack: () => _onNavigateToTab(0)),
      ProfileScreen(onBack: () => _onNavigateToTab(0)),
    ];
  }

  void _onNavigateToTab(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color(0xFF2E7D32),
        unselectedItemColor: Colors.grey,
        backgroundColor: Colors.white,
        elevation: 8,
        onTap: _onNavigateToTab,
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 11),
        unselectedLabelStyle: const TextStyle(fontSize: 10),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_shipping_outlined),
            activeIcon: Icon(Icons.local_shipping),
            label: 'Deliveries',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_balance_wallet_outlined),
            activeIcon: Icon(Icons.account_balance_wallet),
            label: 'Payments',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart_outlined),
            activeIcon: Icon(Icons.bar_chart),
            label: 'Analytics',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
