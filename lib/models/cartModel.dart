class CartModel{


  num? oreiginal_amount;

  String? image;
  String? name;
  String? random_name;
  String? catname;
  num? amount;
  String? price;
  num? store_number;
  String? color;
  String? old_price;








  CartModel({
    this.image,
    this.name,
    this.price,
this.random_name,
    this.oreiginal_amount,


    this.catname,
    this.amount,

    this.store_number,
    this.old_price,
    this.color




  });


  CartModel.fromjson(Map<String,dynamic>json){

    image=json['image'];
    name=json['name'];
    price=json['price'];
    random_name=json['random_name'];
    oreiginal_amount=json['oreiginal_amount'];
    catname=json['catname'];
    store_number=json['store_number'];
    old_price=json['old_price'];
    color=json['color'];
    amount=json['amount'];







  }
  Map<String,dynamic>Tomap(){
    return{

      'image':image,
      'name':name,
      'random_name':random_name,
      'catname':catname,
      'amount':amount,
      'price':price,
      'color':color,
      'old_price':old_price,
      'store_number':store_number,
      'oreiginal_amount':oreiginal_amount,






    };
  }
}