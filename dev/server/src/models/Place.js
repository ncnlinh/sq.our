import mongoose, {Schema} from 'mongoose';

const Place = new Schema({
  yelpId: {type:String, index: true},
  location: {type: String, index: true, required: true},
  address: {type:String},
  name: {type: String, index: true, required: true},
  imageUrl: {type:String},
  category: {type: String, enum: ['hotel', 'restaurant', 'attraction']},
  description: {type: String},
  latitude: {type: Number},
  longitude: {type: Number},
  isMasterCardSupported: {type: Boolean, index: true, default: false}
});

export default mongoose.model('Place', Place, 'Place');