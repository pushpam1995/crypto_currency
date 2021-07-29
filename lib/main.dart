import 'package:cryptocurrencies/favoritelistadd.dart';
import 'package:cryptocurrencies/screen/favorite.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'screen/currentcurrencies.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]).then((_) {
    runApp(CryPtoCurrencies());
  });

}

class CryPtoCurrencies extends StatelessWidget {
  const CryPtoCurrencies({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<FavoriteListAdd>.value(
          value: FavoriteListAdd(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Crypto",
        home: DefaultTabController(
          length: 2,
          initialIndex: 0,
          child: Scaffold(
            appBar: AppBar(
              elevation: 0.0,
              centerTitle: true,
              title: Column(
                children: [
                  Text(
                    "Crypto Currencies",
                    style: TextStyle(fontSize: 20),
                  ),
                  Text(
                    "Currencies Report",
                    style: TextStyle(fontSize: 15),
                  ),
                ],
              ),
              bottom: TabBar(
                tabs: [
                  Tab(
                    icon: Icon(Icons.monetization_on_rounded),
                    text: "Current Currencies",
                  ),
                  Tab(
                    icon: Icon(Icons.favorite),
                    text: "Favorite",
                  ),
                ],
              ),
            ),
            body: TabBarView(
              children: [
                CurrentCurrencies(),
                Favorite(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
