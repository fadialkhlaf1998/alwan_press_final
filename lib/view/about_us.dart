import 'dart:async';

import 'package:alwan_press/app_localization.dart';
import 'package:alwan_press/helper/app.dart';
import 'package:alwan_press/helper/myTheme.dart';
import 'package:alwan_press/widget/connect_us_widget.dart';
import 'package:alwan_press/widget/darkModeBackground.dart';
import 'package:flutter/material.dart';
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

                height: MediaQuery.of(context).size.height,
                child: Column(
                  children: [
                    _header(context),
                    _body(context)
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }


  _header(context){
    return Container(
      padding: const EdgeInsets.only(top: 30,bottom: 30),
      width: MediaQuery.of(context).size.width,
      height: 100,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          IconButton(
              onPressed: (){
                Get.back();
              },
              icon: Icon(
                Icons.arrow_back_ios,
                color: Theme.of(context).dividerColor,
                size: 22,
              )
          ),
          const SizedBox(width: 5),
          Text(
            App_Localization.of(context).translate('about_us'),
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
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
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height- 140 - MediaQuery.of(context).padding.top,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Text(
              App_Localization.of(context).translate("alwan_printing_press"),
              style: TextStyle(
                  color: MyTheme.isDarkTheme.value?Colors.white:Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold
              ),
            ),
            SizedBox(height: 10,),
            Container(
              height: 5,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [
                      App.blue.withOpacity(0.0),
                      App.blue.withOpacity(0.0),
                      App.blue.withOpacity(0.0),
                      App.blue.withOpacity(0.0),
                      App.blue.withOpacity(0.0),
                      App.blue.withOpacity(0.0),
                      App.blue.withOpacity(0.0),
                      App.blue.withOpacity(0.1),
                      App.blue.withOpacity(0.2),
                      App.blue.withOpacity(0.3),
                      App.blue.withOpacity(0.4),
                      App.blue.withOpacity(0.5),
                      App.blue.withOpacity(0.6),
                      App.blue.withOpacity(0.8),
                    ],
                  )
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.width*0.6,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/image/about_us.webp"),
                      fit: BoxFit.cover
                  )
              ),
            ),
            SizedBox(height: 10,),
            Container(
              width: MediaQuery.of(context).size.width*0.9,
              child: Text(
                App_Localization.of(context).translate("about_content"),
                style: TextStyle(
                  color: MyTheme.isDarkTheme.value?Colors.white.withOpacity(0.5):Colors.black.withOpacity(0.5),
                  fontSize: 14,
                ),
              ),
            ),
            SizedBox(height: 20,),
            GestureDetector(
              onTap: (){
                openMap();
              },
              child: Container(
                height: MediaQuery.of(context).size.width/2,
                width: MediaQuery.of(context).size.width*0.9,
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
            )
          ],
        ),
      ),
    );
  }

}

