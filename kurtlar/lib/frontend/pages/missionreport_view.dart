import 'package:flutter/material.dart';
import 'package:kurtlar/frontend/base/color_constants.dart';
import 'package:kurtlar/frontend/base/widget_base.dart';
import 'package:kurtlar/frontend/models/players.dart';
import 'package:kurtlar/frontend/pages/night_view.dart';
import 'package:kurtlar/frontend/pages/nightreport_view.dart';
import '../../backend/lang/language_constant.dart';
import '../components/button.dart';
import '../models/users.dart';

//TODO Dogunun görevi sorunlu ve gece kimse ölnediğinde gece kimse ölmedi yazacak.
class missionreportPage extends StatefulWidget {
  missionreportPage(this.index);

  int index;

  @override
  State<missionreportPage> createState() => _missionreportPageState();
}

class _missionreportPageState extends BaseState<missionreportPage> {
  String MissionText;
  Players user;
  List<Players> mixedInformation = [];

  @override
  void initState() {
    user = USERS[widget.index];
    if (!user.GetMuted) {
      MissionText = user.GetRole.DoMission();
    } else {
      MissionText = "Bugünlük iş yok";
    }
    if (user.GetRole.GetName == "Doğu Bey") {
      mixedInformation = [
        (MafiasUser..shuffle())[0],
        (GovermentUser..shuffle())[0]
      ];
      mixedInformation..shuffle();
      user.setDidYouGetInfos();
    }

    super.initState();
  }

  CircleAvatar ChosenUserAvatar() {
    return CircleAvatar(
      radius: dynamicHeight(0.05),
      child: Image.asset('assets/images/deafultAvatar.png'),
    );
  }

  Container Dogureport() => Container(
        height: dynamicHeight(0.1),
        width: dynamicWidth(0.8),
        child: !user.GetDidYougetInfos
            ? user.GetRole.chosenUser.Getisdead
                ? user.GetRole.chosenUser.GetHitBullet
                    ? Text("Abdulley Vurmuş",
                        style: TextStyle(
                            fontSize: 30, color: ColorConstant.instance.white))
                    : Text(
                        "${user.GetRole.chosenUser.GetName}: Şu iki kişiden biri öldürmüş => ${mixedInformation[0].GetName} or ${mixedInformation[1].GetName}",
                        style: TextStyle(
                            fontSize: 20,
                            color: ColorConstant.instance
                                .white)) //İki kişi gelcek ve biri kesin mafya olcak
                : Text("Hedefin hala yaşıyor",
                    style: TextStyle(
                        fontSize: 30, color: ColorConstant.instance.white))
            : Text("Bugünlük İş yok",
                style: TextStyle(
                    fontSize: 30, color: ColorConstant.instance.white)),
      );

  Container notcompleted() => Container(
        height: dynamicHeight(0.1),
        child: Text(MissionText,
            style:
                TextStyle(fontSize: 30, color: ColorConstant.instance.white)),
      );

  Container completed() {
    return Container(
      height: dynamicHeight(0.1),
      child: Column(
        children: [
          Text("${USERS[widget.index].GetRole.chosenUser.GetName}",
              style:
                  TextStyle(fontSize: 30, color: ColorConstant.instance.white)),
          SizedBox(
            height: dynamicHeight(0.01),
          ),
          Text(MissionText,
              style:
                  TextStyle(fontSize: 30, color: ColorConstant.instance.white))
        ],
      ),
    );
  }

  Container PolatText() => Container(
        height: dynamicHeight(0.1),
        child: Text("POLAT => ${PolatUser.GetName}",
            style:
                TextStyle(fontSize: 30, color: ColorConstant.instance.white)),
      );

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image:
                AssetImage("assets/images/night.jpg"), // <-- BACKGROUND IMAGE
            fit: BoxFit.cover,
          ),
        ),
      ),
      Scaffold(
          backgroundColor:
              Colors.transparent, // <-- SCAFFOLD WITH TRANSPARENT BG
          body: Column(
            children: [
              SizedBox(
                height: dynamicHeight(0.4),
              ),
              Row(
                children: <Widget>[
                  MissionText != "Bugünlük iş yok"
                      ? ChosenUserAvatar()
                      : SizedBox(
                          height: dynamicHeight(0.3),
                        ),
                  SizedBox(
                    width: dynamicHeight(0.01),
                  ),
                  user.GetRole.GetName == "Aslan Akbey"
                      ? PolatText()
                      : user.GetRole.GetName == "Doğu Bey" &&
                              MissionText == "Bugünlük iş yok"
                          ? Dogureport()
                          : MissionText != "Bugünlük iş yok"
                              ? completed()
                              : notcompleted()
                ],
              ),
              SizedBox(
                height: 40,
              ),
              BottomButtonContainerContiune(
                  context: context,
                  height: 50,
                  buttonText: translate(context).ok,
                  where: widget.index < USERS.length - 1
                      ? Night(widget.index)
                      : NightreportPage(),
                  ContainerColor: Colors.transparent)
            ],
          ))
    ]);
  }
}