import mongoose, {Schema} from 'mongoose';

const Place = new Schema({
  yelpId: {type:String, unique: true, index: true},
  location: {type: String, index: true, required: true},
  address: {type:String},
  name: {type: String, index: true, required: true},
  imageUrl: {type:String},
  description: {type: String},
  latitude: {type: Number},
  longitude: {type: Number}
});

export default mongoose.model('Place', Place, 'Place');