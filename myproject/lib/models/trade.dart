class Trade {
  final String instrument;
  final double price;

  Trade({required this.instrument, required this.price});
}

// Sample logic to get a mock trade list without API
List<Trade> getMockTrades() {
  return [
    Trade(instrument: 'AAPL', price: 150.25),
    Trade(instrument: 'GOOGL', price: 2825.50),
    Trade(instrument: 'TSLA', price: 780.10),
  ];
}
