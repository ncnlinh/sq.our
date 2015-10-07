import mongoose, {Schema} from 'mongoose';

const ObjectId = Schema.Types.ObjectId;

const Group = new Schema({
  flight: {type: ObjectId, ref: 'Flight', index: true},
  place: {type: ObjectId, ref: 'Place', index: true},
  date: {type: Date, index: true, required: true},
  creator: {type: String, index: true, required: true},
  members: [{type: String, index: true}],
  chat: [
    {
      by: {type: String, index: true},
      message: {type: String}
    }
  ]
});

export default mongoose.model('Group', Group, 'Group');
