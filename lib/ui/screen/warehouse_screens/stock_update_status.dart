// @dart=2.9
import 'package:enstaller/core/constant/app_colors.dart';
import 'package:enstaller/core/constant/appconstant.dart';
import 'package:enstaller/core/enums/view_state.dart';
import 'package:enstaller/core/model/send/answer_credential.dart';
import 'package:enstaller/core/model/stock_update_model.dart';
import 'package:enstaller/core/provider/base_view.dart';
import 'package:enstaller/core/viewmodel/warehouse_viewmodel/stock_update_status.dart';
import 'package:enstaller/ui/shared/appbuttonwidget.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:csv/csv.dart';
import 'dart:convert';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart';

class StockUpdateStatus extends StatefulWidget {
  @override
  _StockUpdateStatusState createState() => _StockUpdateStatusState();
}

class _StockUpdateStatusState extends State<StockUpdateStatus> {
  final form = GlobalKey<FormState>();

  int selectedradio;
  List<SerialList> _serialList = [];
  bool isSelectedValidCSV = false;

  final TextEditingController commentController = TextEditingController();

  @override
  void initState() {
    selectedradio = 0;
    super.initState();
  }

  _getBatchWidget(StockUpdateStatusViewModel model) {
    return Column(
      children: [
        Padding(
            padding: EdgeInsets.all(12.0),
            child: DropdownButtonFormField<String>(
              onChanged: (value) async {
                model.bValue = value;
                StockBatchModel stockBatchModel = model.stockBatchList
                    .firstWhere((element) => element.strBatchNumber == value);
                await model.getPallets(stockBatchModel.intBatchId);
                setState(() {});
              },
              decoration: InputDecoration(
                hintText: 'Select',
                labelText: 'Batch Selection',
              ),
              value: model.bValue,
              items: model.stockBatchListItems,
              onSaved: (val) {
                // widget.saveOrderLine.intContractId = int.parse(val);
              },
              validator: (val) {
                print('value is $val');
                if (val == null) return 'Please choose an option.';
                return null;
              },
            )),
        SizedBox(
          height: 8.0,
        ),
        if (model.bValue != null)
          Container(
            child: GridView.builder(
              padding: EdgeInsets.all(6.0),
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                  childAspectRatio: 3),
              itemCount: model.stockPalletList.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    setState(() {
                      model.stockPalletList[index].isSelected = true;
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(2.0),
                        color: model.stockPalletList[index].isSelected
                            ? AppColors.appThemeColor
                            : Colors.brown),
                    child: Center(
                      child: Text(
                        model.stockPalletList[index].strPalletId,
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        SizedBox(
          height: 8.0,
        ),
      ],
    );
  }

  Future<void> _readCSV() async {
    isSelectedValidCSV = false;
    FilePickerResult result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['csv'],
    );

    if (result != null && result.files.isNotEmpty) {
      String path = result.files.single.path;
      List<List<dynamic>> list = await loadingCsvData(path) ?? [];
      print("-----------------------");
      print(list);

      if (list.isNotEmpty) {
        if (list[0].isNotEmpty && list[0][0].toString().trim() == "Serial") {
          for (List<dynamic> row in list) {
            if (row.isNotEmpty && row[0].toString().trim() != "Serial") {
              _serialList.add(SerialList(serialNo: row[0].toString().trim()));
            }
          }
          isSelectedValidCSV = true;
          AppConstants.showSuccessToast(context, "File Data Saved");
        } else {
          AppConstants.showFailToast(context, "Incorrect File Format");
        }
      } else {
        AppConstants.showFailToast(context, "Incorrect File Format");
      }
    }
  }

  Future<List<List<dynamic>>> loadingCsvData(String path) async {
    final csvFile = new File(path).openRead();
    return await csvFile
        .transform(utf8.decoder)
        .transform(
          CsvToListConverter(),
        )
        .toList();
  }

  _getItemWidget(StockUpdateStatusViewModel model) {
    return Column(
      children: [
        SizedBox(
          height: 15.0,
        ),
        AppButton(
          onTap: () {
            _readCSV();
          },
          width: 200,
          height: 40,
          radius: 10,
          color: AppColors.appThemeColor,
          buttonText: "Choose CSV file",
          textStyle: TextStyle(color: Colors.white),
        ),
        SizedBox(
          height: 30.0,
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarIconBrightness: Brightness.light));
    return BaseView<StockUpdateStatusViewModel>(
      onModelReady: (model) => model.initializeData(),
      builder: (context, model, child) {
        return Scaffold(
            appBar: AppBar(
              brightness: Brightness.dark,
              backgroundColor: AppColors.appThemeColor,
              title: Text("Stock Update Status",
                  style: TextStyle(color: AppColors.whiteColor)),
              actions: [
                Row(
                  children: [
                    Text(
                      "Demo CSV",
                      style: TextStyle(color: Colors.white, fontSize: 12.0),
                    ),
                    IconButton(
                        icon: Icon(
                          Icons.download_rounded,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          model.onDownloadPressed(context);
                        }),
                  ],
                )
              ],
            ),
            body: model.state == ViewState.Busy
                ? AppConstants.circulerProgressIndicator()
                : RefreshIndicator(
                    onRefresh: () => Future.delayed(Duration.zero)
                        .whenComplete(() => model.initializeData()),
                    child: SingleChildScrollView(
                      physics: const ScrollPhysics(
                          parent: AlwaysScrollableScrollPhysics()),
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(12.0, 6.0, 12.0, 6.0),
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black),
                              borderRadius: BorderRadius.circular(6.0)),
                          child: Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: Form(
                              key: form,
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 20.0,
                                  ),
                                  Text("Updated By"),
                                  SizedBox(
                                    height: 20.0,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("By Batch"),
                                      Radio(
                                          value: 1,
                                          groupValue: selectedradio,
                                          onChanged: (val) {
                                            setState(() {
                                              selectedradio = val;
                                              model.strType = "Batch";
                                            });
                                          }),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("By Item"),
                                      Radio(
                                          value: 2,
                                          groupValue: selectedradio,
                                          onChanged: (val) {
                                            setState(() {
                                              selectedradio = val;
                                              model.strType = "Serial";
                                            });
                                          }),
                                    ],
                                  ),
                                  if (selectedradio == 1)
                                    _getBatchWidget(model),
                                  if (selectedradio == 2) _getItemWidget(model),
                                  SizedBox(
                                    height: 50.0,
                                  ),
                                  Padding(
                                      padding: EdgeInsets.all(12.0),
                                      child: DropdownButtonFormField<String>(
                                        onChanged: (value) {
                                          model.lValue = value;
                                          try {
                                            StockLocationModel
                                                stockLocationModel = model
                                                    .stockLocationList
                                                    .firstWhere((element) =>
                                                        element.locationName ==
                                                        value);
                                            model.lid =
                                                stockLocationModel.locationId;
                                          } catch (e) {
                                            print(e);
                                          }
                                        },
                                        decoration: InputDecoration(
                                          hintText: 'Select',
                                          labelText: 'Location Selection',
                                        ),
                                        value: model.lValue,
                                        items: model.stockLocationListItems,
                                        onSaved: (val) {
                                          // widget.saveOrderLine.intContractId = int.parse(val);
                                        },
                                        validator: (val) {
                                          print('value is $val');
                                          if (val == null)
                                            return 'Please choose an option.';
                                          return null;
                                        },
                                      )),
                                  SizedBox(
                                    height: 20.0,
                                  ),
                                  Padding(
                                      padding: EdgeInsets.all(12.0),
                                      child: DropdownButtonFormField<String>(
                                        onChanged: (value) {
                                          model.sValue = value;
                                          try {
                                            StockStatusModel stockStatusModel =
                                                model.stockStatusList
                                                    .firstWhere((element) =>
                                                        element.strStatusName ==
                                                        value);
                                            model.sid =
                                                stockStatusModel.intStatusId;
                                          } catch (e) {
                                            print(e);
                                          }
                                        },
                                        decoration: InputDecoration(
                                          hintText: 'Select',
                                          labelText: 'Status Selection',
                                        ),
                                        value: model.sValue,
                                        items: model.stockStatusListItems,
                                        onSaved: (val) {
                                          // widget.saveOrderLine.intContractId = int.parse(val);
                                        },
                                        validator: (val) {
                                          print('value is $val');
                                          if (val == null)
                                            return 'Please choose an option.';
                                          return null;
                                        },
                                      )),
                                  SizedBox(
                                    height: 40.0,
                                  ),
                                  Text("Comment"),
                                  SizedBox(
                                    height: 20.0,
                                  ),
                                  TextField(
                                    controller: commentController,
                                    decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(4.0))),
                                    maxLines: 5,
                                  ),
                                  SizedBox(
                                    height: 20.0,
                                  ),
                                  AppButton(
                                    onTap: () {
                                      if (model.strType != "Batch" &&
                                          isSelectedValidCSV == false) {
                                        AppConstants.showFailToast(
                                            context, "Please choose CSV file.");
                                        return;
                                      }
                                      if (form.currentState.validate()) {
                                        StockStatusSaveModel
                                            stockStatusSaveModel;

                                        if (model.strType == "Batch") {
                                          _serialList = [];

                                          model.stockPalletList
                                              .forEach((element) {
                                            if (element.isSelected) {
                                              _serialList.add(SerialList(
                                                  serialNo:
                                                      element.strPalletId));
                                            }
                                          });
                                        }

                                        stockStatusSaveModel =
                                            StockStatusSaveModel(
                                                intCreatedBy: int
                                                    .parse(
                                                        GlobalVar.warehosueID),
                                                intLocationId: model.lid,
                                                intStatusId: model.sid,
                                                strType: model.strType,
                                                intWarehouseUserId: int
                                                    .parse(
                                                        GlobalVar.warehosueID),
                                                strComments: commentController
                                                    .text
                                                    .trim(),
                                                serialList: _serialList);
                                        model.save(
                                            context, stockStatusSaveModel);
                                      } else {
                                        print("Not Validate");
                                      }
                                    },
                                    width: 100,
                                    height: 40,
                                    radius: 10,
                                    color: AppColors.appThemeColor,
                                    buttonText: "Save",
                                    textStyle: TextStyle(color: Colors.white),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ));
      },
    );
  }
}
