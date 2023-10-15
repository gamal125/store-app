

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:store_app/ShopScreens/ShopeCategoryScreen.dart';
import 'package:store_app/StoreScreeens/StoreCategoryScreen.dart';
import 'package:store_app/cubit/cubit.dart';
import 'package:store_app/shared/components/components.dart';

class TypePage extends StatefulWidget {
const TypePage({super.key, required this.title});

// This widget is the home page of your application. It is stateful, meaning
// that it has a State object (defined below) that contains fields that affect
// how it looks.

// This class is the configuration for the state. It holds the values (in this
// case the title) provided by the parent (in this case the App widget) and
// used by the build method of the State. Fields in a Widget subclass are
// always marked "final".

final String title;

@override
State<TypePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<TypePage> {





@override
Widget build(BuildContext context) {
// This method is rerun every time setState is called, for instance as done
// by the _incrementCounter method above.
//
// The Flutter framework has been optimized to make rerunning build methods
// fast, so that you can just rebuild anything that needs updating rather
// than having to individually change instances of widgets.
return Scaffold(
appBar: AppBar(
  elevation: 0,
// Here we take the value from the MyHomePage object that was created by
// the App.build method, and use it to set our appbar title.
title: Center(child: Text(widget.title)),
),
body: Container(
  width: double.infinity,
  decoration: BoxDecoration(image: DecorationImage(image: AssetImage('assets/images/back.jpg'),fit: BoxFit.cover)),
  child:   Column(

    mainAxisAlignment: MainAxisAlignment.center,

  children: [

    Text('Welcome',style: TextStyle(fontSize: 44,),).animate().tint(color: Colors.blue).then().shake(),

    SizedBox(height: 35,),

    defaultMaterialButton(function: (){
      MainCubit.get(context).Items.clear();
      MainCubit.get(context).getCategory();
      navigateAndFinish(context, ShopeCategoriesScreen());}, text: 'محل',height: 70,radius: 60).animate().slideX(begin: -3,end: 0),

    SizedBox(height: 35,),

    defaultMaterialButton(function: (){
      MainCubit.get(context).Items.clear();
      MainCubit.get(context).getCategory();
      navigateAndFinish(context, StoreCategoriesScreen());}, text: 'مخزن',height: 70,radius: 60).animate().slideX(begin: 3,end: 0),

  ],

  //المفروشات

  //صالونات و طاولات سفره و كراسي سفره و فرشات وغرف اطفال و طاولات صالون و اثاث جنائن اضافه و حذف



  ),
),
);
}
}