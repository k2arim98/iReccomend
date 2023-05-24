import 'dart:developer';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:irecommend/data/data.dart';
import 'package:irecommend/providers/appState.dart';
import 'package:irecommend/screens/home/UI/details.dart';
import 'package:irecommend/screens/home/provider/homeProvider.dart';
import 'package:provider/provider.dart';

import 'model_items.dart';

class Model extends StatefulWidget {
  final double padding;
  final double spacing;

  const Model({
    Key? key,
    required this.padding,
    required this.spacing,
  }) : super(key: key);

  @override
  State<Model> createState() => _ModelState();
}

class _ModelState extends State<Model> {
  late final ScrollController _scrollController;
  
  late final double _indexFactor;
  HomeProvider? providerTrue;
  HomeProvider? providerFalse;
  AppState? appState;
  static const _imageWidth = 180.0;
  double _imageOffset = 0.0;
int p=0;
  @override
  void initState() {
    final deviceWidth =
        (window.physicalSize.shortestSide / window.devicePixelRatio);
    _indexFactor = (widget.spacing + _imageWidth) / deviceWidth;
    _imageOffset = -widget.padding / deviceWidth;

    _scrollController = ScrollController();
    _scrollController.addListener(() {
      setState(() {
        _imageOffset =
            ((_scrollController.offset - widget.padding) / deviceWidth);
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    providerTrue = Provider.of<HomeProvider>(context, listen: true);
    providerFalse = Provider.of<HomeProvider>(context);
appState=Provider.of<AppState>(context);
    return Column(
      children: [
        SizedBox(
          height: 240,
          child:providerFalse!.loading? CircularProgressIndicator(): ListView.separated(
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.symmetric(horizontal: widget.padding),
            controller: _scrollController,
            scrollDirection: Axis.horizontal,
            separatorBuilder: (_, __) => SizedBox(width: widget.spacing),
            itemCount: providerFalse!.categoryL.length>5?5:providerFalse!.categoryL.length,
            itemBuilder: (_, index) => GestureDetector(
              onTap: () {
           
                 
                providerFalse!.setDetailPage(providerFalse!.categoryL[index].data());
              
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Details(
                          index: index, hero: "${providerFalse!.categoryL[index].data()["city"]}$index")),
                );
              },
              child: SizedBox(
                height: 240,
                width: 200,
                child: Card(
                  elevation: 3,
                  // color: Colors.red,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          child: ModelItems(
                              index: index,
                              img: providerFalse!.categoryL[index].data()["image"],
                              imageWidth: _imageWidth,
                              imageOffset: _imageOffset,
                              indexFactor: _indexFactor,
                              hero: "${providerFalse!.categoryL[index].data()["city"]}$index"),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          alignment: Alignment.centerLeft,
                          // color: Colors.green,
                          width: double.infinity,
                          margin: const EdgeInsets.only(
                              left: 15, bottom: 10, right: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                providerFalse!.categoryL[index].data()["name"],
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  color: kSecondaryColor,
                                  fontSize: 22,
                                  letterSpacing: 1.3,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.location_city_rounded,
                                    color: kSecondaryColor.withOpacity(0.5),
                                    size: 18,
                                  ),
                                  const SizedBox(width: 2),
                                  Text(
                                    providerFalse!.categoryL[index].data()["city"],
                                    style: TextStyle(
                                      color: kSecondaryColor.withOpacity(0.5),
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
