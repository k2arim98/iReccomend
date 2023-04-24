import 'package:flutter/material.dart';

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

List data = [
  {
    "city": 'Oran',
    "country": 'Algerie',
    "rating": '4.6',
    'image': 'assets/images/HotelPacha.jpg',
    "type": 'Beach'
  },
  {
    "city": 'Oran',
    "country": 'Algerie',
    "rating": '4.8',
    'image': 'assets/images/HotelRoyal.jpg',
    "type": 'Beach'
  },
  {
    "city": 'Oran',
    "country": 'Algerie',
    "rating": '4.4',
    'image': 'assets/images/HotelAz.jpg',
    "type": 'buildings'
  },
  {
    "city": 'Oran',
    "country": 'Algerie',
    "rating": '4.5',
    'image': 'assets/images/Saiko-Sushi-Oran.png',
    "type": 'city'
  },
    {
    "city": 'HotelAz',
    "country": 'England',
    "rating": '4.5',
    'image': 'assets/images/HotelAz.jpg',
     "type":'city'
  },
    {
    "city": 'HotelAz',
    "country": 'England',
    "rating": '4.5',
    'image': 'assets/images/HotelAz.jpg',
     "type":'city'
  },
    {
    "city": 'HotelAz',
    "country": 'England',
    "rating": '4.5',
    'image': 'assets/images/HotelAz.jpg',
     "type":'city'
  },
    {
    "city": 'HotelAz',
    "country": 'England',
    "rating": '4.5',
    'image': 'assets/images/HotelAz.jpg',
     "type":'city'
  },
    {
    "city": 'HotelAz',
    "country": 'England',
    "rating": '4.5',
    'image': 'assets/images/HotelAz.jpg',
     "type":'city'
  },
];
List data_2 = [
  {"name": 'food', 'image': 'assets/images/flaye.png', 'index': 0},
  {"name": 'hotel', 'image': 'assets/images/beach.png', 'index': 1},
  {"name": 'Park', 'image': 'assets/images/park.png', 'index': 2},
  {"name": 'beach', 'image': 'assets/images/camp.png', 'index': 3},
  {"name": 'shops', 'image': 'assets/images/flaye.png', 'index': 4},
  {"name": 'forest', 'image': 'assets/images/beach.png', 'index': 5},
];
final categoryList = ['Populare', 'Recommended', 'Most Viewd', 'Most Liked'];

// Colors
const kAvatarColor = Color(0xffffdbc9);
const kPrimaryColor = Color(0xFFEEF7FF);
const kSecondaryColor = Color(0xFF29303D);
