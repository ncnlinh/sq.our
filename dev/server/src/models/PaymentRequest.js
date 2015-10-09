import mongoose, {Schema} from 'mongoose';

const ObjectId = Schema.Types.ObjectId;

const PaymentRequest = new Schema({
  requestUser: {type: String, index: true, required: true},
  receivedUser: {type: String, index: true, required: true},
  sendingAccountNumber: {type: String},
  receivingAccountNumber: {type: String},
  amount: {type: Number, index: true, required: true},
  reason: {type: String},
  status: {type: String}
});

export default mongoose.model('PaymentRequest', PaymentRequest, 'PaymentRequest');
