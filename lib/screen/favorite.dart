import 'package:cryptocurrencies/globaldata.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../favoritelistadd.dart';
import 'detailspage.dart';

class Favorite extends StatefulWidget {
  const Favorite({Key? key}) : super(key: key);

  @override
  _FavoriteState createState() => _FavoriteState();
}

class _FavoriteState extends State<Favorite> {
  void _openDetailsPage(GlobalData obj){
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => DetailsPAge(obj)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final FavoriteListAdd getlistoffav=Provider.of<FavoriteListAdd>(context);
    return Container(
      height: double.infinity,
      width: double.infinity,
      child: (getlistoffav.favoritelist.length!=0)?ListView.builder(
          itemCount: getlistoffav.favoritelist.length,
          itemBuilder: (context, index) {
            return GestureDetector(onTap:() =>_openDetailsPage(getlistoffav.favoritelist[index]),
              child: Card(
                  child: ListTile(
                title: Text(getlistoffav.favoritelist[index].name),
                trailing: Text(getlistoffav.favoritelist[index].symbol),
              ),),
            );
          }):Center(child: Text("No Favorite Currencies Yet, Please Add !",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.blue),),),
    );
  }
}
