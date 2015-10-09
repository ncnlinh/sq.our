import Promise from 'bluebird';
import fs from 'fs';

import {ResponseHelper} from '../helpers';

const DEBUG_ENV = 'MiscController';

const MiscController = {
  request: {},
  promise: {}
};

MiscController.request.getCities = (req, res) => {
  MiscController.promise.getCities(req)
    .then((cities) => ResponseHelper.success(res, cities))
    .catch((error) => ResponseHelper.error(res, error, DEBUG_ENV));
};

MiscController.promise.getCities = (req) => {
  return new Promise((resolve, reject) => {
    fs.readFile(__dirname + '/airports.json', 'utf8', function (err, data) {
      if (err) {
        return reject(err);
      }
      let airports = JSON.parse(data);
      airports = airports
        .filter((airport) => airport.airportCode && airport.cityName && airport.airportName && airport.airportName.toLowerCase().includes('international'))
        .map((airport) => {
          const row = {
            cityName: airport.cityName,
            airportName: airport.airportName,
            airportCode: airport.airportCode
          };

          return row;
        })
      airports.sort((a, b) => {
        if(a.cityName.toLowerCase() < b.cityName.toLowerCase()) return -1;
        if(a.cityName.toLowerCase() > b.cityName.toLowerCase()) return 1;
        return 0;
      });
      let initialArr = [];

      const airportMap = airports.reduce((map, airport) => {
        if (!map[airport.cityName[0].toLowerCase()]) {
          map[airport.cityName[0].toLowerCase()] = [];
          initialArr.push(airport.cityName[0].toUpperCase());
        }
        map[airport.cityName[0].toLowerCase()].push(airport);

        return map;
      }, {});

      resolve({airports, airportMap, initialArr});
    });  
  });
};

export default MiscController;
