// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:irecommend/data/data.dart';
import 'package:irecommend/screens/home/Models/model_items.dart';
import 'package:irecommend/screens/home/UI/details.dart';

class Another extends StatefulWidget {
  const Another({Key? key}) : super(key: key);

  @override
  State<Another> createState() => _AnotherState();
}

class _AnotherState extends State<Another> {
  final ScrollController _scrollController = ScrollController();
  late final double _indexFactor;

  static const _imageWidth = 180.0;
  double _imageOffset = 0.0;

  @override
  void initState() {
    final deviceWidth =
        (window.physicalSize.shortestSide / window.devicePixelRatio);
    _indexFactor = (8 + _imageWidth) / deviceWidth;
    _imageOffset = -8 / deviceWidth;

    _scrollController.addListener(() {
      setState(() {
        _imageOffset = ((_scrollController.offset - 8) / deviceWidth);
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: ListView.separated(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 8),
            controller: _scrollController,
            separatorBuilder: (_, __) => const SizedBox(width: 8),
            itemCount: data.length,
            itemBuilder: (_, index) => GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Details(
                          index: index, hero: "${data[index]["city"]}$index")),
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
                              imageWidth: MediaQuery.of(context).size.width,
                              imageOffset: _imageOffset,
                              indexFactor: _indexFactor,
                              hero: "${data[index]["city"]}$index"),
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
                                data[index]["city"],
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
                                    Icons.ac_unit,
                                    color: kSecondaryColor.withOpacity(0.5),
                                    size: 18,
                                  ),
                                  const SizedBox(width: 2),
                                  Text(
                                    data[index]["city"],
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
      ),
    );
  }
}
