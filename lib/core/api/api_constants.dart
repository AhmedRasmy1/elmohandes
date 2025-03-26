class ApiConstants {
  static const String baseUrl = "http://elmohandes-api.runasp.net/";
  static const String login = "api/auth/login";
  static const String allProducts = "api/Product";
  static const String addProduct = "api/Product";
  static const String updateProduct = "api/Product";
  static const String deleteOneProduct = "api/Product/";
  static const String addProductToCart = "api/cart/add/";
  static const String cartDetails = "api/cart";
  static const String deleteProductFromCart = "api/cart/remove";
  static const String addInvoice = "api/Invoice/create";
  static const String allInvoices = "api/Invoice";
  static const String deleteOneInvoice = "api/Invoice/";
  static const String deleteAllInvoices = "api/Invoice";
  static const String totalSales = "api/invoice/total-sales";
  static const String totalSalesByDate = "api/invoice/today-sales";
  static const String invoicePreview = 'api/cart/preview-invoice';
}
