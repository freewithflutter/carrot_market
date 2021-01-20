import 'package:carrot_market/model/item_model.dart';
import 'package:carrot_market/provider/item_provider.dart';
import 'package:carrot_market/repository/data.dart';
import 'package:carrot_market/screen/additem/additem_screen.dart';
import 'package:carrot_market/screen/detail_screen/detail_screen.dart';
import 'package:carrot_market/util/default.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:carrot_market/util/default.dart';
import 'package:hawk_fab_menu/hawk_fab_menu.dart';
import 'package:provider/provider.dart';

class App extends StatefulWidget {
  LocationData locationData = LocationData();
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  String currentLocation;
  int _currentPageIndex = 0;
  final _store = FirebaseFirestore.instance;
  @override
  void initState() {
    _currentPageIndex = 0;
    currentLocation = 'suyou';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ItemProvider>(context, listen: false);
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final Map<String, String> locationTypeToString = {
      'suyou': '수유2동',
      'mia': '미아동',
      'gil': '길음동'
    };
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(45),
          child: AppBar(
            brightness: Brightness.light,
            actionsIconTheme: IconThemeData(
              size: 23,
              color: kBlackColor,
            ),
            backgroundColor: Colors.white,
            elevation: 1,
            title: GestureDetector(
              onTap: () {},
              child: Container(
                width: double.infinity,
                child: PopupMenuButton<String>(
                  offset: Offset(0, 80),
                  shape: ShapeBorder.lerp(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0)),
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0)),
                      1),
                  onSelected: (String selectedPlace) {
                    print(selectedPlace);
                    setState(() {
                      currentLocation = selectedPlace;
                    });
                  },
                  itemBuilder: (BuildContext context) {
                    return [
                      PopupMenuItem(value: 'suyou', child: Text('아라동')),
                      PopupMenuItem(value: 'mia', child: Text('미아동')),
                      PopupMenuItem(value: 'gil', child: Text('길음동'))
                    ];
                  },
                  child: Row(
                    children: [
                      Text(
                        locationTypeToString[currentLocation],
                        style: TextStyle(
                          color: kBlackColor,
                        ),
                      ),
                      Icon(
                        Icons.expand_more,
                        size: 30,
                        color: kBlackColor,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            actions: [
              GestureDetector(onTap: () {}, child: Icon(Icons.search)),
              Container(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child:
                      GestureDetector(onTap: () {}, child: Icon(Icons.tune))),
              GestureDetector(onTap: () {}, child: Icon(FontAwesomeIcons.bell)),
              SizedBox(
                width: 20,
              ),
            ],
          ),
        ),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
              border: Border(
                  top: BorderSide(
            color: Colors.grey,
            width: 0.3,
          ))),
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            onTap: (int index) {
              setState(() {
                _currentPageIndex = index;
              });
            },
            backgroundColor: Colors.white,
            currentIndex: _currentPageIndex,
            unselectedFontSize: 12,
            selectedFontSize: 12,
            selectedIconTheme: IconThemeData(
              color: Colors.black,
            ),
            selectedItemColor: Colors.black,
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                  activeIcon: Container(
                      padding: EdgeInsets.only(bottom: 8),
                      child: SvgPicture.asset('assets/svg/home_on.svg',
                          width: 20)),
                  icon: Container(
                    padding: EdgeInsets.only(bottom: 8),
                    child:
                        SvgPicture.asset('assets/svg/home_off.svg', width: 20),
                  ),
                  label: '홈'),
              BottomNavigationBarItem(
                  activeIcon: Container(
                      padding: EdgeInsets.only(bottom: 8),
                      child: SvgPicture.asset('assets/svg/notes_on.svg',
                          width: 20)),
                  icon: Container(
                      padding: EdgeInsets.only(bottom: 8),
                      child: SvgPicture.asset('assets/svg/notes_off.svg',
                          width: 20)),
                  label: '동네생활'),
              BottomNavigationBarItem(
                  activeIcon: Container(
                      padding: EdgeInsets.only(bottom: 8),
                      child: SvgPicture.asset('assets/svg/location_on.svg',
                          width: 20)),
                  icon: Container(
                    padding: EdgeInsets.only(bottom: 8),
                    child: SvgPicture.asset('assets/svg/location_off.svg',
                        width: 20),
                  ),
                  label: '내 근처'),
              BottomNavigationBarItem(
                  activeIcon: Container(
                    padding: EdgeInsets.only(bottom: 8),
                    child: SvgPicture.asset(
                      'assets/svg/chat_on.svg',
                      width: 20,
                    ),
                  ),
                  icon: Container(
                    padding: EdgeInsets.only(bottom: 8),
                    child: SvgPicture.asset(
                      'assets/svg/chat_off.svg',
                      width: 20,
                    ),
                  ),
                  label: '채팅'),
              BottomNavigationBarItem(
                  activeIcon: Container(
                    padding: EdgeInsets.only(bottom: 8),
                    child:
                        SvgPicture.asset('assets/svg/user_on.svg', width: 20),
                  ),
                  icon: Container(
                    padding: EdgeInsets.only(bottom: 8),
                    child:
                        SvgPicture.asset('assets/svg/user_off.svg', width: 20),
                  ),
                  label: '나의 당근'),
            ],
          ),
        ),
        body: BodyWidget(
          provider: provider,
          number: _currentPageIndex,
        ));
  }
}

class BodyWidget extends StatelessWidget {
  const BodyWidget({
    Key key,
    @required this.provider,
    this.number,
  }) : super(key: key);

  final ItemProvider provider;
  final int number;

  @override
  Widget build(BuildContext context) {
    switch (number) {
      case 0:
        return FutureBuilder(
            future: _loadContent(),
            builder: (context, snapshot) {
              return Builder(
                builder: (BuildContext context) => HawkFabMenu(
                  icon: AnimatedIcons.add_event,
                  fabColor: kMainColor,
                  iconColor: Colors.white,
                  items: [
                    HawkFabMenuItem(
                      label: '동네홍보',
                      ontap: () {
                        Scaffold.of(context)..hideCurrentSnackBar();
                        Scaffold.of(context).showSnackBar(
                          SnackBar(content: Text('No UI')),
                        );
                      },
                      icon: Icon(FontAwesomeIcons.houseDamage),
                      color: kMainColor,
                    ),
                    HawkFabMenuItem(
                      label: '중고거래',
                      ontap: () {
                        Navigator.pushNamed(context, AddItem.id);
                      },
                      icon: Icon(FontAwesomeIcons.pen),
                      color: kMainColor,
                    ),
                  ],
                  body: Container(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: Container(
                      child: StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection('Items')
                            .snapshots(),
                        builder: (BuildContext context,
                            AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (snapshot.hasData) {
                            return Container(
                              child: ListView.separated(
                                  padding: EdgeInsets.only(top: 20),
                                  shrinkWrap: true,
                                  itemCount: provider.itemLists.length,
                                  separatorBuilder:
                                      (BuildContext _context, int index) {
                                    return Container(
                                      height: 1,
                                      margin:
                                          EdgeInsets.symmetric(vertical: 15),
                                      color: kDividerColor,
                                    );
                                  },
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return FlatButton(
                                      padding: EdgeInsets.zero,
                                      onPressed: () {
                                        provider.selectedItem =
                                            provider.itemLists[index];
                                        Navigator.pushNamed(
                                            context, DetailItem.id);
                                      },
                                      child: Container(
                                        child: Column(
                                          children: [
                                            Row(
                                              children: [
                                                Container(
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            7.0),
                                                    child: Image.network(
                                                      provider.itemLists[index]
                                                          .image,
                                                      width: 110,
                                                      height: 110,
                                                      fit: BoxFit.fill,
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Container(
                                                    height: 110,
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 20),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          provider
                                                              .itemLists[index]
                                                              .title,
                                                          style: TextStyle(
                                                              fontSize: 17,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                        ),
                                                        Container(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  top: 2,
                                                                  bottom: 3),
                                                          child: Text(
                                                            '${provider.itemLists[index].place} · ${provider.itemLists[index].lastTime}초 전',
                                                            style: TextStyle(
                                                              fontSize: 13,
                                                            ),
                                                          ),
                                                        ),
                                                        Text(
                                                          provider
                                                              .itemLists[index]
                                                              .price,
                                                          style: TextStyle(
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  }),
                            );
                          } else {
                            return Center(
                              child: Text('there is no data'),
                            );
                          }
                        },
                      ),
                    ),
                  ),
                ),
              );
            });

        break;
      case 1:
        return Container();
        break;
      case 2:
        return Container();
        break;
      case 3:
        return Container();
        break;
      case 4:
        return Container();
        break;
    }
  }
}
