import 'package:flutter/foundation.dart';
import 'package:flutter_templat/core/data/models/category_model.dart';
import 'package:flutter_templat/core/data/repositories/user_repository.dart' show UserRepository;
import 'package:flutter_templat/core/enums/message_type.dart' show MessagType;
import 'package:flutter_templat/core/services/base_controller.dart';
import 'package:flutter_templat/ui/shared/custom_widgets/custom_toast.dart';
import 'package:flutter_templat/ui/views/verfication_view/verfication_view.dart';
import 'package:get/get.dart';

class SignUpSecondaryViewController extends BaseControoler {
    String name = '';
String password='';
String phoneNumber='';
String email='';

  SignUpSecondaryViewController(name,password,phoneNumber,email) {
   name=name;
   password=password;
   phoneNumber=phoneNumber;
   email=email;
  }
  List<CategoryModel>intrestList=[CategoryModel(id:1,name: "Sports",logo: "sports"),
  CategoryModel(id: 2,name: "Arts",logo: "arts"),CategoryModel(id: 3,name: "Music",logo: "music")];
    var selectedInterests = <String>['sport'].obs;
var selectedLocations = <String>[].obs;
 final List<String> locations = ["Homs", "Aleppo", "Damascus"];
  void toggleSelection(String location) {
    if (selectedLocations.contains(location)) {
      selectedLocations.remove(location);
    } else {
      selectedLocations.add(location);
    }
  }
  void toggleInterest(String name) {
    if (selectedInterests.contains(name)) {
      selectedInterests.remove(name);
    } else {
      selectedInterests.add(name);
    }
  }
  void register({required String email,required String password,required String phoneNumber,required String name, required List<String> provinces, required List<String> interests}) {
    runFullLoadingFunction(
      function: UserRepository()
          .register(email:email , password: password, phoneNumber: phoneNumber, name: name, provinces: provinces, interests: interests
          
          )
          .then(
            (value) => value.fold(
              (l) {
                CustomToast.showMessage(
                  messageType: MessagType.REJECTED,
                  message: "فشل انشاء حساب",
                );
              },
              (r) {
                CustomToast.showMessage(
                  messageType: MessagType.SUCCSESS,
                  message: "تم انشاء حساب",
                );
               Get.to(VerficationView(email: email,));
                // Get.to(SignUpView());
                // Get.off(() => VerificationCodeView(
                //       email: email!,
                //     ));
              },
            ),
          ),
    );
  }

List<String>location=['Homs'];
  bool isSelected(String name) => selectedInterests.contains(name);
}

