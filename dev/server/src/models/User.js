import mongoose, {Schema} from 'mongoose';

const User = new Schema({
  facebookId: {type: String, required: true, index: true, unique: true},
  name: {type: String, required: true, index: true},
  bankAccount: {type: String, index: true},
  flights: [
    {
      _id: {type: Schema.Types.ObjectId, ref: 'Flight', required: true, index: true},
      likedPlaces:[{type: String}]
    }
  ]
});

export default mongoose.model('User', User, 'User');
