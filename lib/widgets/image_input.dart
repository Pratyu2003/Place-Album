import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as syspaths;

class ImageInput extends StatefulWidget {
  final Function onSelectImage;
  ImageInput(this.onSelectImage);
  @override
  _ImageInputState createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File _storedImage;
  dynamic _pickImageError;
  final ImagePicker picker = ImagePicker();

  Future<void> getImage(ImageSource source, BuildContext ctx) async {
    final picker = ImagePicker();
    final PickedFile = await picker.getImage(source: source, maxWidth: 700);

    try {
      setState(() {
        if (PickedFile != null)
          _storedImage = File(PickedFile.path);
        else
          print('No image selected.');
      });

      Navigator.pop(ctx);
    } catch (error) {
      setState(() {
        _pickImageError = error;
        throw Exception();
      });
    }

    final appDir = await syspaths.getApplicationDocumentsDirectory();
    final fileName = path.basename(_storedImage.path);
    final savedImage = await _storedImage.copy('${appDir.path}/$fileName');
    widget.onSelectImage(savedImage);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          width: 200,
          height: 200,
          decoration: BoxDecoration(
            border: Border.all(width: 2, color: Colors.grey),
          ),
          child: _storedImage != null
              ? Image.file(
                  _storedImage,
                  fit: BoxFit.cover,
                  width: double.infinity,
                )
              : Text(
                  'No Image Taken',
                  textAlign: TextAlign.center,
                ),
          alignment: Alignment.center,
        ),
        SizedBox(
          width: 10,
        ),
        Expanded(
          child: FlatButton.icon(
              icon: Icon(Icons.camera_alt),
              label: Text('Take Picture'),
              textColor: Theme.of(context).primaryColor,
              onPressed: () async {
                await showDialog(
                    context: context,
                    builder: (ctx) => AlertDialog(
                          title: Text('Choose an Image'),
                          content: Text(
                              "Choose an Image from Gallery or take a picture"),
                          actions: [
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              child: TextButton(
                                  onPressed: () {
                                    getImage(ImageSource.gallery, ctx);
                                  },
                                  child: Text('Gallery')),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              child: TextButton(
                                  onPressed: () {
                                    getImage(ImageSource.camera, ctx);
                                  },
                                  child: Text('Camera')),
                            )
                          ],
                        ));
              }),
        ),
      ],
    );
  }
}
