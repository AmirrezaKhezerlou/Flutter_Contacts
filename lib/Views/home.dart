import 'package:contacts/Controllers/Home_Controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_dismissible_tile/flutter_dismissible_tile.dart';
import 'package:auto_size_text/auto_size_text.dart';

class Home extends StatelessWidget {
  Home_Controller home_controller = Get.put(Home_Controller());

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Column(
        children: [
          Header_Widget(height),
          Row(
            children: [

              Container(
                width: width ,
                height: height * 4 / 5,
                child: Obx(
                  () => ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: home_controller.contacts.length,
                      itemBuilder: (context, index) {
                        return DismissibleTile(
                          rtlOverlayIndent: 28,
                          ltrOverlayIndent: 28,
                          rtlOverlay: Icon(
                            Icons.call,
                            color: Color(0xff2f2f2f),
                            size: 30,
                          ),
                          ltrOverlay: Icon(
                            Icons.sms,
                            color: Color(0xff2f2f2f),
                            size: 30,
                          ),
                          confirmDismiss: (direction) => Future.delayed(
                            const Duration(seconds: 1),
                            () {
                              print(direction.toString());
                              print(home_controller.contacts[index].avatar);
                              if(direction == DismissibleTileDirection.rightToLeft){
                                home_controller.Make_Call(home_controller.contacts[index].phones![0].value!);
                              }
                              if(direction == DismissibleTileDirection.leftToRight){
                                home_controller.SendSms(home_controller.contacts[index].phones![0].value!);
                              }
                              return false;
                            },
                          ),
                          key: UniqueKey(),
                          child: Column(
                            children: [
                              Container(
                                margin: EdgeInsets.all(20),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      child: AutoSizeText(
                                        home_controller
                                          .contacts[index].displayName!,
                                        style: TextStyle(fontSize: 20,),
                                        overflow: TextOverflow.ellipsis,
                                        presetFontSizes: [20, 17, 15],
                                        maxLines: 1,
                                      ),
                                    ),
                                    Expanded(child: Container()),
                                    Row(
                                      children: [
                                        Visibility(
                                          visible: home_controller
                                                  .contacts[index]
                                                  .avatar!
                                                  .isEmpty
                                              ? false
                                              : true,
                                          child: GestureDetector(
                                            onTap: () => print(home_controller
                                                .contacts[index].avatar!),
                                            child: CircleAvatar(
                                              radius: 25,
                                              //child:
                                              child: ClipOval(
                                                child: Image.memory(
                                                    home_controller
                                                        .contacts[index]
                                                        .avatar!),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Visibility(
                                          visible: home_controller
                                                  .contacts[index]
                                                  .avatar!
                                                  .isEmpty
                                              ? true
                                              : false,
                                          child: GestureDetector(
                                            onTap: () => print(home_controller
                                                .contacts[index].avatar!),
                                            child: CircleAvatar(
                                              radius: 25,
                                              child: Text(home_controller
                                                  .contacts[index].displayName!
                                                  .substring(0, 1)),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Divider(),
                            ],
                          ),
                        );
                      }),
                ),
              ),
            ],
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){

        },
        backgroundColor: Color(0xFFfa709a),
        child: Icon(Icons.add,color: Colors.white,),
      ),
      floatingActionButtonAnimator: NoScalingAnimation(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Container Header_Widget(double height) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(25), bottomLeft: Radius.circular(25)),
        gradient: LinearGradient(
            colors: [
              const Color(0xFFfa709a),
              const Color(0xFFfee140),
            ],
            begin: const FractionalOffset(0.0, 0.0),
            end: const FractionalOffset(1.0, 0.0),
            stops: [0.0, 1.0],
            tileMode: TileMode.clamp),
      ),
      height: height / 5,
      child: Center(
        child: Text(
          'My Contacts',
          style: TextStyle(color: Colors.white, fontSize: 30),
        ),
      ),
    );
  }
}


class NoScalingAnimation extends FloatingActionButtonAnimator {
  @override
  Offset getOffset({required Offset begin, required Offset end, required double progress}) {
    return end;
  }

  @override
  Animation<double> getRotationAnimation({required Animation<double> parent}) {
    return Tween<double>(begin: 1.0, end: 1.0).animate(parent);
  }

  @override
  Animation<double> getScaleAnimation({required Animation<double> parent}) {
    return Tween<double>(begin: 1.0, end: 1.0).animate(parent);
  }
}
