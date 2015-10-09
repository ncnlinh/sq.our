#import <JSQMessagesViewController/JSQMessage.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <PromiseKit/PromiseKit.h>

#import "ChatGroupViewController.h"
#import "ChatData.h"
#import "HttpClient.h"
#import "Constants.h"

@implementation ChatGroupViewController {
  ChatData *data;
}

#pragma mark - View lifecycle
- (void)viewDidLoad {
  [super viewDidLoad];
  self.title = @"Group Chat";
  
  /**
   *  You MUST set your senderId and display name
   */
  self.senderId = [FBSDKAccessToken currentAccessToken].userID;
  self.senderDisplayName = [FBSDKProfile currentProfile].name;

  data = [[ChatData alloc] init];
}

- (void)viewDidAppear:(BOOL)animated {
  [super viewDidAppear:animated];
  [self requestData];
}

- (void)requestData {
  NSString *requestUrl = [NSString stringWithFormat:@"%@/api/group", [Constants apiUrl]];
  [HttpClient postWithUrl:requestUrl body:@{
                                            @"flightId": self.flight[@"_id"],
                                            @"placeId": self.place[@"yelpId"]
                                            }]
  .then(^(NSDictionary *group) {
    NSArray *chats = group[@"chat"];
    for (NSUInteger i = data.messages.count; i < chats.count; i++) {
      JSQMessage *message = [[JSQMessage alloc] initWithSenderId:chats[i][@"by"]
                                               senderDisplayName:@""
                                                            date:[NSDate date]
                                                            text:chats[i][@"message"]];
      [data.messages addObject:message];
    }
    [self finishSendingMessageAnimated:YES];
  });
}

#pragma mark - JSQMessagesViewController method overrides

- (void)didPressSendButton:(UIButton *)button
           withMessageText:(NSString *)text
                  senderId:(NSString *)senderId
         senderDisplayName:(NSString *)senderDisplayName
                      date:(NSDate *)date {
  JSQMessage *message = [[JSQMessage alloc] initWithSenderId:senderId
                                           senderDisplayName:senderDisplayName
                                                        date:date
                                                        text:text];
  
  [data.messages addObject:message];
  NSString *requestUrl = [NSString stringWithFormat:@"%@/api/group/addChat", [Constants apiUrl]];
  [HttpClient postWithUrl:requestUrl body:@{
                                            @"flightId": self.flight[@"_id"],
                                            @"placeId": self.place[@"yelpId"],
                                            @"chat": @{
                                                @"by": [FBSDKAccessToken currentAccessToken].userID,
                                                @"message": text
                                                }
                                            }]
  .then(^(NSDictionary *group) {
    NSArray *chats = group[@"chat"];
    for (NSUInteger i = data.messages.count; i < chats.count; i++) {
      JSQMessage *message = [[JSQMessage alloc] initWithSenderId:chats[i][@"by"]
                                               senderDisplayName:@""
                                                            date:[NSDate date]
                                                            text:chats[i][@"message"]];
      [data.messages addObject:message];
    }
  });
  [self finishSendingMessageAnimated:YES];
}

#pragma mark - JSQMessages CollectionView DataSource

- (id<JSQMessageData>)collectionView:(JSQMessagesCollectionView *)collectionView messageDataForItemAtIndexPath:(NSIndexPath *)indexPath
{
  return [data.messages objectAtIndex:indexPath.item];
}

- (id<JSQMessageBubbleImageDataSource>)collectionView:(JSQMessagesCollectionView *)collectionView messageBubbleImageDataForItemAtIndexPath:(NSIndexPath *)indexPath
{
  /**
   *  You may return nil here if you do not want bubbles.
   *  In this case, you should set the background color of your collection view cell's textView.
   *
   *  Otherwise, return your previously created bubble image data objects.
   */
  
  JSQMessage *message = [data.messages objectAtIndex:indexPath.item];
  
  if ([message.senderId isEqualToString:self.senderId]) {
    return data.outgoingBubbleImageData;
  }
  
  return data.incomingBubbleImageData;
}

- (id<JSQMessageAvatarImageDataSource>)collectionView:(JSQMessagesCollectionView *)collectionView avatarImageDataForItemAtIndexPath:(NSIndexPath *)indexPath {
  JSQMessage *message = [data.messages objectAtIndex:indexPath.item];
  return [data.avatars objectForKey:message.senderId];
}

- (NSAttributedString *)collectionView:(JSQMessagesCollectionView *)collectionView attributedTextForMessageBubbleTopLabelAtIndexPath:(NSIndexPath *)indexPath {
  JSQMessage *message = [data.messages objectAtIndex:indexPath.item];
  if ([message.senderId isEqualToString:self.senderId]) {
    return nil;
  }
  
  if (indexPath.item - 1 > 0) {
    JSQMessage *previousMessage = [data.messages objectAtIndex:indexPath.item - 1];
    if ([[previousMessage senderId] isEqualToString:message.senderId]) {
      return nil;
    }
  }
  
  return [[NSAttributedString alloc] initWithString:message.senderDisplayName];
}

#pragma mark - UICollectionView DataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
  return [data.messages count];
}

- (UICollectionViewCell *)collectionView:(JSQMessagesCollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
  JSQMessagesCollectionViewCell *cell = (JSQMessagesCollectionViewCell *)[super collectionView:collectionView cellForItemAtIndexPath:indexPath];
  JSQMessage *msg = [data.messages objectAtIndex:indexPath.item];
  if ([msg.senderId isEqualToString:self.senderId]) {
    cell.textView.textColor = [UIColor blackColor];
  }
  else {
    cell.textView.textColor = [UIColor whiteColor];
  }
  
  cell.textView.linkTextAttributes = @{ NSForegroundColorAttributeName : cell.textView.textColor,
                                        NSUnderlineStyleAttributeName : @(NSUnderlineStyleSingle | NSUnderlinePatternSolid) };
  
  return cell;
}

- (CGFloat)collectionView:(JSQMessagesCollectionView *)collectionView
                   layout:(JSQMessagesCollectionViewFlowLayout *)collectionViewLayout heightForMessageBubbleTopLabelAtIndexPath:(NSIndexPath *)indexPath
{
  /**
   *  iOS7-style sender name labels
   */
  JSQMessage *currentMessage = [data.messages objectAtIndex:indexPath.item];
  if ([[currentMessage senderId] isEqualToString:self.senderId]) {
    return 0.0f;
  }
  
  if (indexPath.item - 1 > 0) {
    JSQMessage *previousMessage = [data.messages objectAtIndex:indexPath.item - 1];
    if ([[previousMessage senderId] isEqualToString:[currentMessage senderId]]) {
      return 0.0f;
    }
  }
  
  return kJSQMessagesCollectionViewCellLabelHeightDefault;
}

- (CGFloat)collectionView:(JSQMessagesCollectionView *)collectionView
                   layout:(JSQMessagesCollectionViewFlowLayout *)collectionViewLayout heightForCellBottomLabelAtIndexPath:(NSIndexPath *)indexPath {
  return 0.0f;
}

@end
