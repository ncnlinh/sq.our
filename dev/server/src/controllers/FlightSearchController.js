import Promise from 'bluebird';

import {ResponseHelper} from '../helpers';
import {Amadeus} from './ApiHelper/';

const DEBUG_ENV = 'FlightSearchController';

const FlightSearchController = {
  request: {},
  promise: {}
};


FlightSearchController.request.search = (req, res) => {
  const {startLocation, endLocation, startDate, marketingAirlines, currency} = req.body;
  return Amadeus.services.search(startLocation, endLocation, startDate, marketingAirlines, currency)
    .then((data) => {
      data = data.results.map((result)=>{
        let flightData = {};
        const flights = result.itineraries[0].outbound.flights;
        flightData.startDate = flights[0].departs_at;
        flightData.endDate = flights[flights.length-1].arrives_at;
        flightData.startLocation = flights[0].origin.airport;
        flightData.endLocation = flights[flights.length-1].destination.airport;
        flightData.airports = [];
        flightData.flightNumbers = "";
        flightData.fare = result.fare.total_price;
        flights.forEach((flight, i) => {
          flightData.airports.push(flight.origin.airport);
          flightData.flightNumbers += flight.operating_airline + flight.flight_number 
          if (i === flights.length-1) {
            flightData.airports.push(flight.destination.airport);
          } else {
            flightData.flightNumbers += "/"
          }
        })
        return flightData;
      });
      ResponseHelper.success(res, data)
    })
    .catch((error) => ResponseHelper.error(res, error, DEBUG_ENV));
}

export default FlightSearchController;