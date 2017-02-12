/*
 Declare required modules
 */
var xml2js = require('xml2js');
var fs = require('fs');

/*
 Declare global data storage
 */
var lightning = [];
var lightning_i = 0;

/*
 Get the Parser
 */
var parser = new xml2js.Parser();

/*
 Read the file
 */
fs.readFile('./input/lightning_src.kml', function(err, data) {
	parser.parseString(data, function(err, result) {
		/*
		 Get all strikes as Placemarks
		 */
		var placemarks = result.kml.Document[0].Folder[0].Placemark;

		/*
		 Process each strike
		 */
		for (var i = 0; i < placemarks.length; i++) {
			var strike = placemarks[i];
			var timestamp = strike.name[0];

			var coordinates = strike.Point[0].coordinates[0].split(",");
			var longitude = coordinates[0];
			var latitude = coordinates[1];

			lightning_i++;
			lightning[lightning_i] = {
				'latitude': latitude,
				'longitude': longitude,
				'timestamp': timestamp
			};
		}

		/*
		 Output the data
		 */
		lightning = {'wwlln': lightning};
		var lightning_json = JSON.stringify(lightning);
		console.log(lightning_json);
	});
});