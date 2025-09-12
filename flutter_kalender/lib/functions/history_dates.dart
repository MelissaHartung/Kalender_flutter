import 'dart:convert';
import 'package:http/http.dart' as http;

Future<Map<String, dynamic>> ladeHistorischeereignisse (int apiMonth, int apiDay) async {
  try {
    final formattedMonth = apiMonth.toString().padLeft(2, '0');
    final formattedDay = apiDay.toString().padLeft(2, '0');
    
    final url = await http.get(Uri.parse('https://api.wikimedia.org/feed/v1/wikipedia/de/onthisday/all/$formattedMonth/$formattedDay'),
   
    headers: {
      'Content-Type': 'application/json',
    },
    );

    if (url.statusCode == 200) {
      return jsonDecode(url.body);
    }
    else {
      throw Exception('Fehler beim Laden: ${url.statusCode}');

    }
  }catch (error) {
    print('Fehler beim Laden: $error');
    rethrow;
  
  }
}