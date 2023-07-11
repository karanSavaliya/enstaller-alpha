// @dart=2.9

import 'dart:collection';

import 'package:enstaller/core/constant/app_colors.dart';
import 'package:enstaller/core/constant/app_string.dart';
import 'package:enstaller/core/constant/appconstant.dart';
import 'package:enstaller/core/constant/size_config.dart';
import 'package:enstaller/core/enums/view_state.dart';
import 'package:enstaller/core/model/appointmentDetailsModel.dart';
import 'package:enstaller/core/model/commentModel.dart';
import 'package:enstaller/core/provider/base_view.dart';
import 'package:enstaller/core/viewmodel/comment_dialog_viewmodel.dart';
import 'package:enstaller/ui/screen/widget/survey/error_widget.dart';
import 'package:enstaller/ui/shared/appbuttonwidget.dart';
import 'package:enstaller/ui/util/AppBuilder.dart';
import 'package:enstaller/ui/util/DeletableTag.dart';
import 'package:enstaller/ui/util/common_utils.dart';
import 'package:enstaller/ui/util/text_util.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import "package:collection/collection.dart";


class CommentDialogWidget extends StatefulWidget {
  final String appointmentID;
  CommentDialogWidget({this.appointmentID});
  @override
  _CommentDialogWidgetState createState() => _CommentDialogWidgetState();
}

class _CommentDialogWidgetState extends State<CommentDialogWidget> {


  List<Map<String, dynamic>> listfiles = [];
  double height = 0;

  bool isCheck = false;
  bool isLoadingCommentDetails = true;

  bool autoFoucs = false;
  FocusNode _textFieldFocusNode = FocusNode();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _textFieldFocusNode.unfocus();
    Future.delayed(const Duration(milliseconds: 2500), () {
      addData(model1);
    });
  }

  @override
  void dispose() {
    _textFieldFocusNode.dispose();
    super.dispose();
  }

  void _onButtonClick() {
    _textFieldFocusNode.unfocus();
  }

  Widget FilesPicked() {
    return Container(
        child: GridView.count(
          // Maximum width of each cell
          mainAxisSpacing: 10,
          // Spacing between cells vertically
          crossAxisSpacing: 10,
          crossAxisCount: 3,
          physics: NeverScrollableScrollPhysics(),
          childAspectRatio: 1,
          shrinkWrap: true,
          // Spacing between cells horizontally
          children: List.generate(
            listfiles.length, // Assuming 'myList' is the list of data
                (index) {
              return DeletableTag(
                  path: listfiles[index]["value"], onDelete: () {
                setState(() {
                  listfiles.removeAt(index);
                });
                if (listfiles.isEmpty) {
                  setState(() {
                    isCheck = false;
                  });
                }
              });
            },
          ),

        ));
  }

  Future<void> pickfile() async {
    _onButtonClick();
    final result = await FilePicker.getMultiFilePath(
        type: FileType.ANY,
        fileExtension: 'jpeg,jpg,png,doc,docx,pdf,xls,xlsx,jfif,pjpeg,pjp'
    );

    for (final element in result.values) {
      setState(() {
        print(element);
        listfiles.add({"value": element});
      });
    }

    setState(() {
      isCheck = true;
    });
    //print(listfiles.length.toString());
  }

  List<ExpansionPanel> listexpansionPanel_ = [];
  CommentDialogViewModel model1;
  Map<String, List<AppointmentAttachemnts>> list_map = new Map<String,
      List<AppointmentAttachemnts>>();


  List<Map<String, dynamic>> _items = [];

  List<Map<String, dynamic>> items = [];


  void addData(CommentDialogViewModel model) {
    model.appointmentDetails.asMap().forEach((index, element) {
      List<AppointmentAttachemnts> appointmentAttachemnts = [];

      appointmentAttachemnts.addAll(
          model.appointmentAttachemnts.where((elements) => elements
              .intDetailsId == element.intId).toList());
      //list_map[element.strComments] = appointmentAttachemnts;

      List<String> filepath = [];
      appointmentAttachemnts.forEach((element) {
        filepath.add(element.strFileName);
      });


      print(appointmentAttachemnts.length.toString());

      items.add({
        'id': index,
        'title': model.appointmentDetails[index].strComments,
        'description': filepath.join(","),
        'length': model.appointmentDetails.length.toString(),
        'isExpanded': false
      });
    });


    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        _items = items;
        isLoadingCommentDetails = false;
      });
    });
  }


  int indexcallback = 0;

  @override
  Widget build(BuildContext context) {
    return AppBuilder(builder: (context) {
      return BaseView<CommentDialogViewModel>(
        onModelReady: (model) => model.getComments2(widget.appointmentID),
        builder: (context, model, child) {
          model1 = model;
          if (model.state == ViewState.Busy) {
            return AppConstants.circulerProgressIndicator();
          } else {
            return SingleChildScrollView(child: Container(

              constraints: BoxConstraints(
                minHeight: 0,
                maxHeight: double.infinity,
              ),
              color: AppColors.whiteColor,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(7),
                          topLeft: Radius.circular(7)),
                      color: AppColors.appThemeColor,
                    ),
                    child: Padding(
                      padding: SizeConfig.padding,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(AppStrings.APPOINTMENT_COMMENTS,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16.0)),
                          InkWell(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Icon(
                                Icons.clear,
                                color: AppColors.whiteColor,
                              ))
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: SizeConfig.sidepadding,
                    child: Text(AppStrings.addComment),
                  ),
                  SizeConfig.verticalSpaceSmall(),
                  Padding(
                    padding: SizeConfig.sidepadding,
                    child: Container(
                      decoration:
                      BoxDecoration(color: AppColors.veryLightGrayColor),
                      child: TextFormField(
                          focusNode: _textFieldFocusNode,
                          onChanged: (text) {
                            print('First text field: $text');
                          },
                          maxLines: 10,
                          autofocus: autoFoucs,
                          controller: model.commentController,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.fromLTRB(
                                MediaQuery
                                    .of(context)
                                    .size
                                    .width * 0.02,
                                MediaQuery
                                    .of(context)
                                    .size
                                    .height * 0.02,
                                MediaQuery
                                    .of(context)
                                    .size
                                    .height * 0.02,
                                MediaQuery
                                    .of(context)
                                    .size
                                    .width * 0.02,
                              ),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(
                                    0.0,
                                  )),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.transparent,
                                    width: 0.0,
                                  ),
                                  borderRadius: BorderRadius.circular(
                                    0.0,
                                  )),
                              hintText: "Type Comment",
                              errorStyle: TextStyle(color: Colors.red),
                              suffixIcon: true == false ? Icon(
                                  Icons.keyboard_arrow_down) : null),
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter text';
                            } else {
                              return null;
                            }
                          }),
                    ),
                  ),
                  SizedBox(height: 10),
                  Padding(
                    padding: SizeConfig.sidepadding,
                    child: AppButton(
                      height: SizeConfig.screenHeight * .05,
                      radius: 20,
                      color: AppColors.appThemeColor,
                      buttonText: AppStrings.PickFile,
                      textStyle: TextStyle(
                          color: AppColors.whiteColor,
                          fontWeight: FontWeight.bold),
                      onTap: () {
                        pickfile();
                        // model.addComments(context , widget.appointmentID , model.commentController.text.toString());
                      },
                    ),
                  ),
                  isCheck == true ? SizedBox(height: 10) : Container(),
                  isCheck == true ? Padding(
                    padding: SizeConfig.sidepadding,
                    child: FilesPicked(),
                  ) : Container(),
                  SizedBox(height: 10),
                  Padding(
                    padding: SizeConfig.sidepadding,
                    child: AppButton(
                      height: SizeConfig.screenHeight * .05,
                      radius: 20,
                      color: AppColors.appThemeColor,
                      buttonText: AppStrings.submit,
                      textStyle: TextStyle(
                          color: AppColors.whiteColor,
                          fontWeight: FontWeight.bold),
                      onTap: () async {
                        _onButtonClick();
                        if (model.commentController.text
                            .toString()
                            .length > 0 && listfiles.length > 0) {
                          model.addComments(context, widget.appointmentID,
                              model.commentController.text.toString(),
                              listfiles);
                          if (model.showErrorMessage == false) {
                            setState(() {
                              AppConstants.showSuccessToast(
                                  context, "Wait a Few seconds...");
                              isCheck = false;
                            });
                          }
                          else {
                            AppConstants.showFailToast(
                                context, AppStrings.emptyFieldMessage);
                          }
                          if (model.state == ViewState.Idle) {
                            print(model.response_body);
                          }
                        } else {
                          AppConstants.showFailToast(context,
                              "Comments and Files both should be added");
                        }
                        // model.addComments(context , widget.appointmentID , model.commentController.text.toString());
                      },
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  items.length != 0 ? Padding(
                    padding: SizeConfig.sidepadding,
                    child: Text(
                      AppStrings.appointmentCommentDetails,
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                  ) : Container(),
                  SizedBox(
                    height: 10,
                  ),
                  isLoadingCommentDetails == true
                      ? LinearProgressIndicator()
                      : ExpansionPanelList(
                      expansionCallback: (panelIndex, isExpanded) {
                        _onButtonClick();
                        setState(() {
                          for (int i = 0; i < _items.length; i++) {
                            if (i == panelIndex) {
                              _items[i]['isExpanded'] = !isExpanded;
                            } else {
                              _items[i]['isExpanded'] = false;
                            }
                          }
                        });
                      },
                      children: _items
                          .asMap()
                          .entries
                          .map((item1) {
                        int index = item1.key;
                        return ExpansionPanel(
                          headerBuilder: (context, isOpen) {
                            return Padding(
                                padding: EdgeInsets.all(15),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 25,
                                      height: 25,
                                      child: Center(child: Text("${index + 1}",
                                        style: TextStyle(
                                            color: AppColors.whiteColor),)),
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: AppColors.appThemeColor),
                                    ),
                                    SizedBox(width: 7),
                                    Text(item1.value["title"],
                                      style: TextStyle(fontSize: 16),),
                                  ],
                                )
                            );
                          },
                          body: Container(
                              child: ListView.builder(
                                itemCount: item1.value["description"]
                                    .toString()
                                    .split(",")
                                    .length,
                                physics: NeverScrollableScrollPhysics(),
                                itemBuilder: (BuildContext context, int index) {
                                  return Row(
                                    children: [
                                      Container(
                                        height: 50,
                                        width: MediaQuery
                                            .of(context)
                                            .size
                                            .width / 6,
                                        child: Padding(
                                          padding: const EdgeInsets.all(10),
                                          child: GestureDetector(onTap: () {
                                            CommonUtils().downloadFile(
                                                "https://enstall.boshposh.com/Upload/Appointment/" +
                                                    item1.value["description"]
                                                        .toString()
                                                        .split(",")[index],
                                                filename: item1
                                                    .value["description"]
                                                    .toString()
                                                    .split(",")[index]);
                                          },
                                            child: Container(key: UniqueKey(),
                                              child: Image.asset(
                                                (item1.value["description"]
                                                    .toString()
                                                    .split(",")[index].endsWith(
                                                    "jpg") ||
                                                    item1.value["description"]
                                                        .toString()
                                                        .split(",")[index]
                                                        .endsWith("jpeg") ||
                                                    item1.value["description"]
                                                        .toString()
                                                        .split(",")[index]
                                                        .endsWith("png"))
                                                    ? "assets/icon/img_image.png"
                                                    : (item1
                                                    .value["description"]
                                                    .toString()
                                                    .split(",")[index].endsWith(
                                                    "doc") ||
                                                    item1.value["description"]
                                                        .toString()
                                                        .split(",")[index]
                                                        .endsWith("docx"))
                                                    ? "assets/icon/img_doc.png"
                                                    : item1.value["description"]
                                                    .toString()
                                                    .split(",")[index].endsWith(
                                                    "pdf")
                                                    ? "assets/icon/img_pdf.png"
                                                    : "assets/icon/img_xls.png",
                                                width: 30,
                                                height: 30,
                                              ),),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Container(
                                          height: 50,
                                          child: Expanded(
                                            child: Center(child: Text(item1
                                                .value["description"]
                                                .toString()
                                                .split(",")[index])),
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                                shrinkWrap: true, // Spacing between cells horizontally


                              )
                          ),
                          isExpanded: item1.value['isExpanded'],
                        );
                      },).toList())

                ],
              ),
            ));
          }
        },
      );
    });
  }
}