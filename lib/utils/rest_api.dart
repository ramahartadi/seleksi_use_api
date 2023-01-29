class RestApi {
  static final String baseUrl =
      'https://basic-book-crud-e3u54evafq-et.a.run.app/api/';
  static _AuthApi authApi = _AuthApi();
  static _BooksApi bookApi = _BooksApi();
}

class _AuthApi {
  final String register = 'register';
  final String login = 'login';
  final String logout = 'user/logout';
  final String userInfo = 'user';
}

class _BooksApi {
  final String books = 'books';
  final String addBook = 'books/add';
  final String getBookById = 'books/';
}
