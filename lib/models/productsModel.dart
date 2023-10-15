class productsModel{

  String? image;
  String? name;
  String? catname;
  num? amount;
  String? price;
  num? store_number;
  String? color;
  String? old_price;






  productsModel({

    this.image,
    this.name,
    this.catname,
    this.amount,
    this.price,
    this.store_number,
    this.old_price,
    this.color



  });


  productsModel.fromjson(Map<String,dynamic>json){

    image=json['image'];
    name=json['name'];
    catname=json['catname'];
    amount=json['amount'];
    price=json['price'];
    store_number=json['store_number'];
    color=json['color'];
    old_price=json['old_price'];








  }
  Map<String,dynamic>Tomap(){
    return{

      'image':image,
      'name':name,
      'catname':catname,
      'amount':amount,
      'price':price,
      'color':color,
      'old_price':old_price,
      'store_number':store_number,




    };
  }
}