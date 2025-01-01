class Product {
   final int? id;
  final String? title;
  final String? description;
  final double? price;
   final int? stock;
final double? discountPercentage;
   final String? category;

   final String? thumbnail;
     int? Qty;




   Product({required this.price, this.stock,  this.category,this.discountPercentage,
      this.thumbnail, this.id, this.title, this.description,this.Qty});

 factory Product.fromJson(Map<String, dynamic> json) {
 return Product(
   id: json['id'], title: json['title'], description: json['description'],
     price: json['price'],stock: json['stock'],discountPercentage :json['discountPercentage'],
   category: json['category'],thumbnail: json['thumbnail'],
 Qty: json['Qty']);
   }
   }