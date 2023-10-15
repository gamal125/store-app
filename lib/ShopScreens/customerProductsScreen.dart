
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../cubit/cubit.dart';
import '../../cubit/state.dart';
import '../../models/productsModel.dart';
import '../../shared/components/components.dart';
import 'CartScreen.dart';
import 'ShopeCategoryScreen.dart';
class CustomerProductsScreen extends StatefulWidget {
  CustomerProductsScreen({required this.catname});
  String catname;

  @override
  State<CustomerProductsScreen> createState() => _CustomerProductsScreenState();
}

class _CustomerProductsScreenState extends State<CustomerProductsScreen> {
  var amountController = TextEditingController();

  @override
  Widget build(BuildContext context,) {

    return BlocConsumer<MainCubit, MainStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(onPressed: (){
              navigateAndFinish(context, ShopeCategoriesScreen());
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
          body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                GridView.count(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  crossAxisCount: 1,
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8,
                  childAspectRatio: 1 / 1,
                  children: List.generate(

                    MainCubit.get(context).ItemsPro.length,(index) => GridProducts(MainCubit.get(context).ItemsPro[index], context,TextEditingController()),
                  ),
                ),

              ],
            ),
          ),



          floatingActionButton: FloatingActionButton(
            onPressed: (){
                navigateTo(context, CartScreen());
            },
            tooltip: 'Increment',
            child: const Icon(Icons.add_shopping_cart_outlined),
          ),

        );
      },
    );
  }

  Widget GridProducts(productsModel model, context,TextEditingController text) => InkWell(
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
                SizedBox( // <-- SEE HERE
                  width: 70,
                  height: 35,
                  child: TextFormField(

                    decoration: InputDecoration(

                      border: OutlineInputBorder(),
                      hintText:"0",
                    ),
                    controller: text,
                    textAlignVertical: TextAlignVertical.bottom,
                    keyboardType: TextInputType.number,
                    style: TextStyle(fontSize: 14),



                  ),
                ),

                defaultMaterialButton(

                  function: () {

                    MainCubit.get(context).clearold_amount();




                    if (text.text != null && text.text != "0") {
                      num v = int.parse(text.text);
                      if (v <= model.amount!) {
                        MainCubit.get(context).add_to_cart(
                            image: model.image!,
                            name: model.name!,

                            cat: widget.catname,
                            amount: v,
                            price: model.price!,

                            oreiginal_amount: model.amount!,
                            old_price: model.old_price!,
                            color: model.color!,
                            store_number: model.store_number!)
                        ;


                        setState(() {
                          model.amount =
                              model.amount! - int.parse(text.text);
                          text.text = "0";
                        });
                      }
                      else {
                        print("more than value");
                      }
                    }
                    else {
                      print("cancelled");
                    }
                  }
                  ,
                  text: 'הוספה לעגלה',
                  radius: 20,
                ),

              ],
            ),
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
