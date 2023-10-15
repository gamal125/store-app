import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/cubit.dart';
import '../cubit/state.dart';
import '../models/productsModel.dart';
import '../shared/components/components.dart';
import 'StoreCategoryScreen.dart';
import 'addproductScreen.dart';
import 'editScreen.dart';
class ProductsScreen extends StatelessWidget {
     ProductsScreen({required this.catname});
     String catname;

  @override
  Widget build(BuildContext context,) {


    var c= MainCubit.get(context);

    return BlocConsumer<MainCubit, MainStates>(
      listener: (context, state) {
        if (state is deleteProductsSuccessStates) {
          if( c.ItemsPro.isNotEmpty){
            c.ItemsPro.clear();
            c.getProducts(name: catname);
         }
          else{

            c.getProducts(name: catname);

          }


        };},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(onPressed: (){
              navigateAndFinish(context, StoreCategoriesScreen());
            }, icon: Icon(Icons.arrow_back_ios)),
            title: Text("דף הבית",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
            elevation: 0,
            systemOverlayStyle: SystemUiOverlayStyle(

              statusBarColor: Colors.white,
              statusBarIconBrightness: Brightness.dark,
              statusBarBrightness: Brightness.light,
            ),
            backgroundColor: Colors.white,
            iconTheme: IconThemeData(color: Colors.cyan),
          ),
          body: ConditionalBuilder(
            builder:(context) =>  SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      children: [

                        GridView.count(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          crossAxisCount: 2,
                          crossAxisSpacing: 8.0,
                          mainAxisSpacing: 8.0,
                          childAspectRatio: 1 / 2,
                          children: List.generate(

                              MainCubit.get(context).ItemsPro.length
                                ,(index) =>
                              GridProducts(MainCubit.get(context).ItemsPro[index], context),
                          ).animate().fade(begin: 0.1,end: 0.9),
                        ),

                      ],
                    ),
                  ), condition: state is! deleteproductLoadingStates,
            fallback: (context) => Center(child: CircularProgressIndicator()),
          ),



          floatingActionButton: FloatingActionButton(onPressed: () {
            navigateTo(context, AddProductScreen(catname:  catname));
          },child: Icon(Icons.add),),

        );
      },
    );
  }

  Widget GridProducts(productsModel model, context) => InkWell(
    onTap: () {


      // MainCubit.get(context)
      //     .getProductData(model.id)
      //     .then((value) => navigateTo(context, ProductDetailsScreen()));
    },
    child: Stack(
      children: [

        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          clipBehavior: Clip.none,
          elevation: 20,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 5,
              vertical: 5,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Image(
                  image:  NetworkImage(model.image!,),fit: BoxFit.scaleDown,
                  width: double.infinity,
                  height: 100.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                  Text(
                  model.name!,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 12),
                ),
                  Text(
                  ':الاسم',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),

                ],),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "${model.old_price!}₪",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      ":سعر التكلفه",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),

                  ],),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      model.color!,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      ":اللون",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),

                  ],),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      model.store_number.toString(),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      ":رقم المخزن",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),

                  ],),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${model.price!}₪',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.red,
                      ),
                    ),
                    Text(
                      ':السعر',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.red,
                      ),
                    ),

                  ],),

                defaultMaterialButton(

                  function: () {
                    navigateTo(context, editScreen(
                      catname: catname,
                      name: model.name!,
                      price: model.price!,
                      amount: model.amount!,
                      image: model.image!,
                      color: model.color!,
                      old_price: model.old_price!,
                      store_number: model.store_number!,
                    ));

                  },
                  text: 'עידכון',
                  radius: 20,
                ),
              ],
            ),
          ),
        ),
        Positioned(
          child: Align(
            alignment: AlignmentDirectional.topEnd,
            child: IconButton(
                alignment: AlignmentDirectional.bottomCenter,
                onPressed: (){MainCubit.get(context).deleteProducts(name: model.name!, catnamee: model.catname!);}, icon:Icon( Icons.delete,color: Colors.red,)),
          ),
        ),

        Positioned.fill(
            child: Align(
              alignment: Alignment(1, -1),
              child: ClipRect(
                child: Banner(
                  message: '${model.amount!}\ PcS',
                  textStyle: const TextStyle(
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                    letterSpacing: 0.5,
                  ),
                  location: BannerLocation.topStart,
                  color: Colors.green,
                  child: Container(
                    height: 100.0,
                  ),
                ),
              ),
            ),
          ),

      ],
    ),
  );
}
