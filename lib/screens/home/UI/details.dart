// ignore_for_file: unnecessary_const, prefer_const_constructors

import 'dart:async';
import 'dart:developer';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:irecommend/data/data.dart';
import 'package:irecommend/screens/home/UI/CommentSection.dart';
import 'package:irecommend/screens/home/provider/homeProvider.dart';
import 'package:provider/provider.dart';

class Details extends StatefulWidget {
  final int index;
  final String hero;
  const Details({Key? key, required this.index, required this.hero})
      : super(key: key);

  @override
  State<Details> createState() => DdetailsState();
}

class DdetailsState extends State<Details> {
 late HomeProvider providerFalse;
  final _controller = ScrollController();
  ScrollPhysics _physics = const ClampingScrollPhysics();
  bool appBarVAR = false;
  bool bottomBarImagesVAR = false;

  Future run() async {
    await Future.delayed(const Duration(milliseconds: 350));
    setState(() {
      appBarVAR = true;
      bottomBarImagesVAR = true;
    });
  }

  @override
  void initState() {
    super.initState();
    try {
      run();
    } catch (e) {
      debugPrint("$e");
    }
    _controller.addListener(() {
      if (_controller.position.pixels <= 100) {
        setState(() => _physics = const ClampingScrollPhysics());
      } else {
        setState(() => _physics = const BouncingScrollPhysics());
      }
    });
  }
 final Completer<GoogleMapController> _controllerm =
      Completer<GoogleMapController>();

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  static const CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);
  @override
  Widget build(BuildContext context) {
    double displayWidth = MediaQuery.of(context).size.width;
    double displayHeight = MediaQuery.of(context).size.height;
    providerFalse = Provider.of<HomeProvider>(context);
    return Scaffold(
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          SafeArea(
              child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            controller: _controller,
            physics: _physics,
            child: Column(
              children: [
                Material(
                  borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(40),
                      bottomRight: Radius.circular(40)),
                  elevation: 4,
                  child: Hero(
                    tag: widget.hero,
                    child: Container(
                      height: displayHeight / 2,
                      width: displayWidth,
                      decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(40),
                              bottomRight: Radius.circular(40)),
                          image: DecorationImage(
                              image: AssetImage(providerFalse.detailPage["image"]),
                              fit: BoxFit.cover)),
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          AnimatedCrossFade(
                            firstChild: Container(),
                            secondChild: appBar(providerFalse),
                            crossFadeState: appBarVAR
                                ? CrossFadeState.showSecond
                                : CrossFadeState.showFirst,
                            duration: const Duration(milliseconds: 400),
                          ),
                          AnimatedCrossFade(
                            firstChild: Container(),
                            secondChild: bottomBarImages(),
                            crossFadeState: appBarVAR
                                ? CrossFadeState.showSecond
                                : CrossFadeState.showFirst,
                            duration: const Duration(milliseconds: 600),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                Container(
                  width: displayWidth,
                  margin:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                          providerFalse.detailPage["name"],
                            style: const TextStyle(
                              color: kSecondaryColor,
                              fontSize: 25,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                           providerFalse.detailPage["category"],
                            style: const TextStyle(
                              color: kSecondaryColor,
                              fontSize: 15,
                              fontFamily: 'Montserrat',
                            ),
                          )
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: const [
                          Text(
                            "\$20",
                            style: TextStyle(
                              color: kSecondaryColor,
                              fontSize: 24,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            "per person",
                            style: TextStyle(
                              color: kSecondaryColor,
                              fontSize: 15,
                              fontFamily: 'Montserrat',
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                Divider(
                  color: Colors.black38.withOpacity(0.2),
                  endIndent: 20,
                  indent: 20,
                  height: 4,
                ),
                const SizedBox(height: 15),
                const ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Color(0xffeaeaea),
                    radius: 26,
                    child: Icon(
                      Icons.pin_drop,
                      color: kSecondaryColor,
                    ),
                  ),
                  title: Text(
                    "Pizza del Colosseum 1, Rome",
                    style: TextStyle(
                      color: kSecondaryColor,
                      fontSize: 15,
                      fontFamily: 'Montserrat',
                    ),
                  ),
                ),
                ListTile(
                  isThreeLine: false,
                  leading: const CircleAvatar(
                    backgroundColor: Color(0xffeaeaea),
                    radius: 26,
                    child: Icon(
                      Icons.hourglass_bottom_rounded,
                      color: kSecondaryColor,
                    ),
                  ),
                  title: Text(
                    "OPEN",
                    style: TextStyle(
                      color: kSecondaryColor.withOpacity(0.4),
                      fontSize: 15,
                      fontFamily: 'Montserrat',
                    ),
                  ),
                  subtitle: const Text(
                    "09.00 AM",
                    style: TextStyle(
                      color: kSecondaryColor,
                      fontSize: 15,
                      fontFamily: 'Montserrat',
                    ),
                  ),
                  trailing: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () async {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => TestMe()),
                          );
                        },
                        child: const Text(
                          "See Visitors Comments",
                          style: TextStyle(
                            color: Colors.blue,
                            fontSize: 12,
                            fontFamily: 'Montserrat',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 200,
                  width: displayWidth,
                  margin:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  decoration: const BoxDecoration(
                      
                      borderRadius: BorderRadius.all(Radius.circular(14)),
                    ),
                    child: GoogleMap( mapType: MapType.normal,
        initialCameraPosition: _kGooglePlex,
        onMapCreated: (GoogleMapController controller) {
         _controllerm.complete();
        },
      ),
                    
                    ),


                    
                
              ],
            ),
          )),
          // Container(
          //     margin: EdgeInsets.all(displayWidth * .05),
          //     height: displayWidth * .155,
          //     alignment: Alignment.center,
          //     decoration: const BoxDecoration(
          //         color: Color(0xff140c47),
          //         borderRadius: BorderRadius.all(Radius.circular(35))),
          //     child: GestureDetector(
          //       onTap: () => Navigator.of(context).pop(),
          //       child: Row(
          //         mainAxisAlignment: MainAxisAlignment.center,
          //         children: const [
          //           Text(
          //             "Book Now ",
          //             style: TextStyle(
          //               color: Colors.white,
          //               fontSize: 18,
          //               fontFamily: 'Montserrat',
          //               fontWeight: FontWeight.bold,
          //             ),
          //           ),
          //           SizedBox(width: 5),
          //           Icon(
          //             Icons.check,
          //             color: Colors.white,
          //           )
          //         ],
          //       ),
          //     )),
       
        ],
      ),
    );
  }

  Widget appBar(HomeProvider provid) {
    return Row(
      children: [
        Align(
          alignment: Alignment.topRight,
          child: GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(32),
                child: Container(
                  width: 48,
                  height: 48,
                  color: Colors.white,
                  child: const Icon(
                    Icons.arrow_back_ios,
                    color: Colors.black87,
                  ),
                ),
              ),
            ),
          ),
        ),
        const Spacer(),
        Align(
          alignment: Alignment.topRight,
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: GestureDetector(
              onTap: () {
                log("favorite buttton clicked");
                FirebaseFirestore.instance.collection("users").doc(provid.userData["uid"]).collection("favorite").doc(provid.detailPage["name"]).set(provid.detailPage);
                FirebaseFirestore.instance.collection("data").doc(provid.detailPage["uid"]).update({
                  "liked":provid.detailPage["liked"]+1
                });
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(32),
                child: Container(
                  width: 48,
                  height: 48,
                  color: Colors.white,
                  child: const Icon(
                    Icons.favorite,
                    color: Colors.black87,
                  ),
                ),
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.topRight,
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(32),
              child: Container(
                width: 48,
                height: 48,
                color: Colors.white,
                child: const Icon(
                  Icons.check_box,
                  color: Colors.black87,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget bottomBarImages() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 22),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
            child: Container(
              height: 90,
              color: kSecondaryColor.withOpacity(0.25),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Row(
                  children: [
                    ...List.generate(
                        data.length,
                        (index) => Expanded(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 4, vertical: 10),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(24),
                                  child: Stack(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(24)),
                                            image: DecorationImage(
                                                image: AssetImage(
                                                    data[index]["image"]),
                                                fit: BoxFit.cover)),
                                      ),
                                      index == (data.length - 1)
                                          ? Container(
                                              color: Colors.blue.shade800
                                                  .withOpacity(0.4),
                                              child: const Center(
                                                child: Text(
                                                  "+5",
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 22,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                            )
                                          : Container()
                                    ],
                                  ),
                                ),
                              ),
                            ))
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
