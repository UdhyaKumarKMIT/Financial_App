import 'package:flutter/material.dart';
import 'screens/home_page.dart';
import 'screens/history_page.dart';
import 'screens/trade_page.dart';
import 'screens/about_page.dart';
import 'screens/ProfilePage.dart';
import 'screens/CoursePage.dart';
final Map<String, WidgetBuilder> appRoutes = {
  '/': (context) => MyHomePage(),
  '/history': (context) => HistoryPage(purchaseHistory: []),
  '/trade': (context) => TradePage(),
  '/about': (context) {
    final options = ModalRoute.of(context)?.settings.arguments as List<Map<String, dynamic>>;
    return AboutPage(options: options);
  },
  '/profile': (context) {
    
    return ProfilePage();
  },
   '/courses': (context) => CoursePage(),
};
