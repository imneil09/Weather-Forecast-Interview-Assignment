import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'view/home_view.dart';

void main() {
  runApp(GetMaterialApp(
      title: 'Weather Forecast',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeView(),
    ));
}
