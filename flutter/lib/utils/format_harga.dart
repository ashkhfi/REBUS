class PriceFormatter {
  static String formatPrice(int price) {
    if (price >= 1000000000) {
      double formattedPrice = price / 1000000000;
      return '${formattedPrice.toStringAsFixed(formattedPrice.truncateToDouble() == formattedPrice ? 0 : 2)}';
    } else if (price >= 1000000) {
      double formattedPrice = price / 1000000;
      return '${formattedPrice.toStringAsFixed(formattedPrice.truncateToDouble() == formattedPrice ? 0 : 2)}';
    } else {
      return price.toString().replaceAllMapped(
          RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.');
    }
  }
}
