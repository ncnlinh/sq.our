import mongoose, {Schema} from 'mongoose';

const ObjectId = Schema.Types.ObjectId;

const Schedule = new Schema({
  dayPlans: [
    {
      date: {type: Date, required: true, index: true},
      places: [{type: ObjectId, ref: 'Place'}]
    }
  ]
});

export default mongoose.model('Schedule', Schedule, 'Schedule');
