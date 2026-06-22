import 'package:flutter/material.dart';
import 'package:projct/core/theme/colors_app.dart';
import 'package:projct/model/item_munu_modal.dart';

class ConstensApp {
  static String logo = "images/logo.png";

  static List<String> damascusDistricts = [
    "Kafr Sousa",
    "Al-Mazza",
    "As-Salihiya",
    "Rukn ad-Din",
    "Al-Muhajerin",
    "Al-Midan",
    "Ash-Shaghour",
    "Ancient City of Damascus",
    "Sarouja",
    "Al-Qaboun",
    "Barza",
    "Dummar",
    "Al-Qanawat",
    "Al-Yarmuk",
    "Joubar",
    "Al-Qadam",
  ];

  static List<AttachmentItem> states = [
    AttachmentItem(
      name: "Fire",
      icon: Icons.local_fire_department_outlined,
      color: ColorsApp.yalwoPro,
      value: "fire",
    ),
    AttachmentItem(
      name: "Flood",
      icon: Icons.flood,
      color: ColorsApp.yalwoPro,
      value: "flood",
    ),
    AttachmentItem(
      name: "Theft",
      icon: Icons.assignment_ind_sharp,
      color: ColorsApp.yalwoPro,
      value: "theft",
    ),
    AttachmentItem(
      name: "Murder",
      icon: Icons.stream_outlined,
      color: ColorsApp.yalwoPro,
      value: "murder",
    ),
    AttachmentItem(
      name: "Injury",
      icon: Icons.personal_injury_outlined,
      color: ColorsApp.yalwoPro,
      value: "injury",
    ),
    AttachmentItem(
      name: "Traffic Accident",
      icon: Icons.traffic_outlined,
      color: ColorsApp.yalwoPro,
      value: "traffic accident",
    ),
    AttachmentItem(
      name: "Earthquahke",
      icon: Icons.landslide_outlined,
      color: ColorsApp.yalwoPro,
      value: "earthquahke",
    ),
    AttachmentItem(
      name: "Building Collapsing",
      icon: Icons.account_balance,
      color: ColorsApp.yalwoPro,
      value: "building collapsing",
    ),
    AttachmentItem(
      name: "Drowning",
      icon: Icons.kayaking_outlined,
      color: ColorsApp.yalwoPro,
      value: "drowning",
    ),
    AttachmentItem(
      name: "Kidnapping",
      icon: Icons.masks_outlined,
      color: ColorsApp.yalwoPro,
      value: "Kidnapping",
    ),
  ];


   static final String statment =
      "1. Identify the incidents that happen to you or around you.\n"
      "2. Send the information you want (text, audio, image, video).\n"
      "3. After sending, don't close the app because you will receive a reply with the initial steps you need to take.";
}
