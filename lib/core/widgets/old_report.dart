

// import 'packagefluttermaterial.dart';



// import 'packageflutter_screenutilflutter_screenutil.dart';

// import 'packagehivehive.dart';

// import 'packageprojctcoreconstensconstens.dart';

// import 'packageprojctcorethemecolors_app.dart';

// import 'packageprojctcorewidgetscustom_drawer.dart';

// import 'packageprojctcorewidgetsmunu_two.dart';

// import 'packageprojctcorewidgetssend_and_midea_button.dart';

// import 'packageprojctmodeluser_model.dart';

// import 'packageprojctservicecache_service.dart';



// UserModel user;



// class ReportScreen extends StatefulWidget {

//   ReportScreen({super.key});

//   @override

//   StateReportScreen createState() = _ReportScreenState();

// }



// class _ReportScreenState extends StateReportScreen {

//   String statment = To send a report, follow these instructions

// 1. Identify the incidents that happen to you or around you.

// 2. Send the information you want (text, audio, image, video).

// 3. After sending, don't close the app because you will receive a reply with the initial steps you need to take.;

//   @override

//   void initState() {

//      var userbox = Hive.boxUserModel(CacheService.boxName);

//     user = Hive.box(CacheService.boxName).get(CacheService.userKey);

//     super.initState();

//   }



//   @override

//   Widget build(BuildContext context) {

//     return Scaffold(

//       drawer const CustomDrawer(),

//       backgroundColor Colors.white,

//       appBar AppBar(

//         shape RoundedRectangleBorder(

//           borderRadius BorderRadius.only(

//             bottomLeft Radius.circular(15.r),

//             bottomRight Radius.circular(15.r),

//           ),

//         ),

//         centerTitle true,

//         backgroundColor ColorsApp.greenPro,

//         title Text(

//           Report Page,

//           style TextStyle(

//             shadows [

//               const Shadow(

//                 color Colors.black87,

//                 blurRadius 7,

//                 offset Offset(2, 4),

//               ),

//             ],

//             fontSize 23.sp,

//             color ColorsApp.yalwoPro,

//             fontWeight FontWeight.bold,

//           ),

//         ),

//       ),

//       body SizedBox(

//         width double.infinity,

//         child Column(

//           children [

//             SizedBox(height 35.h),

//             Row(

//               mainAxisAlignment MainAxisAlignment.start,

//               children [

//                 Container(

//                   alignment Alignment.center,

//                   height 55.h,

//                   width 170.h,

//                   decoration BoxDecoration(

//                     boxShadow [

//                       BoxShadow(

//                         color Colors.black.withAlpha(90),

//                         blurRadius 3,

//                         spreadRadius 2,

//                         offset const Offset(1, 1.5),

//                       ),

//                     ],

//                     borderRadius BorderRadius.only(

//                       bottomRight Radius.circular(35.r),

//                       topRight Radius.circular(35.r),

//                     ),

//                     color ColorsApp.greenPro,

//                   ),

//                   child Padding(

//                     padding EdgeInsets.all(10.sp),

//                     child Row(

//                       mainAxisAlignment MainAxisAlignment.center,

//                       children [

//                         Text(

//                           Welcome,

//                           style TextStyle(

//                             color ColorsApp.withePro,

//                             fontSize 20.sp,

//                           ),

//                         ),



//                         Text(

//                            ${user.firstName  },

//                           style TextStyle(

//                             color ColorsApp.yalwoPro,

//                             fontSize 24.sp,

//                             fontWeight FontWeight.w600,

//                           ),

//                         ),

//                       ],

//                     ),

//                   ),

//                 ),

//               ],

//             ),

//             SizedBox(height 62.h),

//             Container(

//               alignment Alignment.center,

//               child Text(statment),

//               height 200.h,

//               width 380.w,

//               decoration BoxDecoration(

//                 gradient LinearGradient(

//                   end Alignment.centerRight,

//                   begin Alignment.centerLeft,

//                   colors [

//                     ColorsApp.yalwoPro,

//                     ColorsApp.yalwoPro.withAlpha(120),

//                     ColorsApp.yalwoPro.withAlpha(200),

//                   ],

//                 ),

//                 border Border.all(color ColorsApp.greenPro, width 3),

//                 borderRadius BorderRadius.all(Radius.circular(20.r)),

//               ),

//             ),

//             SizedBox(height 60.h),

//             AttachmentPickerButton(

//               items ConstensApp.states,

//               onSelected (p0) {},

//             ),

//             SizedBox(height 60.h),

//             Row(

//               mainAxisAlignment MainAxisAlignment.spaceEvenly,

//               children [

//                 SendAndMideaButton(icon Icons.send_rounded, ontap () {}),

//                 Container(

//                   decoration BoxDecoration(

//                     borderRadius BorderRadius.all(Radius.circular(25.r)),

//                     boxShadow [

//                       BoxShadow(

//                         color Colors.black.withAlpha(125),

//                         blurRadius 9,

//                         spreadRadius 1,

//                         offset const Offset(2, 3),

//                       ),

//                       BoxShadow(

//                         color Colors.white.withAlpha(120),

//                         blurRadius 8,

//                         spreadRadius 1,

//                         offset const Offset(-2, -3),

//                       ),

//                     ],

//                   ),

//                   width 290.w,

//                   child TextFormField(

//                     keyboardType TextInputType.multiline,

//                     cursorColor ColorsApp.yalwoPro,

//                     maxLines 3,

//                     minLines 1,



//                     style TextStyle(

//                       color ColorsApp.withePro,

//                       fontSize 18.sp,

//                     ),

//                     decoration InputDecoration(

//                       hintText Write Here ...,

//                       hintStyle TextStyle(

//                         color ColorsApp.yalwoPro,

//                         fontSize 18.sp,

//                       ),

//                       filled true,

//                       focusedBorder OutlineInputBorder(

//                         borderSide const BorderSide(

//                           color ColorsApp.yalwoPro,

//                           width 3,

//                         ),

//                         borderRadius BorderRadius.all(Radius.circular(25.r)),

//                       ),

//                       suffixIcon IconButton(

//                         onPressed () {},

//                         icon Icon(

//                           Icons.camera_alt_outlined,

//                           color ColorsApp.yalwoPro,

//                         ),

//                       ),

//                       prefixIcon IconButton(

//                         onPressed () {},

//                         icon const Icon(

//                           Icons.image,

//                           color ColorsApp.yalwoPro,

//                         ),

//                       ),

//                       fillColor ColorsApp.greenPro,



//                       enabledBorder OutlineInputBorder(

//                         borderSide BorderSide(

//                           width 0,

//                           color Colors.transparent,

//                         ),

//                         borderRadius BorderRadius.all(Radius.circular(25.r)),

//                       ),

//                     ),

//                   ),

//                 ),



//                 SendAndMideaButton(ontap () {}, icon Icons.mic),

//               ],

//             ),

//           ],

//         ),

//       ),

//     );

//   }

// } 

