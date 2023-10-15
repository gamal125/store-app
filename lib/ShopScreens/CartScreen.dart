
import 'dart:math';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../cubit/cubit.dart';
import '../../cubit/state.dart';
import '../../shared/components/components.dart';
import '../models/cartModel.dart';
import 'ShopeCategoryScreen.dart';



class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return BlocConsumer<MainCubit, MainStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            iconTheme: IconThemeData(color: Colors.cyan),
            title: Text("דף הבית",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),

            elevation: 0,
            systemOverlayStyle: SystemUiOverlayStyle(

              statusBarColor: Colors.white,
              statusBarIconBrightness: Brightness.dark,
              statusBarBrightness: Brightness.light,
            ),
            backgroundColor: Colors.white,
          ),
          body: ConditionalBuilder(
            condition:State is! remove_from_cart_loading_stat,
            builder: ( context)=> SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) => catList(
                        MainCubit.get(context).cartmodel[index], context),
                    separatorBuilder: (context, index) => myDivider(),
                    itemCount: MainCubit.get(context).cartmodel.length,
                  ),
                  defaultMaterialButton(

                      function: () {

                        MainCubit.get(context).cartmodel.forEach((element) {



                    MainCubit.get(context).createOrder(

                        image: element.image!,
                        name: element.name!,
                        cat: element.catname!,
                        amount:element.amount!,
                        price: element.price!,

                        oreiginal_amount: element.oreiginal_amount!,
                        old_price: element.old_price!,
                        color: element.color!,
                        store_number: element.store_number!, random_name: (Random().nextInt(1000) + 1).toString());
                    MainCubit.get(context).clearold_amount();





                        });

                        MainCubit.get(context).cartmodel.forEach((element) {
                          MainCubit.get(context).updateProducts(
                              image: element.image!,
                              name: element.name!,
                              catnamee: element.catname!,
                              amount:element.oreiginal_amount!-element.amount!,
                              price: element.price!, old_price: element.old_price!,
                            color: element.color!,
                            store_number: element.store_number!,);});

                        MainCubit.get(context).cartmodel.clear();

                        navigateAndFinish(context, ShopeCategoriesScreen());
                      },
                      text: "לרכישה"),




                ],
              ),

            ),
            fallback:(context) => Center(child: CircularProgressIndicator()),

          )

        );
      },
    );
  }

  Widget catList(CartModel model, context) => InkWell(
    onTap: () {




    },
    child: Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadiusDirectional.circular(7),
          color: Colors.cyan[100]
        ),
        child: Row(
          children: [
            Container(
              width:100.0,
              height: 100.0,
              decoration: BoxDecoration(

                shape: BoxShape.rectangle,
                border: Border.all(color: Colors.cyan, width: 2),

                image: DecorationImage(
                  image: NetworkImage(
                    model.image!,
                  ),
                  fit: BoxFit.scaleDown,
                ),
              ),
            ),
        Spacer(),

            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(

                  " דגם:${model.name}",
                  style:TextStyle( fontWeight: FontWeight.bold,),
                  maxLines: 1,
                  textDirection: TextDirection.rtl,
                  overflow: TextOverflow.ellipsis,
                ),
                Row(
                  children: [
                    Text(

                      "${model.amount.toString().toUpperCase()} ",
                      style:TextStyle( fontWeight: FontWeight.bold,),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      ": כמות",
                      style:TextStyle( fontWeight: FontWeight.bold,),
                      textDirection: TextDirection.ltr,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),

                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(

                      "${model.price.toString().toUpperCase()}₪ ",
                      style:TextStyle( fontWeight: FontWeight.bold,),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(

                      ": מחיר",
                      style:TextStyle( fontWeight: FontWeight.bold,),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),

                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(

                      "${model.amount!*int.parse(model.price!)}₪",
                      style:TextStyle( fontWeight: FontWeight.normal,),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(

                      ": סה׳׳כ לתשלום",
                      style:TextStyle( fontWeight: FontWeight.normal,),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),

                  ],
                ),
              ],
            ),



           IconButton(
              onPressed: () {
                MainCubit.get(context).remove_from_cart(model: model);

              },
              icon: const Icon(
                Icons.cancel,
                color: Colors.red,
              ),
            )
          ],
        ),
      ),
    ),
  );
}
