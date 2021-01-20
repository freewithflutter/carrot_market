class LocationData {
  Map<String, dynamic> data = {
    'suyou': [
      {
        'image':
            'https://firebasestorage.googleapis.com/v0/b/carrot-market-202da.appspot.com/o/item%2F8f0064a2fc8e71d72f0f23a86978ab46.jpg?alt=media&token=ff862ab2-d2cc-44c2-be31-21fb764a3cc4',
        'title': '에어팟프로',
        'place': '수유',
        'lastTime': '20초 전',
        'price': '200000',
      }
    ],
    'mia': [
      {
        'image':
            'https://firebasestorage.googleapis.com/v0/b/carrot-market-202da.appspot.com/o/item%2Fitem.jpg?alt=media&token=2740dbb7-5059-4718-9007-5f0d78656a8b',
        'title': '맥북프로',
        'place': '미아',
        'lastTime': '20초 전',
        'price': '1200000',
      }
    ]
  };
  Future<List<Map<String, String>>> loadDataFromLocation(
      String location) async {
    await Future.delayed(Duration(seconds: 1));
    return data[location];
  }
}
