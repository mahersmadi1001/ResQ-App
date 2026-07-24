import 'package:flutter/material.dart';
import 'package:projct/core/localization/app_localizations.dart';
import 'package:projct/core/theme/colors_app.dart';
import 'package:projct/model/item_munu_modal.dart';

class ConstensApp {
  static String logo = "images/logo.png";

  static List<String> damascusDistricts = [
    AppLocalizations.trNoContext("damascus_districts.kfar_souseh"),
    AppLocalizations.trNoContext("damascus_districts.mezzeh"),
    AppLocalizations.trNoContext("damascus_districts.al_salihiyah"),
    AppLocalizations.trNoContext("damascus_districts.rukn_al_din"),
    AppLocalizations.trNoContext("damascus_districts.mouhajirin"),
    AppLocalizations.trNoContext("damascus_districts.midan"),
    AppLocalizations.trNoContext("damascus_districts.shaghour"),
    AppLocalizations.trNoContext("damascus_districts.old_damascus"),
    AppLocalizations.trNoContext("damascus_districts.sarouja"),
    AppLocalizations.trNoContext("damascus_districts.qaboun"),
    AppLocalizations.trNoContext("damascus_districts.barzeh"),
    AppLocalizations.trNoContext("damascus_districts.dummar"),
    AppLocalizations.trNoContext("damascus_districts.qanawat"),
    AppLocalizations.trNoContext("damascus_districts.yarmouk"),
    AppLocalizations.trNoContext("damascus_districts.jober"),
    AppLocalizations.trNoContext("damascus_districts.qadam"),
  ];

  static List<AttachmentItem> states = [
    AttachmentItem(
      name: AppLocalizations.trNoContext("incident_types.fire"),
      icon: Icons.local_fire_department_outlined,
      color: ColorsApp.yalwoPro,
      value: "Fire",
    ),
    AttachmentItem(
      name: AppLocalizations.trNoContext("incident_types.flood"),
      icon: Icons.flood,
      color: ColorsApp.yalwoPro,
      value: "Flood",
    ),
    AttachmentItem(
      name: AppLocalizations.trNoContext("incident_types.theft"),
      icon: Icons.assignment_ind_sharp,
      color: ColorsApp.yalwoPro,
      value: "Theft",
    ),
    AttachmentItem(
      name: AppLocalizations.trNoContext("incident_types.murder"),
      icon: Icons.stream_outlined,
      color: ColorsApp.yalwoPro,
      value: "Murder",
    ),
    AttachmentItem(
      name: AppLocalizations.trNoContext("incident_types.injury"),
      icon: Icons.personal_injury_outlined,
      color: ColorsApp.yalwoPro,
      value: "Injury",
    ),
    AttachmentItem(
      name: AppLocalizations.trNoContext("incident_types.traffic_accident"),
      icon: Icons.traffic_outlined,
      color: ColorsApp.yalwoPro,
      value: "Traffic Accident",
    ),
    AttachmentItem(
      name: AppLocalizations.trNoContext("incident_types.traffic_accident"),
      icon: Icons.landslide_outlined,
      color: ColorsApp.yalwoPro,
      value: "Earthquahke",
    ),
    AttachmentItem(
      name: AppLocalizations.trNoContext("incident_types.building_collapsing"),
      icon: Icons.account_balance,
      color: ColorsApp.yalwoPro,
      value: "Building Collapsing",
    ),

    AttachmentItem(
      name: AppLocalizations.trNoContext("incident_types.kidnapping"),
      icon: Icons.masks_outlined,
      color: ColorsApp.yalwoPro,
      value: "Kidnapping",
    ),
    AttachmentItem(
      name: AppLocalizations.trNoContext("incident_types.gang_violence"),
      icon: Icons.groups,
      color: ColorsApp.yalwoPro,
      value: "Gang violence",
    ),
    AttachmentItem(
      name: AppLocalizations.trNoContext("incident_types.missing_person"),
      icon: Icons.person_search_sharp,
      color: ColorsApp.yalwoPro,
      value: "Missing person",
    ),
    AttachmentItem(
      name: AppLocalizations.trNoContext("incident_types.explosion"),
      icon: Icons.warning,
      color: ColorsApp.yalwoPro,
      value: "Explosion",
    ),
    AttachmentItem(
      name: AppLocalizations.trNoContext("incident_types.medical_emergency"),
      icon: Icons.medical_services,
      color: ColorsApp.yalwoPro,
      value: "Medical emergency",
    ),
  ];

  static final String statment =
      "${AppLocalizations.trNoContext("report_screen.statement1")}\n"
      "${AppLocalizations.trNoContext("report_screen.statement2")}\n"
      "${AppLocalizations.trNoContext("report_screen.statement3")}";
}
