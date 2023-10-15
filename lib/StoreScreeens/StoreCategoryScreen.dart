
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_app/StoreScreeens/productsScreen.dart';
import '../cubit/cubit.dart';
import '../cubit/state.dart';
import '../models/categoriesModel.dart';
import '../shared/components/components.dart';
import 'AddScreen.dart';



class StoreCategoriesScreen extends StatelessWidget {
  const StoreCategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    int i=0;
    return BlocConsumer<MainCubit, MainStates>(
      listener: (context, state) {

      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            iconTheme: IconThemeData(color: Colors.cyan),
            title: Text("קטלוג",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
            actions: [

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
            condition: state is! DeleteCatIntiStates,
            builder: ( context) =>SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [


                  ListView.separated(
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) => catList(
                        MainCubit.get(context).Items[index],i, context),
                    separatorBuilder: (context, index) => myDivider(),
                    itemCount: MainCubit.get(context).Items.length,
                  ).animate().fade(begin: 0.1,end: 2),



                ],
              ),

            ),
            fallback: ( context) =>Center(child: CircularProgressIndicator()),),
          floatingActionButton: FloatingActionButton(onPressed: () {
            navigateAndFinish(context, AddScreen());
          },child: Icon(Icons.add),),

        );
      },
    );
  }

  Widget catList(categoriesModel model,i, context) => InkWell(
    onTap: () {
      if (MainCubit.get(context).ItemsPro.isNotEmpty) {
        MainCubit.get(context).ItemsPro.clear();
        MainCubit.get(context).getProducts(name: model.name!);
        navigateAndFinish(context, ProductsScreen(catname: model.name!));
      }
      else {
        MainCubit.get(context).getProducts(name: model.name!);
        navigateAndFinish(context, ProductsScreen(catname: model.name!));
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
            onPressed: () {
              i>=5 ?MainCubit.get(context).deleteCat(model.name!):i++;

            },
            icon: const Icon(
              Icons.arrow_forward_ios,
            ),
          ),
        ],
      ),
    ),
  );
}
