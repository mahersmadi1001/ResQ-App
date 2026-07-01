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
      value: "Fire",
    ),
    AttachmentItem(
      name: "Flood",
      icon: Icons.flood,
      color: ColorsApp.yalwoPro,
      value: "Flood",
    ),
    AttachmentItem(
      name: "Theft",
      icon: Icons.assignment_ind_sharp,
      color: ColorsApp.yalwoPro,
      value: "Theft",
    ),
    AttachmentItem(
      name: "Murder",
      icon: Icons.stream_outlined,
      color: ColorsApp.yalwoPro,
      value: "Murder",
    ),
    AttachmentItem(
      name: "Injury",
      icon: Icons.personal_injury_outlined,
      color: ColorsApp.yalwoPro,
      value: "Injury",
    ),
    AttachmentItem(
      name: "Traffic Accident",
      icon: Icons.traffic_outlined,
      color: ColorsApp.yalwoPro,
      value: "Traffic Accident",
    ),
    AttachmentItem(
      name: "Earthquahke",
      icon: Icons.landslide_outlined,
      color: ColorsApp.yalwoPro,
      value: "Earthquahke",
    ),
    AttachmentItem(
      name: "Building Collapsing",
      icon: Icons.account_balance,
      color: ColorsApp.yalwoPro,
      value: "Building Collapsing",
    ),
    AttachmentItem(
      name: "Drowning",
      icon: Icons.kayaking_outlined,
      color: ColorsApp.yalwoPro,
      value: "Drowning",
    ),
    AttachmentItem(
      name: "Kidnapping",
      icon: Icons.masks_outlined,
      color: ColorsApp.yalwoPro,
      value: "Kidnapping",
    ),
    AttachmentItem(
      name: "Gang violence",
      icon: Icons.groups,
      color: ColorsApp.yalwoPro,
      value: "Gang violence",
    ),
    AttachmentItem(
      name: "Missing person",
      icon: Icons.person_search_sharp,
      color: ColorsApp.yalwoPro,
      value: "Missing person",
    ),
    AttachmentItem(
      name: "Explosion",
      icon: Icons.warning,
      color: ColorsApp.yalwoPro,
      value: "Explosion",
    ),
    AttachmentItem(
      name: "Medical emergency",
      icon: Icons.medical_services,
      color: ColorsApp.yalwoPro,
      value: "Medical emergency",
    ),
  ];

  static final String statment =
      "1. Identify the incidents that happen to you or around you.\n"
      "2. Send the information you want (text, audio, image, video).\n"
      "3. After sending, don't close the app because you will receive a reply with the initial steps you need to take.";
}
