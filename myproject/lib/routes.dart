import 'package:flutter/material.dart';
import 'screens/home_page.dart';
import 'screens/history_page.dart';
import 'screens/trade_page.dart';
import 'screens/about_page.dart';
import 'screens/profile_page.dart';

final Map<String, WidgetBuilder> appRoutes = {
  '/': (context) => MyHomePage(),
  '/history': (context) => HistoryPage(purchaseHistory: []),
  '/trade': (context) => TradePage(),
  '/about': (context) {
    final options = ModalRoute.of(context)?.settings.arguments as List<Map<String, dynamic>>;
    return AboutPage(options: options);  // Pass the options to AboutPage
  },
  '/profile': (context) {
    final options = ModalRoute.of(context)?.settings.arguments as List<Map<String, dynamic>>;
    return ProfilePage(options: options);
  }
};
