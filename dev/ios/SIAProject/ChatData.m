#import "ChatData.h"
#import "ChatGroupViewController.h"

#import <JSQMessagesViewController/JSQMessagesBubbleImageFactory.h>

@implementation ChatData

- (instancetype)init
{
  self = [super init];
  if (self) {
    self.messages = [NSMutableArray new];
    
    self.avatars = @{};
    
    
    self.users = @{};
    
    JSQMessagesBubbleImageFactory *bubbleFactory = [[JSQMessagesBubbleImageFactory alloc] init];
    
    self.outgoingBubbleImageData = [bubbleFactory outgoingMessagesBubbleImageWithColor:[UIColor jsq_messageBubbleLightGrayColor]];
    self.incomingBubbleImageData = [bubbleFactory incomingMessagesBubbleImageWithColor:[UIColor jsq_messageBubbleGreenColor]];
  }
  
  return self;
}

@end
