function csvToArray (csv) {
    rows = csv.split("\n");

    return rows.map(function (row) {
    	return row.split(",");
    });
};



var fs = require('fs'),
    path = require('path'),    
    filePath = path.join(__dirname, 'test.csv');

var csv = fs.readFile(filePath, {encoding: 'utf-8'}, function(err,data){
    if (!err) {
        return data.toString;
    } else {
        console.log(err);
    }
});



var array = csvToArray(csv);

console.log(array);