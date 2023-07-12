import 'package:enstaller/core/constant/app_colors.dart';
import 'package:enstaller/core/constant/app_string.dart';
import 'package:enstaller/core/constant/appconstant.dart';
import 'package:enstaller/core/constant/size_config.dart';
import 'package:enstaller/core/enums/view_state.dart';
import 'package:enstaller/core/provider/base_view.dart';
import 'package:enstaller/core/viewmodel/add_order_screen_viewmodel.dart';
import 'package:enstaller/ui/shared/appbuttonwidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AddOrderScreen extends StatefulWidget {
  final intOrderId;

  AddOrderScreen({this.intOrderId});

  @override
  _AddOrderScreenState createState() => _AddOrderScreenState();
}

class _AddOrderScreenState extends State<AddOrderScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();


  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarIconBrightness: Brightness.light));
    return BaseView<AddOrderScreenViewModel>(
      onModelReady: (model) => widget.intOrderId == null ?  model.initializeData(null) :model.initializeData(widget.intOrderId),
      builder: (context, model, child) {

        return Scaffold(
            backgroundColor: AppColors.scafoldColor,
            key: _scaffoldKey,
            appBar: AppBar(
                brightness: Brightness.dark,
                backgroundColor: AppColors.appThemeColor,
                automaticallyImplyLeading: true,
                title: Text(
                  (widget.intOrderId != null)
                      ? "${AppStrings.EDIT_ORDER}"
                      : '${AppStrings.ADD_ORDER}',
                  style: TextStyle(color: AppColors.whiteColor),
                ),
                centerTitle: true),
            body: model.state == ViewState.Busy && !model.isSaving
                ? AppConstants.circulerProgressIndicator()
                : SingleChildScrollView(
              child: Padding(
                padding: SizeConfig.verticalBigPadding * 2,
                child: Column(
                  children: [
                    ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: model.orderItems.length,
                        itemBuilder: (context, index) {
                          return model.orderItems[index];
                        }),
                    SizeConfig.verticalSpaceBigMedium(),
                    Padding(
                      padding: SizeConfig.sidepadding,
                      child: AppButton(
                        height: 40,
                        radius: 15,
                        color: AppColors.appThemeColor,
                        textStyle: TextStyle(color: AppColors.whiteColor),
                        buttonText: AppStrings.ADD_LINE_ITEM,
                        onTap: () {
                          model.addOrderItem();
                        },
                      ),
                    ),
                    SizeConfig.verticalSpace(12),
                    model.state == ViewState.Busy && model.isSaving
                        ? AppConstants.circulerProgressIndicator()
                        : Padding(
                      padding: SizeConfig.sidepadding,
                      child: AppButton(
                        height: 40,
                        radius: 15,
                        color: AppColors.appThemeColor,
                        textStyle:
                        TextStyle(color: AppColors.whiteColor),
                        buttonText: AppStrings.save,
                        onTap: () {
                          model.onSave(context);
                        },
                      ),
                    )
                  ],
                ),
              ),
            ));
      },
    );
  }
}
