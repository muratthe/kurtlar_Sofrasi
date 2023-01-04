import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:kurtlar/backend/roles/Abdulhey.dart';
import 'package:kurtlar/backend/roles/AslanAkbey.dart';
import 'package:kurtlar/backend/roles/Karahanl%C4%B1.dart';
import 'package:kurtlar/backend/roles/dogubey.dart';
import 'package:kurtlar/backend/roles/lazziya.dart';
import 'package:kurtlar/backend/roles/mafiamen.dart';
import 'package:kurtlar/backend/roles/nizammettin.dart';
import 'package:kurtlar/backend/roles/officer.dart';
import 'package:kurtlar/backend/roles/polat.dart';

import '../../backend/roles/BaseRole.dart';

LazZiya laz = LazZiya();
nizamettin niz = nizamettin();

mafiamen mafiaMen = mafiamen();
officer Off = officer();
AslanAkbey Aslan = AslanAkbey();
Abdulhey abu = Abdulhey();
Karahanli kara = Karahanli();
DoguBey dogubey = DoguBey();

List<Role> ordinary = [Off, mafiaMen, Polat.instance];
List<Role> deepgoverment = [Aslan, dogubey, abu];
List<Role> mafia = [kara, niz, laz];
