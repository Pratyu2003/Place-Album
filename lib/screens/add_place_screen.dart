import 'package:flutter/material.dart';
import '../widgets/image_input.dart';
import 'package:provider/provider.dart';
import '../providers/great_places.dart';
import '../widgets/location_input.dart';
import '../models/place.dart';
import 'dart:io';

class AddPlaceScreen extends StatefulWidget {
  static const routeName = '/add-place';

  @override
  _AddPlaceScreenState createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends State<AddPlaceScreen> {
  final _titleController = TextEditingController();
  File _pickedImage;

  PlaceLocation _placeLocation;

  void _selectImage(File pickedImage) {
    _pickedImage = pickedImage;
  }

  void _selectPlace(double lat, double lng) {
    _placeLocation = PlaceLocation(latitude: lat, longitude: lng);
  }

  void _savePlace() {
    if (_titleController.text.isEmpty || _pickedImage == null
    || _placeLocation == null) return;

    Provider.of<GreatPlaces>(context, listen: false)
      .addplace(_titleController.text, _pickedImage, _placeLocation);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
        gradient: LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight,
        colors: [const Color(0xFFFDFCFB),const Color(0xFFE2D1C3)]),
      ),
      child: Scaffold(
          backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Text('Add a New Place'),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    children: <Widget>[
                      TextField(
                        decoration: InputDecoration(
                          labelText: 'Title',
                          prefixIcon: Icon(Icons.title_outlined),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.horizontal(), ),),
                        controller: _titleController,
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      ImageInput(_selectImage),
                      SizedBox(
                        height: 5,
                      ),
                      LocationInput(_selectPlace),
                    ],
                  ),
                ),
              ),
            ),
            ElevatedButton.icon(
              icon: Icon(Icons.add, size: 50,),
              label: Text('Add Place'),
              onPressed: _savePlace,
              style: ElevatedButton.styleFrom(
                elevation: 0,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                primary: Theme.of(context).colorScheme.secondary,
                onPrimary: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
