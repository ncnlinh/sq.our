import mongoose, {Schema} from 'mongoose';

const ObjectId = Schema.Types.ObjectId;

const Flight = new Schema({
  flightNumber: {type: String, required: true, index: true},
  startDate: {type: Date, required: true, index: true},
  startLocation: {type: String, required: true, index: true},
  endLocation: {type: String, required: true, index: true},
  users: [
    {
      facebookId: {type: String, required: true, index: true},
      purpose: {type: String}
    }
  ]
});

export default mongoose.model('Flight', Flight, 'Flight');
