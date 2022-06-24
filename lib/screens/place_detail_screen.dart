import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/great_places.dart';
import 'map_screen.dart';

class PlaceDetailScreen extends StatelessWidget {
  static const routeName = '/place-detail';

  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context).settings.arguments;
    final selectedPlace =
        Provider.of<GreatPlaces>(context, listen: false).findById(id);
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight,
        colors: [const Color(0xFFA1C4FD),const Color(0xFFC2E9FB)]),
      ),
      child: Scaffold(
          backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Text(selectedPlace.title),
        ),

        body: Column(
          children: <Widget>[
            
          Container(  
          
            
          ),

          Container(
            margin: EdgeInsets.fromLTRB(10, 20, 10, 10),
            decoration: BoxDecoration(
                border: Border.all(color: Color.fromARGB(255, 63, 63, 63), width: 6),
                borderRadius: BorderRadius.circular(20)),
            alignment: Alignment.center,
            height: 350,
            width: double.infinity,
            child: Image.file(
              selectedPlace.image,
              fit: BoxFit.cover,
              width: double.infinity,
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Text(
            selectedPlace.location.address,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18, color: Colors.black45),
          ),
          SizedBox(
            height: 15,
          ),
          FlatButton(
            child: Text('View on Map',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                )),
            textColor: Theme.of(context).primaryColor,
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  fullscreenDialog: true,
                  builder: (ctx) => MapScreen(
                        initialLocation: selectedPlace.location,
                        isSelecting: false,
                      )));
            },
          ),
        ]),
      ),
    );
  }
}
