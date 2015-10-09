import mongoose, {Schema} from 'mongoose';

const ObjectId = Schema.Types.ObjectId;

const Flight = new Schema({
  flightNumbers: {type: String, required: true, index: true},
  startDate: {type: Date, required: true, index: true},
  startLocation: {type: String, required: true, index: true},
  endLocation: {type: String, required: true, index: true},
  users: [
    {
      _id: {type: Schema.Types.ObjectId, required: true, index: true, unique: true},
      facebookId: {refs: 'User', type: String, required: true, index: true, unique: true},
      purpose: {type: String}
    }
  ]
});

export default mongoose.model('Flight', Flight, 'Flight');
