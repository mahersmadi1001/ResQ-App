import 'package:flutter/material.dart';
import 'package:projct/core/theme/colors_app.dart';

class AttachmentItem {
  final String name;
  final IconData icon;
  final Color color;
  final String value;

  AttachmentItem({
    required this.name,
    required this.icon,
    required this.color,
    required this.value,
  });
}

List<AttachmentItem> teams = [
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
    icon: Icons.accessibility_new_outlined,
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
];
