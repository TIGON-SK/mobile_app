class Book{
  //List<Book> bookFromJson(String str) => List<Book>.from(json.decode(str).map((x) => Book.fromJson(x)));

  int id = 0;
  String title = "";

  Book({required this.id, required this.title});

  factory Book.fromJson(Map<String, dynamic> parsedJson){
    return Book(
        id: parsedJson['id'],
        title : parsedJson['title'],
    );
  }
}