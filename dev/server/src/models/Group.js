import mongoose, {Schema} from 'mongoose';

const ObjectId = Schema.Types.ObjectId;

const Group = new Schema({
  flightId: {type: ObjectId, ref: 'Flight', index: true},
  placeId: {type: String, index: true},
  chat: [
    {
      by: {type: String, index: true},
      message: {type: String}
    }
  ]
});

export default mongoose.model('Group', Group, 'Group');
