import 'dart:convert';

class Welcome {
  Welcome({
    this.cod,
    this.message,
    this.cnt,
    this.list,
    this.city,
  });

  String cod;
  int message;
  int cnt;
  List<ListElement> list;
  City city;

  factory Welcome.fromJson(var str) => Welcome.fromMap(str);

  String toJson() => json.encode(toMap());

  factory Welcome.fromMap(Map<String, dynamic> json) => Welcome(
    cod: json["cod"] == null ? null : json["cod"],
    message: json["message"] == null ? null : json["message"],
    cnt: json["cnt"] == null ? null : json["cnt"],
    list: json["list"] == null ? null : List<ListElement>.from(json["list"].map((x) => ListElement.fromMap(x))),
    city: json["city"] == null ? null : City.fromMap(json["city"]),
  );

  Map<String, dynamic> toMap() => {
    "cod": cod == null ? null : cod,
    "message": message == null ? null : message,
    "cnt": cnt == null ? null : cnt,
    "list": list == null ? null : List<dynamic>.from(list.map((x) => x.toMap())),
    "city": city == null ? null : city.toMap(),
  };
}

class City {
  City({
    this.id,
    this.name,
    this.coord,
    this.country,
    this.population,
    this.timezone,
    this.sunrise,
    this.sunset,
  });

  int id;
  String name;
  Coord coord;
  String country;
  int population;
  int timezone;
  int sunrise;
  int sunset;

  factory City.fromJson(var str) => City.fromMap(str);

  String toJson() => json.encode(toMap());

  factory City.fromMap(Map<String, dynamic> json) => City(
    id: json["id"] == null ? null : json["id"],
    name: json["name"] == null ? null : json["name"],
    coord: json["coord"] == null ? null : Coord.fromMap(json["coord"]),
    country: json["country"] == null ? null : json["country"],
    population: json["population"] == null ? null : json["population"],
    timezone: json["timezone"] == null ? null : json["timezone"],
    sunrise: json["sunrise"] == null ? null : json["sunrise"],
    sunset: json["sunset"] == null ? null : json["sunset"],
  );

  Map<String, dynamic> toMap() => {
    "id": id == null ? null : id,
    "name": name == null ? null : name,
    "coord": coord == null ? null : coord.toMap(),
    "country": country == null ? null : country,
    "population": population == null ? null : population,
    "timezone": timezone == null ? null : timezone,
    "sunrise": sunrise == null ? null : sunrise,
    "sunset": sunset == null ? null : sunset,
  };
}

class Coord {
  Coord({
    this.lat,
    this.lon,
  });

  double lat;
  double lon;

  factory Coord.fromJson(var str) => Coord.fromMap(str);

  String toJson() => json.encode(toMap());

  factory Coord.fromMap(Map<String, dynamic> json) => Coord(
    lat: json["lat"] == null ? null : json["lat"].toDouble(),
    lon: json["lon"] == null ? null : json["lon"].toDouble(),
  );

  Map<String, dynamic> toMap() => {
    "lat": lat == null ? null : lat,
    "lon": lon == null ? null : lon,
  };
}

class ListElement {
  ListElement({
    this.dt,
    this.main,
    this.weather,
    this.clouds,
    this.wind,
    this.visibility,
    this.pop,
    this.sys,
    this.dtTxt,
    this.snow,
    this.rain,
  });

  int dt;
  MainClass main;
  List<Weather> weather;
  Clouds clouds;
  Wind wind;
  int visibility;
  double pop;
  Sys sys;
  DateTime dtTxt;
  Rain snow;
  Rain rain;

  factory ListElement.fromJson(var str) => ListElement.fromMap(str);

  String toJson() => json.encode(toMap());

  factory ListElement.fromMap(Map<String, dynamic> json) => ListElement(
    dt: json["dt"] == null ? null : json["dt"],
    main: json["main"] == null ? null : MainClass.fromMap(json["main"]),
    weather: json["weather"] == null ? null : List<Weather>.from(json["weather"].map((x) => Weather.fromMap(x))),
    clouds: json["clouds"] == null ? null : Clouds.fromMap(json["clouds"]),
    wind: json["wind"] == null ? null : Wind.fromMap(json["wind"]),
    visibility: json["visibility"] == null ? null : json["visibility"],
    pop: json["pop"] == null ? null : json["pop"].toDouble(),
    sys: json["sys"] == null ? null : Sys.fromMap(json["sys"]),
    dtTxt: json["dt_txt"] == null ? null : DateTime.parse(json["dt_txt"]),
    snow: json["snow"] == null ? null : Rain.fromMap(json["snow"]),
    rain: json["rain"] == null ? null : Rain.fromMap(json["rain"]),
  );

  Map<String, dynamic> toMap() => {
    "dt": dt == null ? null : dt,
    "main": main == null ? null : main.toMap(),
    "weather": weather == null ? null : List<dynamic>.from(weather.map((x) => x.toMap())),
    "clouds": clouds == null ? null : clouds.toMap(),
    "wind": wind == null ? null : wind.toMap(),
    "visibility": visibility == null ? null : visibility,
    "pop": pop == null ? null : pop,
    "sys": sys == null ? null : sys.toMap(),
    "dt_txt": dtTxt == null ? null : dtTxt.toIso8601String(),
    "snow": snow == null ? null : snow.toMap(),
    "rain": rain == null ? null : rain.toMap(),
  };
}

class Clouds {
  Clouds({
    this.all,
  });

  int all;

  factory Clouds.fromJson(var str) => Clouds.fromMap(str);

  String toJson() => json.encode(toMap());

  factory Clouds.fromMap(Map<String, dynamic> json) => Clouds(
    all: json["all"] == null ? null : json["all"],
  );

  Map<String, dynamic> toMap() => {
    "all": all == null ? null : all,
  };
}

class MainClass {
  MainClass({
    this.temp,
    this.feelsLike,
    this.tempMin,
    this.tempMax,
    this.pressure,
    this.seaLevel,
    this.grndLevel,
    this.humidity,
    this.tempKf,
  });

  double temp;
  double feelsLike;
  double tempMin;
  double tempMax;
  int pressure;
  int seaLevel;
  int grndLevel;
  int humidity;
  double tempKf;

  factory MainClass.fromJson(var str) => MainClass.fromMap(str);

  String toJson() => json.encode(toMap());

  factory MainClass.fromMap(Map<String, dynamic> json) => MainClass(
    temp: json["temp"] == null ? null : json["temp"].toDouble(),
    feelsLike: json["feels_like"] == null ? null : json["feels_like"].toDouble(),
    tempMin: json["temp_min"] == null ? null : json["temp_min"].toDouble(),
    tempMax: json["temp_max"] == null ? null : json["temp_max"].toDouble(),
    pressure: json["pressure"] == null ? null : json["pressure"],
    seaLevel: json["sea_level"] == null ? null : json["sea_level"],
    grndLevel: json["grnd_level"] == null ? null : json["grnd_level"],
    humidity: json["humidity"] == null ? null : json["humidity"],
    tempKf: json["temp_kf"] == null ? null : json["temp_kf"].toDouble(),
  );

  Map<String, dynamic> toMap() => {
    "temp": temp == null ? null : temp,
    "feels_like": feelsLike == null ? null : feelsLike,
    "temp_min": tempMin == null ? null : tempMin,
    "temp_max": tempMax == null ? null : tempMax,
    "pressure": pressure == null ? null : pressure,
    "sea_level": seaLevel == null ? null : seaLevel,
    "grnd_level": grndLevel == null ? null : grndLevel,
    "humidity": humidity == null ? null : humidity,
    "temp_kf": tempKf == null ? null : tempKf,
  };
}

class Rain {
  Rain({
    this.the3H,
  });

  double the3H;

  factory Rain.fromJson(var str) => Rain.fromMap(str);

  String toJson() => json.encode(toMap());

  factory Rain.fromMap(Map<String, dynamic> json) => Rain(
    the3H: json["3h"] == null ? null : json["3h"].toDouble(),
  );

  Map<String, dynamic> toMap() => {
    "3h": the3H == null ? null : the3H,
  };
}

class Sys {
  Sys({
    this.pod,
  });

  Pod pod;

  factory Sys.fromJson(var str) => Sys.fromMap(str);

  String toJson() => json.encode(toMap());

  factory Sys.fromMap(Map<String, dynamic> json) => Sys(
    pod: json["pod"] == null ? null : podValues.map[json["pod"]],
  );

  Map<String, dynamic> toMap() => {
    "pod": pod == null ? null : podValues.reverse[pod],
  };
}

enum Pod { N, D }

final podValues = EnumValues({
  "d": Pod.D,
  "n": Pod.N
});

class Weather {
  Weather({
    this.id,
    this.main,
    this.description,
    this.icon,
  });

  int id;
  MainEnum main;
  String description;
  String icon;

  factory Weather.fromJson(var str) => Weather.fromMap(str);

  String toJson() => json.encode(toMap());

  factory Weather.fromMap(Map<String, dynamic> json) => Weather(
    id: json["id"] == null ? null : json["id"],
    main: json["main"] == null ? null : mainEnumValues.map[json["main"]],
    description: json["description"] == null ? null : json["description"],
    icon: json["icon"] == null ? null : json["icon"],
  );

  Map<String, dynamic> toMap() => {
    "id": id == null ? null : id,
    "main": main == null ? null : mainEnumValues.reverse[main],
    "description": description == null ? null : description,
    "icon": icon == null ? null : icon,
  };
}

enum MainEnum { CLOUDS, SNOW, RAIN, CLEAR }

final mainEnumValues = EnumValues({
  "Clear": MainEnum.CLEAR,
  "Clouds": MainEnum.CLOUDS,
  "Rain": MainEnum.RAIN,
  "Snow": MainEnum.SNOW
});

class Wind {
  Wind({
    this.speed,
    this.deg,
  });

  double speed;
  int deg;

  factory Wind.fromJson(var str) => Wind.fromMap(str);

  String toJson() => json.encode(toMap());

  factory Wind.fromMap(Map<String, dynamic> json) => Wind(
    speed: json["speed"] == null ? null : json["speed"].toDouble(),
    deg: json["deg"] == null ? null : json["deg"],
  );

  Map<String, dynamic> toMap() => {
    "speed": speed == null ? null : speed,
    "deg": deg == null ? null : deg,
  };
}

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
