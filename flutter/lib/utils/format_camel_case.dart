String toCamelCase(String input) {
  List<String> words = input.split(" "); // Pisahkan string menjadi kata-kata

  // Capitalisasi setiap kata dalam list
  List<String> capitalizedWords = words.map((word) {
    if (word.isEmpty) {
      return word; // Jika kata kosong, langsung kembalikan kata tanpa perubahan
    }
    return word[0].toUpperCase() + word.substring(1);
  }).toList();

  return capitalizedWords
      .join(" "); // Gabungkan kembali kata-kata menjadi string
}
