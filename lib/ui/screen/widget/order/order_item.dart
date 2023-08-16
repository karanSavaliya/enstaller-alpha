// @dart=2.9


import 'package:enstaller/core/constant/app_colors.dart';
import 'package:enstaller/core/constant/app_string.dart';
import 'package:enstaller/core/constant/size_config.dart';
import 'package:enstaller/core/model/save_order_line.dart';
import 'package:enstaller/ui/util/SearchPage.dart';
import 'package:enstaller/ui/util/dialog_util.dart';
import 'package:flutter/material.dart';
import 'package:select_form_field/select_form_field.dart';

typedef OnDelete();

class OrderItem extends StatefulWidget {

  final SaveOrderLine saveOrderLine;
  final OnDelete onDelete;
  final List<Map<String, dynamic>> itemList;
  final List<Map<String, dynamic>> contractList;
  final state = _OrderItemState();

  bool isValid() => state.validate();

  OrderItem(
      {Key key,
        this.saveOrderLine,
        this.onDelete,
        this.itemList,
        this.contractList})
      : super(key: key);

  @override
  _OrderItemState createState() => state;

}

class _OrderItemState extends State<OrderItem> {
  final form = GlobalKey<FormState>();
  var id = -1;
  var cValue;


  Future<String> showInformationDialog(BuildContext context) async {

    return await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Search Items'),
            content: SearchPage(widget.itemList),
            actions: [
              TextButton(
                child: Text('Close'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        }
    );
  }



  @override
  void initState() {
    super.initState();

    if (widget.saveOrderLine.intContractId != null)
      cValue = widget.saveOrderLine.intContractId.toString();

    if(widget.saveOrderLine.intItemId.toString() != "null") {

      String vlue = widget.itemList.where((element) =>
      element["value"].toString() == widget.saveOrderLine.intItemId.toString()).toList()[0]["label"];

      controller.text = vlue;

    }

  }

  TextEditingController controller = new TextEditingController();

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: SizeConfig.sidepadding / 2,
      child: Card(
        margin: SizeConfig.verticalBigPadding,
        elevation: 2,
        child: Form(
          key: form,
          child: Column(
            children: [
              Padding(
                  padding: SizeConfig.sidepadding,

                  child:Container(child:TextFormField(
                    obscureText: false,
                    readOnly: true,
                    controller: controller,
                    decoration: InputDecoration(
                      border: UnderlineInputBorder(),
                      labelText: 'Items',
                      hintText: 'Select Items',
                    ),
                    onTap:() async {

                      final res = await showInformationDialog(context);
                      controller.text = res.split("**")[0];

                      setState(() {
                        id = int.parse(res.split("**")[1]);
                        print("cValue ---======> 11111  "+res.split("**")[1]);
                        var value = '';
                        widget.itemList.forEach((element) {
                          if (element['value'] == res.split("**")[1]) {
                            value = element['intContractId'].toString();
                          }
                        });
                        print("cValue ---======> 2222 --> $value");
                        cValue = value;
                        widget.saveOrderLine.intItemId = int.parse(res.split("**")[1]);
                      });
                    },


                  ),)
              ),
              SizeConfig.verticalSpaceMedium(),
              Padding(
                  padding: SizeConfig.sidepadding,
                  child: DropdownButtonFormField<String>(
                    onChanged: null,
                    decoration: InputDecoration(
                      hintText: cValue ?? 'Select',
                      labelText: 'Contract',
                    ),
                    value: cValue,
                    items: cValue == null
                        ? []
                        : [
                      DropdownMenuItem<String>(
                        child: Text(widget.contractList.firstWhere(
                                (element) =>
                            element['value'] == cValue)['label']),
                        value: cValue.toString(),
                      )
                    ],
                    onSaved: (val) {
                      print('intContractId value is $val');
                      widget.saveOrderLine.intContractId = int.parse(val);
                    },
                    validator: (val) {
                      print('contract value is $val');
                      if (val == null) return 'Please choose an option.';
                      return null;
                    },
                  )),
              SizeConfig.verticalSpaceMedium(),
              Padding(
                padding: SizeConfig.sidepadding,
                child: Row(
                  children: [
                    Expanded(
                        child: TextFormField(
                          maxLength: 50,
                          initialValue:
                          widget.saveOrderLine.decQty?.toString() ?? '',
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: AppStrings.QUANTITY,
                            hintText: AppStrings.QUANTITY,
                          ),
                          validator: (value) {
                            if (value.trim().isEmpty) {
                              return 'Required';
                            } else
                              return null;
                          },
                          onChanged: (val) =>
                          widget.saveOrderLine.decQty = int.parse(val.trim()),
                          onSaved: (val) =>
                          widget.saveOrderLine.decQty = int.parse(val.trim()),
                        )),
                    SizeConfig.horizontalSpaceMedium(),
                    IconButton(
                        icon: Icon(
                          Icons.delete,
                          color: AppColors.red,
                        ),
                        onPressed: () {
                          DialogSnackBarUtils().showAlertDialog(
                              context: context,
                              title: 'Are you sure you want to delete?',
                              onPositiveButtonTab: () {
                                widget.onDelete();
                                Navigator.of(context).pop();
                              },
                              onNegativeButtonTab: () {
                                Navigator.of(context).pop();
                              },
                              negativeButton: 'No',
                              positiveButton: 'Yes');
                        }),
                  ],
                ),
              ),
              SizeConfig.verticalSpaceMedium(),
            ],
          ),
        ),
      ),
    );
  }

  bool validate() {
    var valid = form.currentState.validate();
    if (valid) form.currentState.save();

    return valid;
  }
}
