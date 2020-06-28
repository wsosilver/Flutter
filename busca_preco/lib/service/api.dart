import 'package:http/http.dart' as http;

var url = 'http://localhost:3000/prod';

Future<String>buscarItem() async{
  var response = await http.get(url);
  print('Response status: ${response.statusCode}');
  print('Response body: ${response.body}');

  print(await http.read('https://example.com/foobar.txt'));
}