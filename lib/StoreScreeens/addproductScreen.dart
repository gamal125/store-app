

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_app/StoreScreeens/productsScreen.dart';
import '../../shared/components/components.dart';
import '../cubit/cubit.dart';
import '../cubit/state.dart';

//باصي الكات

class AddProductScreen extends StatelessWidget {


  var formKey = GlobalKey<FormState>();

  var imageController = TextEditingController();
  var nameController = TextEditingController();
  var amountController = TextEditingController();
  var colorController = TextEditingController();
  var sizeController = TextEditingController();
  var priceController = TextEditingController();
  var storeNumberController = TextEditingController();

  AddProductScreen({required this.catname});
  String catname;
  @override
  Widget build(BuildContext context) {

    var c= MainCubit.get(context);

    return BlocConsumer<MainCubit, MainStates>(
      listener: (context, state) {
        if (state is ImageSuccessStates) {
          if( c.ItemsPro.isNotEmpty){
            c.ItemsPro.clear();
            c.getProducts(name:catname );
            navigateAndFinish(context,  ProductsScreen(catname: catname));}
          else{
            c.getProducts(name:catname );
            navigateAndFinish(context,  ProductsScreen(catname: catname));
          }


        };},
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
            child: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 10,
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
                                'https://www.leedsandyorkpft.nhs.uk/advice-support/wp-content/uploads/sites/3/2021/06/pngtree-image-upload-icon-photo-upload-icon-png-image_2047546.jpg') ))
                            ,
                          ),
                        ) ,


                        SizedBox(
                          height: 20,
                        ),
                        defaultTextFormField(
                          onTap: (){

                          },
                          controller: nameController,
                          keyboardType: TextInputType.text,
                          prefix: Icons.drive_file_rename_outline_sharp,
                          validate: (String? value) {
                            if (value!.isEmpty) {
                              return 'Please enter name ';
                            }
                            return null;
                          },
                          label: 'דגם',
                          hint: 'Enter your name',
                        ),

                        SizedBox(
                          height: 20,
                        ),

                        ////////////////////
                        defaultTextFormField(
                          onTap: (){

                          },
                          controller: priceController,
                          keyboardType: TextInputType.number,
                          prefix: Icons.currency_pound,
                          validate: (String? value) {
                            if (value!.isEmpty) {
                              return 'Please enter price';
                            }
                            return null;
                          },
                          label: 'מחיר',
                          hint: 'Enter price',
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        defaultTextFormField(
                          onTap: (){

                          },
                          controller: amountController,
                          keyboardType: TextInputType.number,
                          prefix: Icons.numbers,
                          validate: (String? value) {
                            if (value!.isEmpty) {
                              return 'Please enter amount ';
                            }
                            return null;
                          },
                          label: 'כמות',
                          hint: 'Enter your amount',
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        defaultTextFormField(
                          onTap: (){

                          },
                          controller: colorController,
                          keyboardType: TextInputType.text,
                          prefix: Icons.drive_file_rename_outline_sharp,
                          validate: (String? value) {
                            if (value!.isEmpty) {
                              return 'Please enter color ';
                            }
                            return null;
                          },
                          label: 'color',
                          hint: 'Enter your color',
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        defaultTextFormField(
                          onTap: (){

                          },
                          controller: sizeController,
                          keyboardType: TextInputType.number,
                          prefix: Icons.drive_file_rename_outline_sharp,
                          validate: (String? value) {
                            if (value!.isEmpty) {
                              return 'Please enter cost_price ';
                            }
                            return null;
                          },
                          label: 'cost_price',
                          hint: 'Enter your cost_price',
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        defaultTextFormField(
                          onTap: (){

                          },
                          controller: storeNumberController,
                          keyboardType: TextInputType.number,
                          prefix: Icons.drive_file_rename_outline_sharp,
                          validate: (String? value) {
                            if (value!.isEmpty) {
                              return 'Please enter store Number ';
                            }
                            return null;
                          },
                          label: 'store Number',
                          hint: 'Enter your store Number',
                        ),

                        SizedBox(
                          height: 20,
                        ),

                        ConditionalBuilder(
                          condition:state is! ImageintStates ,
                          builder: ( context)=> Center(
                            child: defaultMaterialButton(function: () {
                              if (formKey.currentState!.validate()) {
                                MainCubit.get(context).uploadProductImage(name: nameController.text,  cat: catname, amount:num.parse( amountController.text), price: priceController.text, old_price: sizeController.text,
                                    store_numbber: int.parse(storeNumberController.text), color: colorController.text);

                              }}, text: 'הוספה', radius: 20,),
                          ),
                          fallback: (context)=>const Center(child: CircularProgressIndicator(),),),

                        SizedBox(
                          height: 20,
                        ),

                      ],
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
