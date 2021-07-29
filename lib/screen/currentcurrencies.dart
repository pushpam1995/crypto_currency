import 'package:cryptocurrencies/fetchdatafromserver/extractresponse.dart';
import 'package:cryptocurrencies/fetchdatafromserver/fetchservices.dart';
import 'package:flutter/material.dart';

import '../globaldata.dart';
import 'detailspage.dart';

class CurrentCurrencies extends StatefulWidget {
  const CurrentCurrencies({Key? key}) : super(key: key);

  @override
  _CurrentCurrenciesState createState() => _CurrentCurrenciesState();
}

class _CurrentCurrenciesState extends State<CurrentCurrencies> {
  Future<ExtractResponse>? _futureResponse;

  void _openDetailsPage(GlobalData obj) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => DetailsPAge(obj)),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      _futureResponse = fetchCoinInfo();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: double.infinity,
        width: double.infinity,
        child: (_futureResponse != null)
            ? buildFutureBuilder()
            : Center(
                child: Container(
                child: Text("Fetching Data..."),
              )));
  }

  FutureBuilder<ExtractResponse> buildFutureBuilder() {
    return FutureBuilder<ExtractResponse>(
      future: _futureResponse,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          snapshot.data!.data![0].name;

          return ListView.builder(
              itemCount: snapshot.data!.data!.length,
              itemBuilder: (context, index) {
                String name = (snapshot.data!.data![index].name).toString();
                int? id = snapshot.data!.data![index].id;
                String symbol = (snapshot.data!.data![index].symbol).toString();
                String slug=(snapshot.data!.data![index].slug).toString();
                int? rank = snapshot.data!.data![index].rank;
                int? isActive = snapshot.data!.data![index].isActive;
                DateTime? firstHistoricalData=snapshot.data!.data![index].firstHistoricalData;
                DateTime? lastHistoricalData=snapshot.data!.data![index].lastHistoricalData;
                Platform? platform=snapshot.data!.data![index].platform;
                return GestureDetector(
                    onTap: () => _openDetailsPage(GlobalData(
                        id: id,
                        name: name,
                        symbol: symbol,
                        slug: slug,
                        rank: rank,
                        isActive: isActive,
                        firstHistoricalData: firstHistoricalData,
                        lastHistoricalData: lastHistoricalData,
                        platform: platform)),
                    child: Card(
                        child: ListTile(
                      title:
                          Text((snapshot.data!.data![index].name).toString()),
                      trailing:
                          Text((snapshot.data!.data![index].symbol).toString()),
                    )));
              });
        } else if (snapshot.hasError) {
          return Center(child: Text('${snapshot.error}'));
        }

        return Center(child: const CircularProgressIndicator());
      },
    );
  }
}
