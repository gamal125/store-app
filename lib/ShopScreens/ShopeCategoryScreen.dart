
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_app/ShopScreens/myOrderScreen.dart';

import '../../cubit/cubit.dart';
import '../../cubit/state.dart';
import '../../shared/components/components.dart';
import '../models/categoriesModel.dart';
import 'customerProductsScreen.dart';

class ShopeCategoriesScreen extends StatelessWidget {
  const ShopeCategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {


    return BlocConsumer<MainCubit, MainStates>(

      listener: (context, state) {
        if(state is getUsersWaitingOrdersSuccessState){
          navigateTo(context, MyOrdersScreen());

        }
      },
      builder: (context, state) {
        return Scaffold(

          appBar: AppBar(
            iconTheme: IconThemeData(color: Colors.cyan),
            title: Text("קטלוג",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
            actions: [
              IconButton(onPressed: (){
                if (MainCubit.get(context).UsersWaitingOrders.isNotEmpty) {
                  MainCubit.get(context).UsersWaitingOrders.clear();

                  MainCubit.get(context).getUsersWaitingOrders();

                }

                else{
                  MainCubit.get(context).getUsersWaitingOrders();

                }

              }, icon: Icon(Icons.shopping_cart)),

            ],
            elevation: 0,
            systemOverlayStyle: SystemUiOverlayStyle(

              statusBarColor: Colors.white,
              statusBarIconBrightness: Brightness.dark,
              statusBarBrightness: Brightness.light,
            ),
            backgroundColor: Colors.white,
          ),
          body: ConditionalBuilder(
            condition: state is!GatImagesIntiStates,
            builder: ( contex)=>SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [

                  ListView.separated(
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) => catList(
                        MainCubit.get(context).Items[index], context),
                    separatorBuilder: (context, index) => myDivider(),
                    itemCount: MainCubit.get(context).Items.length,
                  ),



                ],
              ),

            ),
            fallback: ( context) => Center(child: CircularProgressIndicator()),),
          floatingActionButton: FloatingActionButton(
            onPressed: (){
          //    navigateTo(context, CartScreen());
            },
            tooltip: 'Increment',
            child: const Icon(Icons.add_shopping_cart_outlined),
          ),
        );
      },
    );
  }

  Widget catList(categoriesModel model, context) => InkWell(
    onTap: () {


      if (MainCubit.get(context).ItemsPro.isNotEmpty) {
        MainCubit.get(context).ItemsPro.clear();
        MainCubit.get(context).getProducts(name: model.name!);
        navigateAndFinish(context, CustomerProductsScreen(catname: model.name!));
      }
      else {
        MainCubit.get(context).getProducts(name: model.name!);
        navigateAndFinish(context, CustomerProductsScreen(catname: model.name!));
      }

    },
    child: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          Container(
            width: 100.0,
            height: 100.0,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.cyan, width: 2),
              image: DecorationImage(
                image: NetworkImage(
                  model.image!,
                ),
                fit: BoxFit.scaleDown,
              ),
            ),
          ),
          const Spacer(),
          Text(
            model.name!.toUpperCase(),
            style:TextStyle( fontWeight: FontWeight.bold,),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),

          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.arrow_forward_ios,
            ),
          ),
        ],
      ),
    ),
  );
}
