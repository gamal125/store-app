
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_app/models/cartModel.dart';






import '../../cubit/cubit.dart';
import '../../cubit/state.dart';
import '../../shared/components/components.dart';
import 'ShopeCategoryScreen.dart';



class MyOrdersScreen extends StatelessWidget {
  const MyOrdersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return BlocConsumer<MainCubit, MainStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.pinkAccent,

          appBar: AppBar(

            iconTheme: IconThemeData(color: Colors.black),
            title: Text("הזמנות שלי",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
            leading: IconButton(onPressed: (){
              navigateAndFinish(context, ShopeCategoriesScreen());
            }, icon: Icon(Icons.arrow_back_ios)),

            systemOverlayStyle: SystemUiOverlayStyle(

              statusBarColor: Colors.white,
              statusBarIconBrightness: Brightness.dark,
              statusBarBrightness: Brightness.light,
            ),
            backgroundColor: Colors.pinkAccent,


          ),
          body: ConditionalBuilder(
            condition: state is! DeleteCatIntiStates ,
            builder: (context)=>    SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) => catList(
                        MainCubit.get(context).UsersWaitingOrders[index], context),
                    separatorBuilder: (context, index) => myDivider(),
                    itemCount: MainCubit.get(context).UsersWaitingOrders.length,
                  ),



                ],
              ),

            ),
            fallback:(context) => Center(child: CircularProgressIndicator()),)

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
            shape: BoxShape.rectangle,
            border: Border.all(color: Colors.white, width: 1),
            borderRadius: BorderRadius.all(Radius.circular(5)),
            color: Colors.pink
        ),
        child: Padding(
          padding: const EdgeInsets.all(3.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                children: [
                  Container(
                    width: 120.0,
                    height: 100.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      border: Border.all(color: Colors.white, width: 1),
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      color: Colors.white,
                      image: DecorationImage(
                        image: NetworkImage(
                          model.image!,
                        ),
                        fit: BoxFit.scaleDown,
                      ),
                    ),
                  ),
                  const Spacer(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,

                    children: [
                      Row(
                        children: [
                          Text(

                            "${model.amount!.toString().toUpperCase()} ",
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

                            "${model.price!.toString().toUpperCase()}₪ ",
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
                      Text("________________")
                    ],
                  ),

                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(

                    "${model.amount!*int.parse(model.price!)}₪",
                    style:TextStyle( fontWeight: FontWeight.bold,),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(

                    ": סה׳׳כ לתשלום",
                    style:TextStyle( fontWeight: FontWeight.bold,),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),

                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                Column(children: [

                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(

                        "${model.old_price}:",
                        style:TextStyle( fontWeight: FontWeight.bold,),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(

                        "سعر التكلفه",
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

                        "${model.color}:",
                        style:TextStyle( fontWeight: FontWeight.bold,),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(

                        "اللون",
                        style:TextStyle( fontWeight: FontWeight.bold,),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),

                    ],
                  ),
                ],),
                Column(children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(

                        "${model.store_number}:",
                        style:TextStyle( fontWeight: FontWeight.bold,),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(

                        "المخزن",
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

                        " דגם:${model.name!}",
                        style:TextStyle( fontWeight: FontWeight.bold,),
                        maxLines: 1,
                        textDirection: TextDirection.rtl,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ],)
              ],),






              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: defaultMaterialButton(function: (){

                  MainCubit.get(context).deleteOrder(model.random_name!);






                    }, text: "تسليم",width: 100,height: 40,color: Colors.green),
                  ),
                  Spacer(),

                ],
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
