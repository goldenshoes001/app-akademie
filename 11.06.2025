void main(){

  List<Map<String, double?>> weatherdata = [

    {'temp' : 5.3, 'rain' : 0.9, 'wind': null},
    {'temp' : 4.5, "rain" : null, "wind": 16.8},
    {'temp' : null, "rain" : 3.8, "wind" : null}
  ];
  List<double?> temps = [];
  List<double?> rain = [];
  List<double?> wind = [];

  double avgTemp = 0;
  double avgRain = 0;
  double avgWind = 0;


for(int i = 0; i<weatherdata.length; i++) {
 
    if(weatherdata[i]["temp"]!=null)
    {
    temps.add(weatherdata[i]["temp"]!);
    avgTemp += weatherdata[i]["temp"]!;  
        
    }

    if(weatherdata[i]["rain"]!=null)
    {
    rain.add(weatherdata[i]["rain"]!); 
    avgRain += weatherdata[i]["rain"]!; 
    
    }

    if(weatherdata[i]["wind"]!=null)
    {
    wind.add(weatherdata[i]["wind"]!);  
    avgWind += weatherdata[i]["wind"]!;

    }
}

   avgTemp /= temps.length;
    avgRain /= rain.length;
    avgWind /= wind.length;

print("avgTemp: $avgTemp avgRain: $avgRain avgWind: $avgWind");



}

