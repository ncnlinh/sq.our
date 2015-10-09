import {ResponseHelper, MongooseHelper} from '../helpers';
import {Group} from '../models';

const DEBUG_ENV = 'GroupController';

const GroupController = {
  request: {}
};

GroupController.request.addChatMessage = (req, res) => {
  const {flightId, placeId, chat} = req.body;
  return Promise.resolve(Group.findOne({flightId, placeId}).exec())
    .then((group) => {
      if (!group) {
        return MongooseHelper.create(Group, {flightId, placeId, chat: []});
      }

      return group;
    })
    .then((group) => {
      return Promise.resolve(Group.findOneAndUpdate({flightId, placeId}, {
        $push: {
          chat
        }
      }).exec());
    })
    .then((group) => ResponseHelper.success(res, group))
    .catch((error) => ResponseHelper.error(res, error, DEBUG_ENV));

  return Promise.resolve(Group.findOne({flightId, placeId}).exec())
    .then((group) => ResponseHelper.success(res, group))
    .catch((error) => ResponseHelper.error(res, error, DEBUG_ENV));
}

GroupController.request.getChatMessages = (req, res) => {
  const {flightId, placeId} = req.body;
  return Promise.resolve(Group.findOne({flightId, placeId}).exec())
    .then((group) => ResponseHelper.success(res, group))
    .catch((error) => ResponseHelper.error(res, error, DEBUG_ENV));
};

export default GroupController;
