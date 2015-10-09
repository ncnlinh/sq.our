import Promise from 'bluebird';
import superagent from 'superagent';
import cardMappingServiceClass from '../../lib/mastercard-api/services/moneysend/CardMappingService';
import transferServiceClass from '../../lib/mastercard-api/services/moneysend/TransferService';
import panEligibilityServiceClass from '../../lib/mastercard-api/services/moneysend/PanEligibilityService';
import environment from '../../lib/mastercard-api/common/Environment';
import fs from 'fs';

import endpoint from './endpoint';
import key from '../../config/key';

const Mastercard = {
  services: {},
  helpers: {}
};


Mastercard.helpers.generatePrivateKey = (env) =>{
  var pem;
  if (env == environment.production){
    pem = fs.readFileSync(__dirname + '/sia.pem');
  }
  else {
    pem = fs.readFileSync(__dirname + '/sia.pem');
  }
  return pem.toString('utf8')
};

Mastercard.helpers.generateTransactionRef = () => {
  function randomString(length, chars) {
    var result = '';
    for (var i = length; i > 0; --i) result += chars[Math.round(Math.random() * (chars.length - 1))];
    return result;
  }
  return randomString(19, '0123456789');
}
Mastercard.services.cardMapCreate = (userId, accountNumber, alias) => {
  let privateKey = Mastercard.helpers.generatePrivateKey(environment.sandbox);
  let service = new cardMappingServiceClass.CardMappingService(key.MASTERCARD_CONSUMER_KEY,
    privateKey, environment.sandbox);
  const createRequest = 
  {
    CreateMappingRequest: {
      ICA : "009674",
      SubscriberId : userId,
      SubscriberType : "PHONE_NUMBER",
      AccountUsage : "RECEIVING",
      AccountNumber : accountNumber,
      DefaultIndicator : "T",
      ExpiryDate : 201801,
      Alias : alias,
      Address: {
        Line1 : "123 Main Street",
        City : "OFallon",
        CountrySubdivision : "MO",
        Country : "USA",
        PostalCode : 63368
      },
      CardholderFullName: {
        CardholderFirstName : "John",
        CardholderMiddleName : "Q",
        CardholderLastName : "Public"
      },
      DateOfBirth : 19951216
    }
  };

  //type = enum['CreateMappingRequest', 'InquireMappingRequest', 'UpdateMappingRequest', 'DeleteMappingRequestOptions']
  return Promise.resolve(service.getCreateMapping(createRequest));
};

Mastercard.services.cardMapInquire = (userId, alias) => {
  let privateKey = Mastercard.helpers.generatePrivateKey(environment.sandbox);
  let service = new cardMappingServiceClass.CardMappingService(key.MASTERCARD_CONSUMER_KEY,
    privateKey, environment.sandbox);
  const inquireRequest = 
  {
    InquireMappingRequest: {
      SubscriberId : userId,
      SubscriberType : "PHONE_NUMBER",
      AccountUsage : "RECEIVING",
      Alias : alias,
      DataResponseFlag: "3"
    }
  };

  //type = enum['CreateMappingRequest', 'InquireMappingRequest', 'UpdateMappingRequest', 'DeleteMappingRequestOptions']

  return Promise.resolve(service.getInquireMapping(inquireRequest)); 
};

Mastercard.services.cardMapUpdate = (userId, accountNumber, alias) => {
  let privateKey = Mastercard.helpers.generatePrivateKey(environment.sandbox);
  let service = new cardMappingServiceClass.CardMappingService(key.MASTERCARD_CONSUMER_KEY,
    privateKey, environment.sandbox);
  const inquireRequest = 
  {
    InquireMappingRequest: {
      SubscriberId : userId,
      SubscriberType : "PHONE_NUMBER",
      AccountUsage : "RECEIVING",
      Alias : alias,
      DataResponseFlag: "3"
    }
  };
  const updateRequest = 
  {
    UpdateMappingRequest: {
      AccountUsage : "RECEIVING",
      AccountNumber : accountNumber,
      DefaultIndicator : "T",
      ExpiryDate : 201801,
      Alias : alias,
      Address: {
        Line1 : "123 Main Street",
        City : "OFallon",
        CountrySubdivision : "MO",
        Country : "USA",
        PostalCode : 63368
      },
      CardholderFullName: {
        CardholderFirstName : "John",
        CardholderMiddleName : "Q",
        CardholderLastName : "Public"
      },
      DateOfBirth : 19951216
    }
  };

  //type = enum['CreateMappingRequest', 'InquireMappingRequest', 'UpdateMappingRequest', 'DeleteMappingRequestOptions']

  return Promise.resolve(service.getInquireMapping(inquireRequest))
  .then((inquireMapping) => {
    let mapping_id = inquireMapping.InquireMapping.Mappings[0].Mapping[0].MappingId[0];
    var options =
    {
        MappingId: mapping_id
    };
    return Promise.resolve(service.getUpdateMapping(updateRequest, options));
  })
};

Mastercard.services.transfer = (sendingAccountNumber, receivingAccountNumber, amount) =>{
  let privateKey = Mastercard.helpers.generatePrivateKey(environment.sandbox);
  let service = new transferServiceClass.TransferService(
    key.MASTERCARD_CONSUMER_KEY,
    privateKey,
    environment.sandbox
  );
  const request =
  {
    TransferRequest: {
        LocalDate: "1212",
        LocalTime: "161222",
        TransactionReference: Mastercard.helpers.generateTransactionRef(),
        SenderName: "John Doe",
        SenderAddress: {
            Line1:  "123 Main Street",
            Line2:  "#5A",
            City:  "Arlington",
            CountrySubdivision:  "VA",
            PostalCode: "22207",
            Country:  "USA"
        },
        FundingCard: {
            AccountNumber: sendingAccountNumber,
            ExpiryMonth:  "01",
            ExpiryYear:  "2018"
        },
        FundingUCAF:  "MjBjaGFyYWN0ZXJqdW5rVUNBRjU=1111",
        FundingMasterCardAssignedId:  "123456",
        FundingAmount: {
            Value: amount, 
            Currency:  "702" //IS0 4217 SGD
        },
        ReceiverName:  "Jose Lopez",
        ReceiverAddress: {
            Line1:  "Pueblo Street",
            Line2:  "PO BOX 12",
            City:  "El PASO",
            CountrySubdivision:  "TX",
            PostalCode:  "79906",
            Country:  "USA"
        },
        ReceiverPhone:  "1800639426",
        ReceivingCard: {
            AccountNumber:  receivingAccountNumber
        },
        ReceivingAmount: {
            Value: amount,
            Currency: "702" //IS0 4217 SGD
        },
        Channel:  "W",
        UCAFSupport:  "false",
        ICA: "009674",
        ProcessorId:  "9000000442",
        RoutingAndTransitNumber:  "990442082",
        CardAcceptor: {
            Name:  "My Local Bank",
            City:  "Saint Louis",
            State:  "MO",
            PostalCode: "63101",
            Country:  "USA"
        },
        TransactionDesc:  "P2P",
        MerchantId:  "123456"
    }
  }
  return Promise.resolve(service.getTransfer(request));
};


Mastercard.services.checkEligibility = (sendingAccountNumber, receivingAccountNumber) => {
  let privateKey = Mastercard.helpers.generatePrivateKey(environment.sandbox);
  let service = new panEligibilityServiceClass.PanEligibilityService(key.MASTERCARD_CONSUMER_KEY,
    privateKey, environment.sandbox);
  const checkEligibilityRequest = 
  {
    PanEligibilityRequest: {
      SendingAccountNumber : sendingAccountNumber,
      ReceivingAccountNumber : receivingAccountNumber
    }
  };

  //type = enum['CreateMappingRequest', 'InquireMappingRequest', 'UpdateMappingRequest', 'DeleteMappingRequestOptions']

  return Promise.resolve(service.getPanEligibility(checkEligibilityRequest)); 

}
export default Mastercard;