// @dart=2.9





import 'dart:convert';
import 'dart:typed_data';

import 'package:enstaller/core/constant/app_colors.dart';
import 'package:enstaller/core/constant/size_config.dart';
import 'package:flutter/material.dart';
import 'image_full_view.dart';

class ShowBase64Image extends StatefulWidget {
  final String base64String;
  final bool applyStyle;

  ShowBase64Image({this.base64String, this.applyStyle: false});

  @override
  _ShowBase64ImageState createState() => _ShowBase64ImageState();
}

class _ShowBase64ImageState extends State<ShowBase64Image> {
  Uint8List bytesImage;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    try {
      Uint8List _bytesImage = Base64Decoder().convert(widget.base64String);
      setState(() {
        bytesImage = _bytesImage;
      });
    } catch (e) {
      setState(() {
        bytesImage = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return bytesImage != null
        ? GestureDetector(
            onTap: () {
              print('Image tapped');
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          ImageFullView(image: MemoryImage(bytesImage))));
            },
            child: widget.applyStyle
                ? Container(
                    width: 140.0,
                    height: 140.0,
                    decoration: new BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                            color: AppColors.lightGreyColor, width: 1.0),
                        image: DecorationImage(
                            image: MemoryImage(bytesImage), fit: BoxFit.cover)),
                  )
                : Container(
                    height: 100,
                    width: SizeConfig.screenWidth,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: MemoryImage(bytesImage),
                            fit: BoxFit.contain)),
                  ),
          )
        : Container();
  }
}
