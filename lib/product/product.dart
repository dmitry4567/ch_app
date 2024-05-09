import 'dart:convert';
import 'dart:developer';
import 'dart:js_interop';

import 'package:LockStore/backend/api_requests/api_calls.dart';
import 'package:LockStore/flutter_flow/flutter_flow_widgets.dart';
import 'package:LockStore/home/model.dart';
import 'package:LockStore/layout/adaptive.dart';
import 'package:LockStore/product/widgets/desktop/call_widget.dart';
import 'package:LockStore/product/widgets/desktop/description_widget.dart';
import 'package:LockStore/product/widgets/desktop/feature_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;

class ProductPage extends StatefulWidget {
  const ProductPage({super.key});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  Future<Product?> getDataOneProduct() async {
    try {
      final response =
          await http.get(Uri.parse("$baseUrl/products/1"), headers: {
        "Access-Control-Allow-Origin": "*",
        'Content-Type': 'application/json',
        'Accept': '*/*'
      });

      if (response.statusCode == 200) {
        Map<String, dynamic> project = jsonDecode(response.body);

        return Product.fromJson(project);
      }
    } catch (error) {
      return null;
    }
    return null;
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() async {
    data = await getDataOneProduct();
  }

  Product? data;

  String _currentPageName = 'Feature';

  int choosePhoto = 0;

  @override
  Widget build(BuildContext context) {
    final isDesktop = isDisplayDesktop(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: isDesktop
          ? SizedBox(
              height: double.infinity,
              child: FutureBuilder<Product?>(
                future: data == null ? getDataOneProduct() : null,
                builder:
                    (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: Color(0xFF4295E4),
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else {
                    if (snapshot.hasData) {
                      Map<String, Widget> _tabs = {
                        'Feature': FeatureWidget(
                          material: data!.material,
                        ),
                        'Description': const DescriptionWidget(),
                        'Comments': const Text("Comments"),
                      };
                      return SingleChildScrollView(
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                left: 100,
                                right: 100,
                                top: 82 + 86,
                              ),
                              child: Center(
                                child: SizedBox(
                                  width: 1232,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Expanded(
                                            child: Column(
                                              children: [
                                                Container(
                                                  width: 600,
                                                  height: 600,
                                                  alignment:
                                                      Alignment.centerRight,
                                                  child: CachedNetworkImage(
                                                    imageUrl:
                                                        "$baseUrl/photoItem/product/${snapshot.data.photos[choosePhoto].fileName}",
                                                    fit: BoxFit.cover,
                                                    placeholder: (context,
                                                            url) =>
                                                        const Center(
                                                            child:
                                                                CircularProgressIndicator()),
                                                    errorWidget: (context, url,
                                                            error) =>
                                                        const Icon(Icons.error),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 20,
                                                ),
                                                SizedBox(
                                                  height: 140,
                                                  child: ListView.builder(
                                                    itemCount: snapshot
                                                        .data.photos.length,
                                                    scrollDirection:
                                                        Axis.horizontal,
                                                    shrinkWrap: true,
                                                    itemBuilder:
                                                        (context, index) {
                                                      return GestureDetector(
                                                        onTap: () {
                                                          setState(() {
                                                            choosePhoto = index;
                                                          });
                                                        },
                                                        child: Container(
                                                          width: 140,
                                                          height: 140,
                                                          decoration:
                                                              BoxDecoration(
                                                            border: Border.all(
                                                              color:
                                                                  Colors.grey,
                                                              width: 0.5,
                                                            ),
                                                          ),
                                                          child:
                                                              CachedNetworkImage(
                                                            imageUrl:
                                                                "$baseUrl/photoItem/product/${snapshot.data.photos[index].fileName}",
                                                            fit: BoxFit.cover,
                                                            placeholder: (context,
                                                                    url) =>
                                                                const Center(
                                                                    child:
                                                                        CircularProgressIndicator()),
                                                            errorWidget: (context,
                                                                    url,
                                                                    error) =>
                                                                const Icon(Icons
                                                                    .error),
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 30,
                                          ),
                                          Expanded(
                                            child: Container(
                                              alignment: Alignment.centerLeft,
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      const Text(
                                                        "JA182765",
                                                        style: TextStyle(
                                                          color:
                                                              Color(0xff454F5B),
                                                          fontSize: 12,
                                                          fontFamily: "SF",
                                                          fontWeight:
                                                              FontWeight.w400,
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        width: 12,
                                                      ),
                                                      SizedBox(
                                                        height: 16,
                                                        child:
                                                            ListView.separated(
                                                          shrinkWrap: true,
                                                          itemCount: 5,
                                                          physics:
                                                              const NeverScrollableScrollPhysics(),
                                                          scrollDirection:
                                                              Axis.horizontal,
                                                          separatorBuilder:
                                                              (context, index) {
                                                            return const SizedBox(
                                                              width: 6,
                                                            );
                                                          },
                                                          itemBuilder:
                                                              (context, index) {
                                                            return index <
                                                                    snapshot
                                                                        .data
                                                                        .rate
                                                                ? SvgPicture.asset(
                                                                    "assets/icons/star_fill.svg")
                                                                : SvgPicture.asset(
                                                                    "assets/icons/star_unfill.svg");
                                                          },
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        width: 8,
                                                      ),
                                                      const Text(
                                                        "(12) отзывов",
                                                        style: TextStyle(
                                                          color:
                                                              Color(0xff4295E4),
                                                          fontSize: 11,
                                                          fontFamily: "SF",
                                                          fontWeight:
                                                              FontWeight.w600,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(
                                                    height: 16,
                                                  ),
                                                  Text(
                                                    snapshot.data.title,
                                                    style: const TextStyle(
                                                      color: Color(0xff161C24),
                                                      fontSize: 22,
                                                      fontFamily: "SF",
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 12,
                                                  ),
                                                  const Text(
                                                    "Подходит для установки на:",
                                                    style: TextStyle(
                                                      color: Color(0xff161C24),
                                                      fontSize: 12,
                                                      fontFamily: "SF",
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 8,
                                                  ),
                                                  const Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Icon(
                                                            Icons.check_box,
                                                            size: 14,
                                                            color: Color(
                                                                0xff4295E4),
                                                          ),
                                                          SizedBox(
                                                            width: 4,
                                                          ),
                                                          Text(
                                                            "Деревянную дверь",
                                                            style: TextStyle(
                                                              color: Color(
                                                                  0xff454F5B),
                                                              fontSize: 12,
                                                              fontFamily: "SF",
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        width: 8,
                                                      ),
                                                      Row(
                                                        children: [
                                                          Icon(
                                                            Icons.check_box,
                                                            size: 14,
                                                            color: Color(
                                                                0xff4295E4),
                                                          ),
                                                          SizedBox(
                                                            width: 4,
                                                          ),
                                                          Text(
                                                            "Межкомнатную дверь",
                                                            style: TextStyle(
                                                              color: Color(
                                                                  0xff454F5B),
                                                              fontSize: 12,
                                                              fontFamily: "SF",
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                            ),
                                                          ),
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                  const SizedBox(
                                                    height: 24,
                                                  ),
                                                  const ColorController(),
                                                  const SizedBox(
                                                    height: 24,
                                                  ),
                                                  Row(
                                                    children: [
                                                      Text(
                                                        "${snapshot.data.price}₽",
                                                        style: const TextStyle(
                                                          color:
                                                              Color(0xff161C24),
                                                          fontSize: 22,
                                                          fontFamily: "SF",
                                                          fontWeight:
                                                              FontWeight.w600,
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        width: 12,
                                                      ),
                                                      Text(
                                                        "${snapshot.data.oldPrice}₽",
                                                        style: const TextStyle(
                                                          color:
                                                              Color(0xffA4A4A4),
                                                          fontSize: 20,
                                                          fontFamily: "SF",
                                                          fontWeight:
                                                              FontWeight.w300,
                                                          decoration:
                                                              TextDecoration
                                                                  .lineThrough,
                                                          decorationColor:
                                                              Color(0xffA4A4A4),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(
                                                    height: 16,
                                                  ),
                                                  Row(
                                                    children: [
                                                      SizedBox(
                                                        width: 288,
                                                        height: 50,
                                                        child: FFButtonWidget(
                                                          onPressed:
                                                              () async {},
                                                          text: 'Купить',
                                                          options:
                                                              const FFButtonOptions(
                                                            width:
                                                                double.infinity,
                                                            height:
                                                                double.infinity,
                                                            color: Color(
                                                                0xff4295E4),
                                                            elevation: 0,
                                                            textStyle:
                                                                TextStyle(
                                                              fontFamily: 'SF',
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        width: 15,
                                                      ),
                                                      GestureDetector(
                                                        onTap: () {},
                                                        child: Container(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: const Row(
                                                            children: [
                                                              Icon(
                                                                Icons
                                                                    .favorite_border,
                                                                color: Color(
                                                                    0xff454F5B),
                                                                size: 20,
                                                              ),
                                                              SizedBox(
                                                                width: 4,
                                                              ),
                                                              Text(
                                                                "В избранное",
                                                                style:
                                                                    TextStyle(
                                                                  color: Color(
                                                                      0xff4D4D4D),
                                                                  fontSize: 12,
                                                                  fontFamily:
                                                                      "SF",
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 40),
                                        child: Row(
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  _currentPageName =
                                                      _tabs.keys.toList()[0];
                                                });
                                              },
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  const Text(
                                                    "Характеристики",
                                                    style: TextStyle(
                                                      color: Color(0xff161C24),
                                                      fontSize: 18,
                                                      fontFamily: "SF",
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  _currentPageName ==
                                                          _tabs.keys.toList()[0]
                                                      ? const SizedBox(
                                                          width: 140,
                                                          child: Divider(
                                                            color: Color(
                                                                0xff4295E4),
                                                            thickness: 3,
                                                            height: 2,
                                                          ),
                                                        )
                                                      : Container(),
                                                ],
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 62,
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  _currentPageName =
                                                      _tabs.keys.toList()[1];
                                                });
                                              },
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  const Text(
                                                    "Описание",
                                                    style: TextStyle(
                                                      color: Color(0xff161C24),
                                                      fontSize: 18,
                                                      fontFamily: "SF",
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  _currentPageName ==
                                                          _tabs.keys.toList()[1]
                                                      ? const SizedBox(
                                                          width: 85,
                                                          child: Divider(
                                                            color: Color(
                                                                0xff4295E4),
                                                            thickness: 3,
                                                            height: 2,
                                                          ),
                                                        )
                                                      : Container(),
                                                ],
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 62,
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  _currentPageName =
                                                      _tabs.keys.toList()[2];
                                                });
                                              },
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  const Text(
                                                    "Отзывы",
                                                    style: TextStyle(
                                                      color: Color(0xff161C24),
                                                      fontSize: 18,
                                                      fontFamily: "SF",
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  _currentPageName ==
                                                          _tabs.keys.toList()[2]
                                                      ? const SizedBox(
                                                          width: 67,
                                                          child: Divider(
                                                            color: Color(
                                                                0xff4295E4),
                                                            thickness: 3,
                                                            height: 2,
                                                          ),
                                                        )
                                                      : Container(),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      _tabs[_currentPageName]!,
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            const CallWidget(),
                          ],
                        ),
                      );
                    } else {
                      return Text("fsef");
                    }
                  }
                },
              ),
            )
          : SizedBox(
              height: double.infinity,
              child: SingleChildScrollView(
                child: Column(
                  children: [],
                ),
              ),
            ),
    );
  }
}

class ColorController extends StatefulWidget {
  const ColorController({super.key});

  @override
  State<ColorController> createState() => _ColorControllerState();
}

class _ColorControllerState extends State<ColorController> {
  List<Color> colors = [
    Colors.white,
    Colors.black,
    Colors.amber,
  ];
  int selectedColor = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Цвет",
          style: TextStyle(
            color: Color(0xff161C24),
            fontSize: 14,
            fontFamily: "SF",
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        SizedBox(
          height: 40,
          child: ListView.builder(
            itemCount: 3,
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedColor = index;
                      });
                    },
                    child: Stack(
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: colors[index],
                            border: Border.all(
                              color: index == selectedColor
                                  ? const Color(0xff4295E4)
                                  : Colors.grey,
                            ),
                          ),
                        ),
                        index == selectedColor
                            ? const Positioned(
                                top: 0,
                                left: 0,
                                right: 0,
                                bottom: 0,
                                child: Icon(
                                  Icons.done,
                                  color: Color(0xff596469),
                                ),
                              )
                            : Container(),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                ],
              );
            },
          ),
        )
      ],
    );
  }
}
