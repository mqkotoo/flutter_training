const validJsonData = '''
        {
          "weather_condition": "cloudy",
          "max_temperature": 25, 
          "min_temperature": 7,
          "date": "2023-09-19 10:24:31.877"
        }
        ''';

const sunnyWeatherJsonData = '''
        {
          "weather_condition": "sunny",
          "max_temperature": 30, 
          "min_temperature": 0,
          "date": "2023-09-19 10:24:31.877"
        }
        ''';

const cloudyWeatherJsonData = '''
        {
          "weather_condition": "cloudy",
          "max_temperature": 25, 
          "min_temperature": 7,
          "date": "2023-09-19 10:24:31.877"
        }
        ''';

const rainyWeatherJsonData = '''
        {
          "weather_condition": "rainy",
          "max_temperature": 44, 
          "min_temperature": -22,
          "date": "2023-09-19 10:24:31.877"
        }
        ''';

const invalidJsonDataForCheckedFromJsonException = '''
        {
          "weather_condition": "thunder",
          "max_temperature": 25.0, 
          "min_temperature": 7,
          "date": "2023-09-19T00:00:00.000"
        }
        ''';

const invalidJsonDataForFormatException = '{invalid json data}';
