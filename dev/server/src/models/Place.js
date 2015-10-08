import mongoose, {Schema} from 'mongoose';

const Place = new Schema({
  location: {type: String, index: true, required: true},
  name: {type: String, index: true, required: true},
  category: {type: String, enum: ['hotel', 'restaurant', 'attraction']},
  description: {type: String},
  lat: {type: Number},
  lon: {type: Number},
  isMasterCardSupported: {type: Boolean, index: true, default: false}
});

export default mongoose.model('Place', Place, 'Place');