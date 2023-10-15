import 'dart:io';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:store_app/cubit/state.dart';
import '../models/OrdersModel.dart';
import '../models/UserModel.dart';
import '../models/cartModel.dart';
import '../models/categoriesModel.dart';
import '../models/images_model.dart';
import '../models/productsModel.dart';
import '../models/useridmodel.dart';






class MainCubit extends Cubit<MainStates> {
  MainCubit() : super(MainInitialStates());

  static MainCubit get(context) => BlocProvider.of(context);
  int currentIndex = 0;

  void ChangeNavBar(int index) {
    currentIndex = index;
    emit(ChangeNavBarItem());
  }
////////////////////////////////////////////////////////////////////////////////////////////////
  void createCorsorImage({
    required String image,
     required String name
  }) {
    imagesModel model = imagesModel(
       image: image,);

    FirebaseFirestore.instance.collection("image").doc(name).set(
        model.Tomap()).then((value) {
      emit(CreateImageSuccessState());
    }).catchError((error) {
      emit(CreateImageErrorStates(error.toString()));
    });
  }

///////////////////////////create Category///////////////////////////////////////////////////////
  void createCategory({
    required String image,
    required String name,}) {
    categoriesModel model = categoriesModel(
      name: name, image: image,);

    FirebaseFirestore.instance.collection("Category").doc(name).set(
        model.Tomap()).then((value) {
      emit(CreateCategorySuccessState());
    }).catchError((error) {
      emit(CreateCategoryErrorStates(error.toString()));
    });
  }

///////////////////////////create product///////////////////////////////////////////////////////
  List<productsModel> ItemsPro = [];

  void createproduct({
    required String image,
    required String name,
    required String cat,
    required num amount,
    required String price,
    required String old_price,
    required num store_number,
    required String color,
  }) {
    productsModel model = productsModel(
      name: name,
      image: image,
      catname: cat,
      amount: amount,
      price: price,
      color: color,
      old_price: old_price,
      store_number: store_number,
    );
    FirebaseFirestore.instance.collection("Category").doc(cat).collection(cat)
        .doc(name).set(model.Tomap())
        .then((value) {
      emit(CreateproductSuccessState());
    }).catchError((error) {
      emit(CreateproductErrorStates(error.toString()));
    });
  }


  ///////////////////add products to cart////////////////////////////

  List<CartModel> cartmodel = [];

  void add_to_cart({
    required String image,
    required String name,
    required String cat,
    required num oreiginal_amount,
    required String old_price,
    required String color,
    required num store_number,
    required num amount,
    required String price,


  }) {
    cartmodel.add(CartModel(
      name: name,
      image: image,
      price: price,
      catname: cat,
      color: color,
      old_price: old_price,
      amount: amount,
      store_number: store_number,
      oreiginal_amount: oreiginal_amount,

    ));
  }


///////////////////////////customer create a new order////////////////////////////////////

  void createOrder({
    required String image,
    required String name,
    required String random_name,
    required String cat,
    required num amount,
    required String price,
    required num oreiginal_amount,
    required String old_price,
    required String color,
    required num store_number,

  }) {
    CartModel model = CartModel(
      random_name:random_name,
      name: name,
      image: image,
      price: price,
 catname: cat,
      color: color,
      old_price: old_price,
      amount: amount,
      store_number: store_number,
      oreiginal_amount: oreiginal_amount,
    );
    FirebaseFirestore.instance.collection("orders")
        .doc(random_name).set(model.Tomap())
        .then((value) {
      emit(CreateOrderSuccessState());
    }).catchError((error) {
      emit(CreateOrderErrorStates(error.toString()));
    });
  }


////////////////////////////////get Category///////////////////////////////////////////////////////////
  List<categoriesModel> Items = [];

  void getCategory() {
    FirebaseFirestore.instance.collection('Category').get().then((value) {
      value.docs.forEach((element) {
        Items.add(categoriesModel.fromjson(element.data()));
      });


      emit(GetCategoriesSuccessStates());
    }).catchError((error) {
      emit(GetCategoriesErrorStates(error.toString()));
    });
  }

  ////////////////////get customer data  using app now///////////////////////////////




  /////////////////////////////////////////////////
  File? PickedFile;

  final ImagePicker picker = ImagePicker();

  Future<void> getImage() async {
    final imageFile = await picker.pickImage(source: ImageSource.gallery);
    if (imageFile != null) {
      PickedFile = File(imageFile.path);
      emit(UpdateProductImageSuccessStates());
    }
    else {
      var error = 'no Image selected';
      emit(UpdateProductImageErrorStates(error.toString()));
    }
  }

///////////////////////////remove_from_cart///////////////////////////////////

  void remove_from_cart({required CartModel model}) {
    emit(remove_from_cart_loading_stat());

    cartmodel.remove(model);

    emit(remove_from_cart_Success_stat());
  }

//////////////////////////////////////get images fo cursor////////////////////////////////////////////////////////////////




////////////////////////////////get Products///////////////////////////////////////////////////////////

  void getProducts({required String name}) {
    FirebaseFirestore.instance.collection('Category').doc(name)
        .collection(name)
        .get()
        .then((value) {
      value.docs.forEach((element) {
        ItemsPro.add(productsModel.fromjson(element.data()));
      });

      emit(ProductSuccessStates());
    }).catchError((error) {
      emit(ProductErrorStates(error.toString()));
    });
  }


////////////////////////////////get Products old order///////////////////////////////////////////////////////////
  List<OrdersModel> list = [];
  OrdersModel old_ordered_model = OrdersModel(
      image: '',
      name: '',
      cat: '',
      amount_orderd: 0,
      price: '',
      phone: '',
      tax_number: '',
      username: '',
      old_amount: 0,

      id: '',
      oreiginal_amount: null);

  ////////////////////////////////////get Products amount///////////////////////////

  void clearold_amount() {
    old_ordered_model = OrdersModel(
        image: '',
        name: '',
        cat: '',
        amount_orderd: 0,
        oreiginal_amount: 0,
        price: '',
        phone: '',
        tax_number: '',
        username: '',
        old_amount: 0,
        id: '');
  }


////////////////////////////////updateProduct///////////////////////////////////////////

  void updateProducts({
    required String image,
    required String name,
    required String catnamee,
    required num amount,
    required String price,
    required String old_price,
    required String color,
    required num store_number,
  }) {
    productsModel model = productsModel(
        image: image,
        name: name,
        catname: catnamee,
        amount: amount,
        price: price,
        old_price: old_price,
        color: color,
        store_number: store_number
    );
    emit(ImageintStates());
    FirebaseFirestore.instance.collection('Category').doc(catnamee).collection(
        catnamee).doc(name).update(model.Tomap()).then((value) {
      emit(UpdateProductSuccessStates());
    }).catchError((error) {
      emit(UpdateProductErrorStates(error.toString()));
    });
  }


////////////////////////////////updateProduct///////////////////////////////////////////

  deleteProducts({
    required String name,
    required String catnamee,}) {
    emit(deleteproductLoadingStates());
    FirebaseFirestore.instance.collection('Category').doc(catnamee).collection(
        catnamee).doc(name).delete().then((value) {
      emit(deleteProductsSuccessStates());
    }).catchError((error) {
      emit(deleteProductsErrorStates(error.toString()));
    });
  }

////////////////////////////////update user///////////////////////////////////////////


  String ImageUrl = '';

  ////////////////////////////////uploadImage to storage////////////////////////////////////////
  void uploadImage({required String name}) {
    emit(ImageintStates());
    firebase_storage.FirebaseStorage.instance.ref().child('users/${Uri
        .file(PickedFile!.path)
        .pathSegments
        .last}').putFile(PickedFile!).
    then((value) {
      value.ref.getDownloadURL().then((value) {
        ImageUrl = value;
        print(ImageUrl);
        createCategory(image: ImageUrl, name: name);
        PickedFile = null;

        emit(ImageSuccessStates())
        ;
      }).catchError((error) {
        emit(ImageErrorStates(error));
      });
    }).catchError((error) {
      emit(ImageErrorStates(error));
    });
  }
////////////////////////////////////////////////////////////////////////////////////////////////////////
  void uploadCorsorImage({required String name}) {
    emit(ImageintStates());
    firebase_storage.FirebaseStorage.instance.ref().child('users/${Uri
        .file(PickedFile!.path)
        .pathSegments
        .last}').putFile(PickedFile!).
    then((value) {
      value.ref.getDownloadURL().then((value) {
        ImageUrl = value;
        print(ImageUrl);
        createCorsorImage(image: ImageUrl, name: name);
        PickedFile = null;

        emit(ImageSuccessStates())
        ;
      }).catchError((error) {
        emit(ImageErrorStates(error));
      });
    }).catchError((error) {
      emit(ImageErrorStates(error));
    });
  }

////////////////////////////////uploadImage to database as url///////////////////////////////////////////
  void uploadProductImage({
    required String name,
    required String cat,
    required num amount,
    required String price,
    required String old_price,
    required num store_numbber,
    required String color,
  }) {
    emit(ImageintStates());
    firebase_storage.FirebaseStorage.instance.ref().child('users/${Uri
        .file(PickedFile!.path)
        .pathSegments
        .last}').putFile(PickedFile!).
    then((value) {
      value.ref.getDownloadURL().then((value) {
        ImageUrl = value;
        print(ImageUrl);
        createproduct(image: ImageUrl,
            name: name,
            cat: cat,
            amount: amount,
            price: price, old_price: old_price, store_number: store_numbber, color: color);
        PickedFile = null;

        emit(ImageSuccessStates())
        ;
      }).catchError((error) {
        emit(ImageErrorStates(error));
      });
    }).catchError((error) {
      emit(ImageErrorStates(error));
    });
  }

  ////////////////////////////////edit_Product_Image to database as url///////////////////////////////////////////
  void editProductImage({

    required String name,
    required String catnamee,
    required num amount,
    required String price,
    required String old_price,
    required String color,
    required num store_number,
  }) {
    emit(ImageintStates());
    firebase_storage.FirebaseStorage.instance.ref().child('users/${Uri
        .file(PickedFile!.path)
        .pathSegments
        .last}').putFile(PickedFile!).
    then((value) {
      value.ref.getDownloadURL().then((value) {
        ImageUrl = value;
        print(ImageUrl);
        updateProducts(image: ImageUrl,
            name: name,
            catnamee: catnamee,
            amount: amount,
            price: price, old_price:old_price, color: color, store_number: store_number);
        PickedFile = null;

        emit(ImageSuccessStates())
        ;
      }).catchError((error) {
        emit(ImageErrorStates(error));
      });
    }).catchError((error) {
      emit(ImageErrorStates(error));
    });
  }

  //////////////////////////////////////////////////////////////////////////////////////////////

  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;

  void ShowPassword() {
    isPassword = !isPassword;
    suffix =
    isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;

    emit(ShowPasswordStates());
  }

//////////////////////////////////////////////get all user/////////////////////////////////////////////////////////////////

  List<UserModel> AllUsers = [];

  void getUsers() {

    FirebaseFirestore.instance.collection('users').get().then((value) {
      for (var element in value.docs) {
        AllUsers.add(UserModel.fromjson(element.data()));
      }

      emit(GetUserIdModelSuccessStates());
    }).catchError((error) {
      emit(GetUserIdModelerrorStates(error.toString()));
    });
  }


  void deleteCat(String name) {
    emit(DeleteCatIntiStates());
    FirebaseFirestore.instance.collection('Category').doc(name).delete().then((value) {
      Items.clear();
      getCategory();
      emit(DeleteCatSuccessStates());
    }).catchError((error) {
      emit(GetUserIdModelerrorStates(error.toString()));
    });
  }


/////////////////////////////////////get users only has order//////////////////////////////


  void deleteOrder(String Random_name) {
    emit(DeleteCatIntiStates());
    FirebaseFirestore.instance.collection('orders').doc(Random_name).delete().then((value) {
      UsersWaitingOrders.clear();
      getUsersWaitingOrders();
      emit(DeleteCatSuccessStates());
    }).catchError((error) {
      emit(GetUserIdModelerrorStates(error.toString()));
    });
  }





  ///////////////get user has order details///////////////////


///////////////////////////////////////////////////////////////////////////////////////////
  List<OrdersModel> UsersOrders = [];
  List<UserIdModel> UsersHasOrder = [];




////////////////////////////////////for one user///////////////


  ///////////////////////////assest/////////////////
  getIdmodel({required String id}) {
    FirebaseFirestore.instance.collection('users').doc(id).get().then((value) {
      UsersHasOrder.add(UserIdModel.fromjson(value.data()!));

      emit(GetUserIdModelSuccessStates());
    }).catchError((error) {
      emit(GetUserIdModelerrorStates(error.toString()));
    });
  }

///////////////////////////////////!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!/////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////


  //////////////////////////////////////////////////////////////////////////////////////


  List<OrdersModel> getCustomerOrders = [];

  void getUsersCustomerOrders({required String Id}) {
    emit(getUsersWaitingOrdersLoadingStates());
    FirebaseFirestore.instance.collection('users').doc(Id)
        .collection('orders')
        .get()
        .then((value) {
      value.docs.forEach((element) {
        getCustomerOrders.add(OrdersModel.fromjson(element.data()));
      });
      print(UsersWaitingOrders.length);

      emit(getUsersWaitingOrdersSuccessState());
    }).catchError((error) {
      emit(getUsersWaitingOrdersErrorStates(error.toString()));
    });
  }


  //////////////////////////get for customer screen/////////////////////////////////////////////////////////////////////
  List<CartModel> UsersWaitingOrders = [];

  void getUsersWaitingOrders() {
    FirebaseFirestore.instance
        .collection('orders')
        .get()
        .then((value) {
      value.docs.forEach((element) {
        UsersWaitingOrders.add(CartModel.fromjson(element.data()));
      });
      print(UsersWaitingOrders.length);

      emit(getUsersWaitingOrdersSuccessState());
    }).catchError((error) {
      emit(getUsersWaitingOrdersErrorStates(error.toString()));
    });
  }

///////////////////////////////// get for customer screen   /////////////////////////////////////



//////////////////////////////////////////////////////////////////////////





  Future<void> userLogout() async {
    emit(LogOutLoadingState());
    await  FirebaseAuth.instance.signOut() .then((value) {

      emit(LogOutSuccessState());
    }).catchError((error) {
      emit(LogOutErrorState(error.toString()));
    });
  }
}







