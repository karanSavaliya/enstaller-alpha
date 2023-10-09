import 'dart:io';

import 'package:flutter/material.dart';

class DeletableTag extends StatefulWidget {
  final String path;
  final VoidCallback onDelete;
  final bool isLoading;
  final List<bool> fileDownloadCheck;
  final int index;

  const DeletableTag({
    Key? key,
    required this.path,
    required this.onDelete,
    required this.isLoading,
    required this.fileDownloadCheck,
    required this.index,
  }) : super(key: key);

  @override
  State<DeletableTag> createState() => _DeletableTagState();
}

class _DeletableTagState extends State<DeletableTag> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal:3),
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(0),
          ),
          height: 90,
          width: 90,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                (widget.path.endsWith("pjp") || widget.path.endsWith("pjpeg") || widget.path.endsWith("jfif") || widget.path.endsWith("jpg") || widget.path.endsWith("jpeg") || widget.path.endsWith("png")) ? "assets/icon/img_image.png" : (widget.path.endsWith("doc") || widget.path.endsWith("docx")) ? "assets/icon/img_doc.png" :  widget.path.endsWith("pdf") ? "assets/icon/img_pdf.png" : (widget.path.endsWith("xls") || widget.path.endsWith("xlsx")) ? "assets/icon/img_xls.png" : "assets/icon/img_xls.png",
                width: 40,
                height: 40,
              ),
              SizedBox(width: 0),
              GestureDetector(
                onTap: widget.onDelete,
                child: Icon(
                  Icons.close,
                  size: 20,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
        ),
        widget.isLoading == true ? Positioned(
          child: widget.fileDownloadCheck[widget.index] == false ? SizedBox(height:10,width:10,child: CircularProgressIndicator()) : SizedBox(height:10,width:10,child: Icon(Icons.done)),
          bottom: 7,
          right: 7,
        ) : Container(),
      ],
    );
  }
}
