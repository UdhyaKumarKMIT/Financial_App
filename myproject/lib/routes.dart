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
//  '/about': (context) => AboutPage(),
 // '/profile': (context) => ProfilePage(),
};
