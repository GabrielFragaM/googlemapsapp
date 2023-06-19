import 'package:flutter/material.dart';

class ThemeApp {
  ///https://mapstyle.withgoogle.com/
  static const String mapTheme = '''
[
  {
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#212121"
      }
    ]
  },
  {
    "elementType": "labels.icon",
    "stylers": [
      {
        "visibility": "off"
      }
    ]
  },
  {
    "elementType": "labels.text",
    "stylers": [
      {
        "color": "#d1d1d1"
      }
    ]
  },
  {
    "elementType": "labels.text.stroke",
    "stylers": [
      {
        "color": "#212121"
      }
    ]
  },
  {
    "featureType": "poi",
    "stylers": [
      {
        "visibility": "off"
      }
    ]
  },
  {
    "featureType": "poi",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#757575"
      }
    ]
  },
  {
    "featureType": "poi.park",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#181818"
      }
    ]
  },
  {
    "featureType": "poi.park",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#616161"
      }
    ]
  },
  {
    "featureType": "poi.park",
    "elementType": "labels.text.stroke",
    "stylers": [
      {
        "color": "#1b1b1b"
      }
    ]
  },
  {
    "featureType": "road",
    "elementType": "geometry.fill",
    "stylers": [
      {
        "color": "#575757"
      }
    ]
  },
  {
    "featureType": "road",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#d1d1d1"
      }
    ]
  },
  {
    "featureType": "transit",
    "stylers": [
      {
        "visibility": "off"
      }
    ]
  },
  {
    "featureType": "transit",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#757575"
      }
    ]
  },
  {
    "featureType": "water",
    "stylers": [
      {
        "color": "#848c9a"
      }
    ]
  }
]
''';

  static Color themeMainColor = Colors.blue;
  static Color themeScaffoldBackgroundColor = Colors.white;
  static Color themeCursorColor = Colors.black;
  static Color themeTextColor = Colors.white;

  //CONTAINER DETAILS BACKGROUND COLOR
  static Color themeContainerDetailsColor = const Color(0xD7FFFFFF);
  static Color themeAppBarDetailsColor = const Color(0xECEAEAEA);
  static Color themeIconsDetailsColor = Colors.black;
  static Color themeTextDetailsColor = const Color(0xFF6C6C6C);

  factory ThemeApp() => ThemeApp._internal();
  ThemeApp._internal();
}
