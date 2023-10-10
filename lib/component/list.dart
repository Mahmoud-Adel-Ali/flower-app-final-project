class Item {
  Item({required this.price, required this.imgPath,required this.location});
  final double price;
  final String imgPath;
  final String location ;
}

final List<Item> items = [
  Item(price: 13.99, imgPath: "assets/img/1.webp",location:"the best1"),
  Item(price: 14.99, imgPath: "assets/img/2.webp",location:"the best2"),
  Item(price: 15.99, imgPath: "assets/img/3.webp",location:"the best3"),
  Item(price: 16.99, imgPath: "assets/img/4.webp",location:"the best4"),
  Item(price: 17.99, imgPath: "assets/img/5.webp",location:"the best5"),
  Item(price: 18.99, imgPath: "assets/img/6.webp",location:"the best6"),
  Item(price: 19.99, imgPath: "assets/img/7.webp",location:"the best7"),
  Item(price: 20.99, imgPath: "assets/img/8.webp",location:"the best8"),
];
