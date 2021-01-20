import 'package:carrot_market/app.dart';
import 'package:carrot_market/provider/item_provider.dart';
import 'package:carrot_market/screen/additem/additem_screen.dart';
import 'package:carrot_market/screen/detail_screen/detail_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screen/homescreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: ItemProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        home: App(),
        routes: {
          DetailItem.id: (context) => DetailItem(),
          AddItem.id: (context) => AddItem(),
        },
      ),
    );
  }
}
