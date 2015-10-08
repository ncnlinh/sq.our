import mongoose, {Schema} from 'mongoose';

const User = new Schema({
  facebookId: {type: String, required: true, index: true, unique: true},
  name: {type: String, required: true, index: true},
  bankAccount: {type: String, index: true}
});

export default mongoose.model('User', User, 'User');
