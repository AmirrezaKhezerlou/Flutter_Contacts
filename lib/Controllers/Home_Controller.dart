import 'package:contacts/Views/add.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:flutter_sms/flutter_sms.dart';

class Home_Controller extends GetxController {

  var contacts = List<Contact>.empty().obs;

  @override
  void onInit() {
    Permission_Handler();
    super.onInit();
  }

  void Permission_Handler() async {
    var status = await Permission.contacts.status;
    if (!status.isGranted) {
      await Permission.contacts.request();
      FetchContacts();
    } else {
      FetchContacts();
    }
  }

  void FetchContacts() async {
    // Get all contacts on device
    contacts.value = await ContactsService.getContacts();
  }

  void Make_Call(String Number)async
  {
    if(Number.isNotEmpty){
      bool? res = await FlutterPhoneDirectCaller.callNumber(Number);
    }else{
      Get.snackbar('Error', 'No Phone Number Found !');
    }

  }

void SendSms(String Number)async
{
  await sendSMS(message: '', recipients: [Number],sendDirect: false);
}

void LetsAddContact(){
    Get.to(()=>Add(),
    transition: Transition.fadeIn,
    );
}


}
