
class GroceryItem {
  String title;
  String description;
  String image;
  int quantity;
  double price;

  GroceryItem({this.title, this.description, this.quantity, this.image,this.price});
  GroceryItem.fromJson(Map<String,dynamic> json):
      title = json['title'],
      description = json['description'],
      quantity = json['quantity'],
      image = json['image'],
      price = json['price'];
  Map<String,dynamic> toJson() =>{
    'title':title,
    'description':description,
    'quantity':quantity,
    'image':image,
    'price':price
  };

}