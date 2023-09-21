import 'package:flutter/material.dart';
import 'package:irecommend/utility/constant.dart';

// ! Routing
int currentIndex = 0;
int colorIndex = 0;
// ! Routing

List bottomBar = [
  const Icon(
    Icons.home,
    color: Colors.white,
  ),
  const Icon(
    Icons.favorite,
    color: Colors.white,
  ),
  const Icon(
    Icons.save_alt_outlined,
    color: Colors.white,
  ),
];
var customLang = {
  'fancy': 1,
  'sea': 1,
  'fun': 1,
  'family': 1,
  'love': 1,
  'instagood': 1,
  'fashion': 1,
  'art': 1,
  'beautiful': 1,
  'nature': 1,
  'travel': 1,
  'happy': 1,
  'style': 1,
  'summer': 1,
  'music': 1,
  'amazing': 1,
  'sunset': 1,
  'shopping': 1,
  'beach': 1,
  'wedding': 1,
  'girls': 1,
  'healthy': 1,
  'cool': 1,
  'eats': 1,
  'pizza': 1,
  'oran': 1,
  'best': 1,
  'mostaganem': 1
};
List data = [
  {
    "city": 'HotelAz',
    "country": 'England',
    "rating": '4.5',
    'image': 'assets/images/HotelAz.jpg',
    "type": 'city'
  },
  {
    "city": 'HotelAz',
    "country": 'England',
    "rating": '4.5',
    'image': 'assets/images/HotelAz.jpg',
    "type": 'city'
  },
  {
    "city": 'HotelAz',
    "country": 'England',
    "rating": '4.5',
    'image': 'assets/images/HotelAz.jpg',
    "type": 'city'
  },
  {
    "city": 'HotelAz',
    "country": 'England',
    "rating": '4.5',
    'image': 'assets/images/HotelAz.jpg',
    "type": 'city'
  },
];
List data_2 = [
  {"name": 'food', 'image': 'assets/images/food.png', 'index': 0},
  {"name": 'hotel', 'image': 'assets/images/hotel.png', 'index': 1},
  {"name": 'Park', 'image': 'assets/images/park.png', 'index': 2},
  {"name": 'forest', 'image': 'assets/images/camp.png', 'index': 3},
  {"name": 'shops', 'image': 'assets/images/shops.png', 'index': 4},
  {"name": 'beach', 'image': 'assets/images/flaye.png', 'index': 5},
];
final categoryList = [
  "All",
  'Recommended',
  "For You",
  'Most Viewd',
  'Most Liked'
];

// Colors
const kAvatarColor = Color(0xffffdbc9);
const kPrimaryColor = Color(0xFFEEF7FF);
const kSecondaryColor = Color.fromARGB(255, 19, 15, 14);
