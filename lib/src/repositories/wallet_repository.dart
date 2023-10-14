import 'dart:convert';

import 'package:teste_hub/src/models/profitability_rate_model.dart';
import 'package:teste_hub/src/models/wallet_model.dart';

enum TimeFilter { year, sixMonth, threeMonth }

class WalletRepository {
  WalletModel getWallet() {
    try {
      return WalletModel.fromJson(walletJson);
    } catch (e) {
      rethrow;
    }
  }

  List<ProfitabilityRateModel> getProfitabilityRate(
      {TimeFilter filter = TimeFilter.year}) {
    switch (filter) {
      case TimeFilter.year:
        var jsonList = jsonDecode(rateYear);
        return List.from(
            (jsonList as List).map((e) => ProfitabilityRateModel.fromMap(e)));
      case TimeFilter.sixMonth:
        var jsonList = jsonDecode(rateSixMonth);
        return List.from(
            (jsonList as List).map((e) => ProfitabilityRateModel.fromMap(e)));
      case TimeFilter.threeMonth:
        var jsonList = jsonDecode(rateThreeMonth);
        return List.from(
            (jsonList as List).map((e) => ProfitabilityRateModel.fromMap(e)));
    }
  }
}

var rateYear = '''[{
  "rateName": "wallet",
  "rates": [
  10.1,
  10.4,
  10.7,
  10.8,
  10.1,
  12.0,
  13.0,
  11.0,
  10.0,
  10.0
  ]
},
{
  "rateName": "CDI",
  "rates": [
  13.1,
  13.4,
  13.7,
  13.8,
  13.1,
  15.0,
  16.0,
  14.0,
  13.0,
  13.0
  ]
},
{
  "rateName": "IBOVS",
  "rates": [
  8.1,
  9.4,
  9.7,
  9.8,
  10.1,
  9.0,
  8.0,
  9.0,
  8.0,
  8.0
  ]
}
]''';

var rateSixMonth = '''[{
  "rateName": "wallet",
  "rates": [
  10.1,
  12.0,
  13.0,
  11.0,
  10.0,
  10.0
  ]
},
{
  "rateName": "CDI",
  "rates": [
  
  13.1,
  15.0,
  16.0,
  14.0,
  13.0,
  13.0
  ]
},
{
  "rateName": "IBOVS",
  "rates": [
  10.1,
  9.0,
  8.0,
  9.0,
  8.0,
  8.0
  ]
}
]''';

var rateThreeMonth = '''[{
  "rateName": "wallet",
  "rates": [
  
  11.0,
  10.0,
  10.0
  ]
},
{
  "rateName": "CDI",
  "rates": [
  
  14.0,
  13.0,
  13.0
  ]
},
{
  "rateName": "IBOVS",
  "rates": [
  
  9.0,
  8.0,
  8.0
  ]
}
]''';

var walletJson = '''{
  "totalAssets": 235000.0,
  "profitability": 1000.0,
  "investments": [
    {
      "name": "NTNB",
      "value": 50000.0
    },
    {
      "name": "NTNF",
      "value": 75000.0
    },
    {
      "name": "LFT",
      "value": 25000.0
    },
    {
      "name": "LTN",
      "value": 50000.0
    },
    {
      "name": "Outros",
      "value": 35000.0
    }
  ]
}''';
