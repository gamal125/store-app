

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_app/StoreScreeens/productsScreen.dart';
import '../../shared/components/components.dart';
import '../cubit/cubit.dart';
import '../cubit/state.dart';



class editScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();

  var amountController = TextEditingController();

  var imageController = TextEditingController();
  var priceController = TextEditingController();
  var store_numberController = TextEditingController();

  var sizeController = TextEditingController();
  var colorController = TextEditingController();

// Pick an image.


  editScreen({
    required this.catname,
    required this.name,
    required this.price,
    required this.amount,
    required this.image,
    required this.store_number,
    required this.color,
    required this.old_price,


  });
  String catname;
  String name;
  String image;
  String price;
  num amount;
  num store_number;
  String color;
  String old_price;


  @override
  Widget build(BuildContext context) {
    imageController.text=image;
    priceController.text=price;
    amountController.text=amount.toString();
    colorController.text=color;
    sizeController.text=old_price;

    var c= MainCubit.get(context);

    return BlocConsumer<MainCubit, MainStates>(
      listener: (context, state) {
         if (state is UpdateProductSuccessStates) {
           if( c.ItemsPro.isNotEmpty){
               c.ItemsPro.clear();
               c.getProducts(name: catname);
            navigateTo(context,  ProductsScreen(catname: catname,))
            ;}
          else{

           navigateTo(context,  ProductsScreen(catname: catname,));
          }


        };
      },
      builder: (context, state) {
        var Image=c.PickedFile;
        return Scaffold(
          backgroundColor: Colors.white,

          appBar: AppBar(
            elevation: 0,
            systemOverlayStyle: const SystemUiOverlayStyle(
              statusBarColor: Colors.white,
              statusBarIconBrightness: Brightness.dark,
              statusBarBrightness: Brightness.light,
            ),
            backgroundColor: Colors.white,
          ),
          body: GestureDetector(
            onTap: (){
              FocusManager.instance.primaryFocus?.unfocus();
            },
            child: Container(

              child: Center(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "تعديل",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          InkWell(
                            onTap: (){
                              c.getImage();
                            },
                            child: Container(
                              width: double.infinity,
                              height: 300,

                              decoration: Image != null ?
                              BoxDecoration(image: DecorationImage(image: FileImage(Image) ))
                                  : BoxDecoration(image: DecorationImage(image: NetworkImage(
                             image) ))
                              ,
                            ),
                          ) ,
                          SizedBox(
                            height: 20,
                          ),
                          defaultTextFormField(
                            onTap: (){
                              MainCubit.get(context).emit(UpdateCartLoadingStates());
                            },
                            controller: amountController,
                            keyboardType: TextInputType.number,
                            prefix: Icons.image,
                            validate: (String? value) {
                              if (value!.isEmpty) {
                                return 'Please enter amount ';
                              }
                              return null;
                            },
                            label: 'الكميه',
                            hint: amount.toString(),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          defaultTextFormField(
                            onTap: (){
                              MainCubit.get(context).emit(UpdateCartLoadingStates());
                            },
                            controller: priceController,
                            keyboardType: TextInputType.text,
                            prefix: Icons.price_change,
                            validate: (String? value) {
                              if (value!.isEmpty) {
                                return 'Please enter price ';
                              }
                              return null;
                            },
                            label: 'السعر',
                            hint: price,
                          ),

                          SizedBox(
                            height: 20,
                          ),
                          defaultTextFormField(
                            onTap: (){
                              MainCubit.get(context).emit(UpdateCartLoadingStates());
                            },
                            controller: sizeController,
                            keyboardType: TextInputType.text,
                            prefix: Icons.price_change,
                            validate: (String? value) {
                              if (value!.isEmpty) {
                                return 'Please enter cost_price ';
                              }
                              return null;
                            },
                            label: 'cost_price',
                            hint: old_price,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          defaultTextFormField(
                            onTap: (){
                              MainCubit.get(context).emit(UpdateCartLoadingStates());
                            },
                            controller: colorController,
                            keyboardType: TextInputType.text,
                            prefix: Icons.price_change,
                            validate: (String? value) {
                              if (value!.isEmpty) {
                                return 'Please enter color ';
                              }
                              return null;
                            },
                            label: 'color',
                            hint: color,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          ConditionalBuilder(condition: state is! ImageintStates,
                              builder: (context)=>Center(
                                child: defaultMaterialButton(

                                  function: () {
                                    if (formKey.currentState!.validate()) {
                                      if(Image!=null) {
                                        MainCubit.get(context).editProductImage(
                                            name: name,

                                            amount:num.parse( amountController.text),
                                            price: priceController.text,  catnamee: catname, old_price: sizeController.text, color: colorController.text, store_number: store_number);
                                      }
                                      else{
                                        MainCubit.get(context).updateProducts(image: image, name: name, catnamee: catname, amount:num.parse( amountController.text), price: priceController.text, old_price: sizeController.text, color: colorController.text, store_number: store_number);
                                      }
                                    }
                                  },
                                  text: 'تعديل',
                                  radius: 20,
                                ),
                              ),
                              fallback: (context)=>const Center(child: CircularProgressIndicator(),)),
                          const SizedBox(
                            height: 20,
                          ),

                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
