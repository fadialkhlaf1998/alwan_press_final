import 'package:alwan_press/helper/api.dart';
import 'package:get/get.dart';
import 'package:alwan_press/model/clients.dart';
class OurClientsController extends GetxController{
  RxBool loading = false.obs;
  List<Client> my_clients = <Client>[];

  @override
  void onInit() {
    super.onInit();
    initPage();
  }
  initPage()async{
    loading(true);
    my_clients = await Api.getClients();
    loading(false);
  }

}