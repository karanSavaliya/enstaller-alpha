import 'package:enstaller/core/constant/app_string.dart';
import 'package:enstaller/core/enums/view_state.dart';
import 'package:enstaller/core/model/serial_item_model.dart';
import 'package:enstaller/core/model/user_model.dart';
import 'package:enstaller/core/provider/base_model.dart';
import 'package:enstaller/core/service/api_service.dart';
import 'package:enstaller/core/service/pref_service.dart';

class CheckRequestViewModel extends BaseModel {

  List<SerialItemModel> serialList = [];
  ApiService _apiService = ApiService();

  void initializeData() async {

    serialList = [];
    setState(ViewState.Busy);
    //Fetch from apis
    UserModel user = await Prefs.getUser();

    serialList.add(SerialItemModel(
        strSerialNo: AppStrings.SERIAL_NUMBER,
        strItemName: AppStrings.ITEM_NAME));
    List<SerialItemModel> list = await _apiService.getSerialListByEmployeeId(
        user.id.toString(), user.intCompanyId);
    list.forEach((element) {
      serialList.add(SerialItemModel(
          strSerialNo: element.strSerialNo ?? "",
          strItemName: element.strItemName ?? ""));
    });
    print("Check list count ----> ${serialList.length}");
    setState(ViewState.Idle);

  }

}
