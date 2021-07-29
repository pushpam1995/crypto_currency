import 'package:cryptocurrencies/favoritelistadd.dart';
import 'package:cryptocurrencies/fetchdatafromserver/extractimageresponse.dart';
import 'package:cryptocurrencies/fetchdatafromserver/fetchservices.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../globaldata.dart';

class DetailsPAge extends StatefulWidget {
  GlobalData obj;

  DetailsPAge(this.obj);

  @override
  _DetailsPAgeState createState() => _DetailsPAgeState();
}

class _DetailsPAgeState extends State<DetailsPAge> {
  Future<ExtractImageResponse>? _futureFetchImage;
  late FavoriteListAdd listadd;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      _futureFetchImage = fetchCoinInfoImage(widget.obj.id.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
     listadd=Provider.of<FavoriteListAdd>(context);
    return Scaffold(
      body: Container(
        color: Colors.blue,
        height: double.infinity,
        width: double.infinity,
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.2,
              //color: Colors.blue,
              padding: EdgeInsets.all(MediaQuery.of(context).padding.top),
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    widget.obj.name,
                    style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  Text(
                    widget.obj.symbol,
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ],
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.8,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(35.0),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: (_futureFetchImage != null)
                          ? buildFutureBuilder()
                          : CircleAvatar(
                              radius: 50,
                              backgroundImage: NetworkImage(
                                  'https://via.placeholder.com/140x100')),
                    ),
                    Container(
                      width: double.infinity,
                      margin: EdgeInsets.fromLTRB(10, 30, 10, 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Card(
                              elevation: 1,
                              shadowColor: Colors.blue,
                              child: Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(45, 15, 45, 15),
                                child: Text(
                                  "${widget.obj.name}",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blue),
                                ),
                              ),),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("Scince",style: TextStyle(color: Colors.grey,fontSize: 20),),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("${widget.obj.firstHistoricalData}",style: TextStyle(color: Colors.grey,fontSize: 20),),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("To",style: TextStyle(color: Colors.grey,fontSize: 20),),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("${widget.obj.lastHistoricalData}",style: TextStyle(color: Colors.grey,fontSize: 20),),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("Rank : ${widget.obj.rank}",style: TextStyle(color: Colors.grey,fontSize: 20),),
                          )
                          /*Text("Symbol : ${widget.obj.symbol}",style: TextStyle(fontSize: 20),),
                      Text("Rank : ${widget.obj.rank}",style: TextStyle(fontSize: 20),),
                      Text("First Historical Data : ${widget.obj.firstHistoricalData}",style: TextStyle(fontSize: 20),),
                      Text("Last Historical Data : ${widget.obj.lastHistoricalData}",style: TextStyle(fontSize: 20),),*/
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {

          if(listadd.favoritelist.contains(widget.obj)){
            listadd.removeDataInFavoriteList(widget.obj);
          } else
            listadd.addDataInFavoriteList(widget.obj);
        },
        child:(listadd.favoritelist.contains(widget.obj))? Icon(Icons.favorite,color:Colors.red ,):Icon(Icons.favorite_border ,),
      ),
    );
  }

  FutureBuilder<ExtractImageResponse> buildFutureBuilder() {
    return FutureBuilder<ExtractImageResponse>(
      future: _futureFetchImage,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          snapshot.data!.data!.the5!.logo;
          return CircleAvatar(
              radius: 50,
              backgroundImage:
                  NetworkImage(snapshot.data!.data!.the5!.logo.toString()));
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }

        return const CircularProgressIndicator();
      },
    );
  }
}
