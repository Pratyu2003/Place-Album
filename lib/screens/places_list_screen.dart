import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './add_place_screen.dart';
import '../providers/great_places.dart';
import './place_detail_screen.dart';

class PlacesListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Text('Your Places'),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.add_box),
              color: Color.fromARGB(255, 13, 194, 107),
              autofocus: true,
              iconSize: 40,
              alignment: Alignment.centerRight,
              splashColor: Colors.yellow,
              onPressed: () {
                Navigator.of(context).pushNamed(AddPlaceScreen.routeName);
              },
            ),
          ],
        ),
        body: FutureBuilder(
          future: Provider.of<GreatPlaces>(context, listen: false)
              .fetchAndSetPlaces(),
          builder: (ctx, snapshot) => snapshot.connectionState ==
                  ConnectionState.waiting
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Consumer<GreatPlaces>(
                  child: Container(
                    alignment: Alignment.center,
                      child: Image.asset(
                    'dev_assets/image.jpg',
                    fit: BoxFit.cover,
                  )),
                  builder: (ctx, greatPlaces, ch) => greatPlaces.items.length <=
                          0
                      ? ch
                      : ListView.builder(
                          itemCount: greatPlaces.items.length,
                          itemBuilder: (ctx, i) {
                            return Card(
                              color: Color.fromARGB(236, 243, 238, 238),
                              elevation: 10,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25)),
                              margin: EdgeInsets.symmetric(
                                  vertical: 15, horizontal: 15),
                              child: ListTile(
                                leading: CircleAvatar(
                                  radius: 40,
                                  backgroundImage: FileImage(
                                    greatPlaces.items[i].image,
                                  ),
                                ),
                                title: Text(greatPlaces.items[i].title,
                                    style: TextStyle(
                                      color: Colors.black54,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    )),
                                subtitle: Text(
                                    greatPlaces.items[i].location.address,
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 114, 114, 114),
                                      fontWeight: FontWeight.normal,
                                      fontSize: 12,
                                    )),
                                onTap: () {
                                  Navigator.of(context).pushNamed(
                                      PlaceDetailScreen.routeName,
                                      arguments: greatPlaces.items[i].id);
                                },
                              ),
                            );
                          },
                        ),
                ),
        ),
      ),
    );
  }
}
