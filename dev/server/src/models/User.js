import mongoose, {Schema} from 'mongoose';

const User = new Schema({
  facebookId: {type: String, required: true, index: true, unique: true},
  bankAccount: {type: String, index: true}
});

export default mongoose.model('User', User, 'User');
