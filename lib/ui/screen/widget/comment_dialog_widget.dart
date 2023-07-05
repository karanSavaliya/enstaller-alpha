// @dart=2.9


import 'package:enstaller/core/constant/app_colors.dart';
import 'package:enstaller/core/constant/app_string.dart';
import 'package:enstaller/core/constant/appconstant.dart';
import 'package:enstaller/core/constant/size_config.dart';
import 'package:enstaller/core/enums/view_state.dart';
import 'package:enstaller/core/provider/base_view.dart';
import 'package:enstaller/core/viewmodel/comment_dialog_viewmodel.dart';
import 'package:enstaller/ui/screen/widget/survey/error_widget.dart';
import 'package:enstaller/ui/shared/appbuttonwidget.dart';
import 'package:enstaller/ui/util/AppBuilder.dart';
import 'package:enstaller/ui/util/DeletableTag.dart';
import 'package:enstaller/ui/util/text_util.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';


class CommentDialogWidget extends StatefulWidget {
  final String appointmentID;
  CommentDialogWidget({this.appointmentID});
  @override
  _CommentDialogWidgetState createState() => _CommentDialogWidgetState();
}

class _CommentDialogWidgetState extends State<CommentDialogWidget> {


     List<Map<String ,dynamic>> listfiles = [];
      double height = 0;

    Widget FilesPicked()
    {
      return   Container(height:height , /*child:GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(

          crossAxisCount: 3, // Number of columns
          mainAxisSpacing: 8, // Spacing between rows
          crossAxisSpacing: 8,
          childAspectRatio: 1,// Spacing between columns
        ),
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: listfiles.length, // Total number of grid items
        itemBuilder: (BuildContext context, int index) {

          print(listfiles[index]["value"]+"----------");

          return DeletableTag(path: listfiles[index]["value"], onDelete: (){

            setState(() {
               listfiles.removeAt(index);
               if(listfiles.length/3 >= 1) {

                 double height_add = MediaQuery.of(context).size.width/3 ;
                 //height = height - (height_add);
               }else{

               }
            });

          });
        },
      )*/


          child:GridView.extent(
            maxCrossAxisExtent: 200, // Maximum width of each cell
            mainAxisSpacing: 10, // Spacing between cells vertically
            crossAxisSpacing: 10, // Spacing between cells horizontally


      ));

    }

    Future<void> pickfile() async {

      final result = await FilePicker.getMultiFilePath(
        type: FileType.ANY,
        fileExtension: 'jpeg,jpg,png,doc,docx,pdf,xls,xlsx,jfif,pjpeg,pjp'
      );
      
      for (final element in result.values) {

        setState(() {
          print(element);
          listfiles.add({"value":element});
        });
      }

      /*result.values.map((e){





      });*/




    }

  @override
  Widget build(BuildContext context) {

    return AppBuilder(builder: (context)
    {
      return BaseView<CommentDialogViewModel>(
        onModelReady: (model) => model.getComments2(widget.appointmentID),
        builder: (context , model , child) {
          if (model.state == ViewState.Busy) {
            return AppConstants.circulerProgressIndicator();
          } else {
            return SingleChildScrollView(child:Container(

              height: MediaQuery.of(context).size.height*1.5,
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
                      child: commonTextFormField(
                          model.commentController,
                          "Type Comment",
                          TextInputType.text,
                          null,
                          true,
                          context,
                          10,
                          false),
                    ),
                  ),
                  model.showErrorMessage
                      ? SizedBox(height: 2)
                      : SizedBox(height: 0),
                  model.showErrorMessage
                      ? Padding(
                      padding: SizeConfig.sidepadding,
                      child: ErrorTextWidget(
                          errorMessage: AppStrings.emptyFieldMessage))
                      : SizedBox(height: 0),
                  SizedBox(height: 20),
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
                  SizedBox(height: 20),
          Padding(
          padding: SizeConfig.sidepadding,
                  child:FilesPicked(),
          ),
                  SizedBox(height: 20),
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
                        model.addComments(context , widget.appointmentID, model.commentController.text.toString(), listfiles);
                        if(model.state == ViewState.Idle){
                          print(model.response_body);
                        }
                       // model.addComments(context , widget.appointmentID , model.commentController.text.toString());
                      },
                    ),
                  ),
                  SizeConfig.verticalSpaceMedium(),
                  Padding(
                    padding: SizeConfig.sidepadding,
                    child: Text(
                      AppStrings.appointmentCommentDetails,
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  /*Expanded(
                      child: ListView(
                        children: [
                          Padding(
                            padding: SizeConfig.sidepadding,
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: Container(
                                    height: 40,
                                    color: AppColors.darkBlue,
                                    child: Center(
                                        child: Text(
                                          "Date",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.normal,
                                              fontSize: 14.0),
                                        )),
                                  ),
                                ),
                                SizedBox(width: 2),
                                Expanded(
                                  flex: 3,
                                  child: Container(
                                    height: 40,
                                    color: AppColors.darkBlue,
                                    child: Center(
                                        child: Text(
                                          "Comments",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.normal,
                                              fontSize: 14.0),
                                        )),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          ListView.builder(
                              shrinkWrap: true,
                              itemCount: model.comments.length,
                              physics: NeverScrollableScrollPhysics(),
                              itemBuilder: (BuildContext ctxt, int index) {
                                return Padding(
                                  padding: SizeConfig.sidepadding,
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: index % 2 == 0
                                            ? AppColors.veryLightGrayColor
                                            : AppColors.whiteColor),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          flex: 2,
                                          child: Container(
                                            padding: const EdgeInsets.all(6),
                                            child: Center(
                                                child: Padding(
                                                  padding: const EdgeInsets.all(
                                                      8.0),
                                                  child: Text(
                                                      AppConstants
                                                          .formattedSingeDate(
                                                          DateTime.parse(model
                                                              .comments[index]
                                                              .dteCreatedDate)) , style: TextStyle(fontSize: 13),),
                                                )),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 2,
                                          child: Container(
                                              color: AppColors.darkGrayColor
                                                  .withOpacity(.08)),
                                        ),
                                        Expanded(
                                          flex: 3,
                                          child: Container(
                                            child: Center(
                                                child: Text(model
                                                    .comments[index]
                                                    .strComments)),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              })
                        ],
                      )),*/
                ],
              ),
            ));
          }
        },
      );
    });

  }
}


