// @dart=2.9
import 'package:enstaller/core/constant/app_colors.dart';
import 'package:flutter/material.dart';

class ElectricityTextFieldWidget extends StatefulWidget {
  final String hintText;
  final int maxLine;
  final int maxLength;
  final String keyboardType;
  final bool readOnly;
  final VoidCallback onTap;
  final TextEditingController controller;
  final String required;

  ElectricityTextFieldWidget({this.readOnly,this.hintText,this.maxLine,this.onTap,this.controller,this.keyboardType,this.maxLength,this.required});

  @override
  State<ElectricityTextFieldWidget> createState() => _ElectricityTextFieldWidgetState();
}

class _ElectricityTextFieldWidgetState extends State<ElectricityTextFieldWidget> {
  TextEditingController nullController = TextEditingController();

  bool _showError = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(widget.hintText,style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 2),
        TextFormField(
          maxLines: widget.maxLine == null ? 1 : widget.maxLine,
          onTap: widget.onTap,
          onSaved: (value){
            if(value.isEmpty){
              setState(() {
                _showError = true;
              });
            }
            else{
              setState(() {
                _showError = false;
              });
            }
          },
          readOnly: widget.readOnly == null ? false : widget.readOnly,
          keyboardType: widget.keyboardType == null ? TextInputType.text : widget.keyboardType == "none" ? TextInputType.none :TextInputType.number,
          maxLength: widget.maxLength == null ? 500 : widget.maxLength,
          controller: widget.controller == null ? nullController : widget.controller,
          decoration: InputDecoration(
            hintText: widget.hintText,
            counterText: "",
            isDense: true,
            focusedBorder:OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.appThemeColor),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.appThemeColor),
            ),
          ),
          onChanged: (value) {
            if(value.isEmpty){
              setState(() {
                _showError = true;
              });
            }
            else{
              setState(() {
                _showError = false;
              });
            }
          },
        ),
        if (widget.controller.text.toString().isEmpty && _showError && widget.required != null || widget.controller.text == ' ' || widget.controller.text.trim().isEmpty) Padding(
          padding: const EdgeInsets.fromLTRB(5, 5, 0, 2),
          child: Text('This field is required.', style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold,fontSize: 7)),
        ),
      ],
    );
  }
}