import 'dart:async';

import 'package:alwan_press/app_localization.dart';
import 'package:alwan_press/helper/app.dart';
import 'package:alwan_press/helper/myTheme.dart';
import 'package:alwan_press/widget/connect_us_widget.dart';
import 'package:alwan_press/widget/darkModeBackground.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutUs extends StatefulWidget {
  const AboutUs({Key? key}) : super(key: key);

  @override
  State<AboutUs> createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  late GoogleMapController googleMapController;
  final initialCameraPosition = CameraPosition(
    target: LatLng(25.277441828720047, 55.39181012164881),
    zoom: 11.5,
  );
  Set<Marker> marker = Set();
  void onMapCreated(GoogleMapController controller)  async {
    setState(() {
      marker.add(
          Marker(
            markerId: MarkerId('Alwan Printing'),
            position: LatLng(25.277441828720047, 55.39181012164881),
            visible: true,
            icon: BitmapDescriptor.defaultMarker,
          ));
    });
  }
  void openMap() async {
    String googleUrl = 'https://www.google.com/maps/place/Alwan+Printing+Press+-+%D9%85%D8%B7%D8%A8%D8%B9%D8%A9+%D8%A7%D9%84%D9%88%D8%A7%D9%86%E2%80%AD/@25.276656,55.390351,16z/data=!4m5!3m4!1s0x0:0xa7a2084ccd16fff!8m2!3d25.2773172!4d55.3918622';
    await launchUrl(Uri.parse(googleUrl));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Stack(
            children: [
              const DarkModeBackground(),
              Container(
                // height: MediaQuery.of(context).size.height,
                child:  SingleChildScrollView(
                  child: Column(
                    children: [
                      _header(context),
                      SizedBox(height: 10,),
                      _body(context)
                    ],
                  ),
                )
              ),

            ],
          ),
        ),
      ),
    );
  }


  _header(BuildContext context){
    return Container(
      width: Get.width,
      height: 60,
      decoration: BoxDecoration(
          color: MyTheme.isDarkTheme.value?App.darkGrey:Colors.white,
          boxShadow: [
            App.myBoxShadow
          ]
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(width: Get.width * 0.05,),
          GestureDetector(
            onTap: (){
              Get.back();
            },
            child:  Icon(Icons.arrow_back_ios,color: App.textLightColor(),),
          ),
          SizedBox(width: 10,),
          App.logo(context),

        ],
      ),
    );
  }

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );



  static final CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);
  Completer<GoogleMapController> _controller = Completer();
  _body(context){
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // SizedBox(height: 100,),
          Container(
            width: Get.width,
            color: App.containerColor(),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    App_Localization.of(context).translate("alwan_printing_press"),
                    style: TextStyle(
                        color: MyTheme.isDarkTheme.value?Colors.white:Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                  SizedBox(height: 5,),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: Text(
                      App_Localization.of(context).translate("about_content"),
                      style: TextStyle(
                        color: App.textLightColor(),
                        fontSize: 11,
                      ),
                      textAlign: TextAlign.justify,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 10,),
          Container(
            width: Get.width,
            color: App.containerColor(),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(App_Localization.of(context).translate("reach_us"),style: TextStyle(color: MyTheme.isDarkTheme.value?Colors.white:Colors.black,fontWeight: FontWeight.bold,fontSize: 16),),
                  SizedBox(height: 10,),
                  Container(
                    width: MediaQuery.of(context).size.width*0.9,
                    child: Row(
                      children: [
                        Icon(Icons.location_on,color: App.textLightColor(),size: 20),
                        SizedBox(width: 15,),
                        Container(
                            height:40,
                            width: MediaQuery.of(context).size.width*0.9 - 70,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Al- Qasis industrial city 2 - Back Side of Aster Hospital - Dubai",style: TextStyle(fontSize: 10,color: App.textLightColor(),fontWeight: FontWeight.bold),maxLines: 2,),
                              ],
                            )
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 5,),
                  Container(width: Get.width - 20,color: App.textLightColor().withOpacity(0.3),height: 1,),
                  SizedBox(height: 5,),

                  GestureDetector(
                    onTap: ()async{
                      await launchUrl(Uri.parse("tel://+971 4 267 6552"));
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width*0.9,
                      child: Row(
                        children: [
                          Icon(Icons.phone,color: App.textLightColor(),size: 20),
                          SizedBox(width: 15,),
                          Container(
                              height:40,
                              width: MediaQuery.of(context).size.width*0.9 - 70,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("+971 4 267 6552",style: TextStyle(fontSize: 10,color: App.textLightColor(),fontWeight: FontWeight.bold),maxLines: 2,),
                                ],
                              )
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 5,),
                  Container(width: Get.width - 20,color: App.textLightColor().withOpacity(0.3),height: 1,),
                  SizedBox(height: 5,),
                  Container(
                    width: MediaQuery.of(context).size.width*0.9,
                    child: Row(
                      children: [
                        Icon(Icons.mail,color: App.textLightColor(),size: 20,),
                        SizedBox(width: 15,),
                        Container(
                            height:40,
                            width: MediaQuery.of(context).size.width*0.9 - 70,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("P.O. Box: 234985",style: TextStyle(fontSize: 10,color: App.textLightColor(),fontWeight: FontWeight.bold),maxLines: 2,),
                              ],
                            )
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 5,),
                  Container(width: Get.width - 20,color: App.textLightColor().withOpacity(0.3),height: 1,),
                  SizedBox(height: 5,),
                  GestureDetector(
                    onTap: ()async{
                      await launchUrl(Uri.parse("https://alwanpress.ae"));
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width*0.9,
                      child: Row(
                        children: [
                          // Icon(Icons.add_photo_alternate,color: MyTheme.isDarkTheme.value?Colors.white:Colors.black),
                          SvgPicture.asset("assets/icons/web.svg",width: 20,color: App.textLightColor(),),
                          SizedBox(width: 15,),
                          Container(
                              height:40,
                              width: MediaQuery.of(context).size.width*0.9 - 70,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  //
                                  Text("www.alwanpress.ae",style: TextStyle(fontSize: 10,color: App.textLightColor(),fontWeight: FontWeight.bold),maxLines: 2,),
                                ],
                              )
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          SizedBox(height: 10,),
          GestureDetector(
            onTap: (){
              openMap();
            },
            child: Container(
              height: MediaQuery.of(context).size.width*0.9/2,
              width: MediaQuery.of(context).size.width*0.9,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20)
              ),
              child: GoogleMap(
                mapType: MapType.normal,
                zoomGesturesEnabled: false,
                zoomControlsEnabled: false,
                onMapCreated: onMapCreated,
                markers: marker,
                onTap: (pos){
                  openMap();
                },
                initialCameraPosition: initialCameraPosition,
              ),
            ),
          ),
          SizedBox(height: 40,),
        ],
      ),
    );
  }

}

