class Product {
  final String name;
  final double price;

  Product({required this.name, required this.price});
}
List<Product> products = [
  Product(name: 'Laptop', price: 999.99),
  Product(name: 'Smartphone', price: 499.99),
  Product(name: 'Headphones', price: 199.99),
  Product(name: 'Smartwatch', price: 299.99),
  Product(name: 'Tablet', price: 399.99),
  Product(name: 'Book', price: 22.25),
];  

enum ProductSortType { name, price }