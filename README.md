# GPS Signal Map

Creates a heatmap of GPS signal strength based on nmea input.

## Usage

ruby bin\parse_nmea.rb <input_directory> <latitude_step> <longitude_step>

Example:
ruby bin\parse_nmea.rb input 0.01 0.5

Input directory has contain text files with nmea information.

```$GPGGA,060830.000,5420.92802,N,01831.92946,E,1,05,2.2,152.1,M,34.6,M,,*5B
$GPGLL,5420.92802,N,01831.92946,E,060830.000,A,A*5D
$GPGSA,A,3,29,14,12,06,02,,,,,,,,3.3,2.2,2.4*3D
$GPGST,060830.000,17.3,40.5,10.0,64.0,13.4,24.6,33.7*5C
$GPGSV,2,1,07,31,42,299,36,29,57,229,35,25,86,122,34,14,11,241,35*73
$GPGSV,2,2,07,12,44,107,38,06,18,040,34,02,43,072,35*4A
$GPRMC,060830.000,A,5420.92802,N,01831.92946,E,10.4,162.5,300915,3.8,E,A*31
$GPVTG,162.5,T,158.7,M,10.4,N,19.3,K,A*26
```


## Example result
![screenshot](https://raw.githubusercontent.com/SebastianCelejewski/gps-signal-map/master/doc/GpsSignalMap.JPG)
