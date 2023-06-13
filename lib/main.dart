// 현재 위치 구글맵으로 표시해주는 page를 만들었습니다. 실행시 에뮬레이터 현재 위치 default 값이 구글 본사이어서 계속 한 곳 만 뜰 겁니다.
// 길찾기 구현은 실패해서 현재 위치 구글맵으로 뿌리는 것으로 대체했습니다.
// 구동 잘 안될 시 아래 콘솔 창 오류 잘 봐주세요.
// 이 앱이 애뮬레이터에서 구동되기 위해 androidMainifest.xml 에서 구글 qpi 키가 필요합니다. 구글링하시면 됩니다! 그리고
// <uses-permission android:name="android.permission.ACCESS_FINE_LOCATION" />
// <uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION" />
// 위 두 문장도 andriodMainifest.xml 에 참조해야 하는데 위치를 모르시면 이것도 구글링 하시면 됩니다!
// 전체적으로 모르시겠다면 flutter 구글맵 빈 화면이라고 검색하시면 됩니다.
// pubspec.yaml 도 잘 확인하셔서 pub.get 잘 해주셔야 됩니다!

// @dart=2.9
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:geolocator/geolocator.dart';
import 'package:pokemon_bread/widget/tab_bar.dart';
import 'package:pokemon_bread/screen/location_screen.dart';
import 'package:pokemon_bread/service/geolocator_service.dart';
import 'package:pokemon_bread/model/place.dart';
import 'package:pokemon_bread/service/places_service.dart';
import 'package:pokemon_bread/screen/favorite_screen.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:pokemon_bread/screen/second_screen.dart';
import 'package:pokemon_bread/screen/fourth_screen.dart';
import 'dart:async';
import 'dart:core';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp>{
  final locatorService = GeoLocatorService();
  final placeService = PlacesService();
  List<String> savedWords = List<String>();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // place
        FutureProvider(create: (context) => locatorService.getLocation()),
        ProxyProvider< Position ,Future<List<Place>>>(
          update: (context,position,places){
            return (position != null)
                ? placeService.getPlaces(position.latitude, position.longitude)
                : null;
          },
        ),

      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Detective Pikachu',
        theme: ThemeData(
          brightness: Brightness.light,
          primaryColor: Colors.black,
        ),
        home: DefaultTabController(
            length: 4,
            child: Scaffold(
              body: TabBarView(
                physics: NeverScrollableScrollPhysics(),
                children: <Widget>[
                  Location(),
                  SecondPage(),
                  FavoriteWordsRoute(favoriteItems: []),
                  FourthApp()
                ],
              ),
              bottomNavigationBar: BottomBar(),
            )
        ),
      ),
    );
  }
}

/*
        initialRoute: '/',
        routes: {
          '/': (context) => FavoriteList(),
          '/favoritepage': (context) => FavoritePage(),
        },
        */