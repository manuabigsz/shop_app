class CartItem {
  final String productID;
  final String name;
  final String id;
  final int quantity;
  final double price;

  CartItem(
      {required this.id,
      required this.productID,
      required this.name,
      required this.quantity,
      required this.price});
}
