//
// Copyright 2009-2010 Facebook
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//    http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//

#import "Three20/TTTableItem.h"

#import "Three20/TTCorePreprocessorMacros.h"
#import "Three20/TTGlobalStyle.h"

#import "Three20/TTTableItemCell.h"

// /-----------------------------\
// | Title title title title...  |
// | Subtitle subtitle subtit... |
// | Message message message mes |
// | sage message message mes... |
// \-----------------------------/
NSString* kTableItemTitleKey              = @"title";
NSString* kTableItemSubtitleKey           = @"subtitle";
NSString* kTableItemMessageKey            = @"message";

// /-----------------------------\
// | Caption:                    |
// \-----------------------------/
NSString* kTableItemCaptionKey            = @"caption";

// The URL to navigate to upon tapping the row
NSString* kTableItemURLPathKey            = @"urlPath";

// The URL to navigate to upon tapping the accessory
NSString* kTableItemAccessoryURLPathKey   = @"accessoryURLPath";

// An image that is replaced by the URL image if/when it is downloaded.
NSString* kTableItemImageKey              = @"image";

// Where to download the image from
NSString* kTableItemImageURLPathKey       = @"imageURLPath";

// Styling applied to the image (here's where you can set borders,
// padding, size, etc...)
NSString* kTableItemImageStyleKey         = @"imageStyle";

// A BOOL that states whether or not the image is right-aligned.
NSString* kTableItemImageRightAlignedKey  = @"imageRightAligned";

// /-----------------------------\
// |                   timestamp |
// | Text text text text text te |
// | xt text text text text text |
// \-----------------------------/
NSString* kTableItemTimestampKey          = @"timestamp";

// A control as seen in the Preferences app
NSString* kTableItemControlKey            = @"control";

// Anything, really
NSString* kTableItemViewKey               = @"view";

// A TTStyledText object
NSString* kTableItemStyledTextKey         = @"styledText";

// A TTTableStyleSheet object
NSString* kTableItemStyleSheetKey         = @"styleSheet";

static const CGFloat kDefaultStyledTextPadding = 6;

///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
@implementation TTTableItem

@synthesize userInfo = _userInfo;


///////////////////////////////////////////////////////////////////////////////////////////////////
+ (id)item {
  return [[[self alloc] init] autorelease];
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (TTTableItem*)applyUserInfo:(id)userInfo {
  self.userInfo = userInfo;
  return self;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)dealloc {
  TT_RELEASE_SAFELY(_userInfo);

  [super dealloc];
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (Class)cellClass {
  return nil;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (id)initWithCoder:(NSCoder*)decoder {
  return [self init];
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)encodeWithCoder:(NSCoder*)encoder {
}


@end


#pragma mark -
///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
@implementation TTTableLinkedItem

@synthesize urlPath           = _urlPath;
@synthesize accessoryURLPath  = _accessoryURLPath;


///////////////////////////////////////////////////////////////////////////////////////////////////
- (TTTableLinkedItem*)applyURLPath:(NSString*)urlPath {
  self.urlPath = urlPath;
  return self;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (TTTableLinkedItem*)applyAccessoryURLPath:(NSString*)accessoryURLPath {
  self.accessoryURLPath = accessoryURLPath;
  return self;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)dealloc {
  TT_RELEASE_SAFELY(_urlPath);
  TT_RELEASE_SAFELY(_accessoryURLPath);

  [super dealloc];
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (id)initWithCoder:(NSCoder*)decoder {
  if (self = [super initWithCoder:decoder]) {
    self.urlPath          = [decoder decodeObjectForKey:kTableItemURLPathKey];
    self.accessoryURLPath = [decoder decodeObjectForKey:kTableItemAccessoryURLPathKey];
  }
  return self;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)encodeWithCoder:(NSCoder*)encoder {
  [super encodeWithCoder:encoder];
  if (nil != self.urlPath) {
    [encoder encodeObject:self.urlPath forKey:kTableItemURLPathKey];
  }
  if (nil != self.accessoryURLPath) {
    [encoder encodeObject:self.accessoryURLPath forKey:kTableItemAccessoryURLPathKey];
  }
}


@end


#pragma mark -
///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
@implementation TTTableImageLinkedItem

@synthesize image             = _image;
@synthesize imageURLPath      = _imageURLPath;
@synthesize imageStyle        = _imageStyle;
@synthesize imageRightAligned = _imageRightAligned;


///////////////////////////////////////////////////////////////////////////////////////////////////
- (TTTableImageLinkedItem*)applyImage:(UIImage*)image {
  self.image = image;
  return self;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (TTTableImageLinkedItem*)applyImageURLPath:(NSString*)imageURLPath {
  self.imageURLPath = imageURLPath;
  return self;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (TTTableImageLinkedItem*)applyImageStyle:(TTStyle*)imageStyle {
  self.imageStyle = imageStyle;
  return self;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (TTTableImageLinkedItem*)applyImageRightAligned:(BOOL)imageRightAligned {
  self.imageRightAligned = imageRightAligned;
  return self;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)dealloc {
  TT_RELEASE_SAFELY(_image);
  TT_RELEASE_SAFELY(_imageURLPath);
  TT_RELEASE_SAFELY(_imageStyle);

  [super dealloc];
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (id)initWithCoder:(NSCoder*)decoder {
  if (self = [super initWithCoder:decoder]) {
    self.imageURLPath       = [decoder decodeObjectForKey:kTableItemImageURLPathKey];
    self.imageRightAligned  = [decoder decodeBoolForKey:kTableItemImageRightAlignedKey];
  }
  return self;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)encodeWithCoder:(NSCoder*)encoder {
  [super encodeWithCoder:encoder];
  if (nil != self.imageURLPath) {
    [encoder encodeObject:self.imageURLPath forKey:kTableItemImageURLPathKey];
  }
  [encoder encodeBool:self.imageRightAligned forKey:kTableItemImageRightAlignedKey];
}


@end


#pragma mark -
///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
@implementation TTTableTitleItem

@synthesize title = _title;


///////////////////////////////////////////////////////////////////////////////////////////////////
- (TTTableTitleItem*)applyTitle:(NSString*)title {
  self.title = title;
  return self;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)dealloc {
  TT_RELEASE_SAFELY(_title);

  [super dealloc];
}


///////////////////////////////////////////////////////////////////////////////////////////////////
-(Class)cellClass {
  return [TTTableTitleItemCell class];
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (id)initWithCoder:(NSCoder*)decoder {
  if (self = [super initWithCoder:decoder]) {
    self.title = [decoder decodeObjectForKey:kTableItemTitleKey];
  }
  return self;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)encodeWithCoder:(NSCoder*)encoder {
  [super encodeWithCoder:encoder];
  if (self.title) {
    [encoder encodeObject:self.title forKey:kTableItemTitleKey];
  }
}


@end


#pragma mark -
///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
@implementation TTTableSubtitleItem

@synthesize subtitle = _subtitle;


///////////////////////////////////////////////////////////////////////////////////////////////////
- (TTTableSubtitleItem*)applySubtitle:(NSString*)subtitle {
  self.subtitle = subtitle;
  return self;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)dealloc {
  TT_RELEASE_SAFELY(_subtitle);

  [super dealloc];
}


///////////////////////////////////////////////////////////////////////////////////////////////////
-(Class)cellClass {
  return [TTTableSubtitleItemCell class];
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (id)initWithCoder:(NSCoder*)decoder {
  if (self = [super initWithCoder:decoder]) {
    self.subtitle = [decoder decodeObjectForKey:kTableItemSubtitleKey];
  }
  return self;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)encodeWithCoder:(NSCoder*)encoder {
  [super encodeWithCoder:encoder];
  if (self.subtitle) {
    [encoder encodeObject:self.subtitle forKey:kTableItemSubtitleKey];
  }
}


@end


#pragma mark -
///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
@implementation TTTableMessageItem

@synthesize message   = _message;
@synthesize timestamp = _timestamp;


///////////////////////////////////////////////////////////////////////////////////////////////////
- (TTTableMessageItem*)applyMessage:(NSString*)message {
  self.message = message;
  return self;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (TTTableMessageItem*)applyTimestamp:(NSDate*)timestamp {
  self.timestamp = timestamp;
  return self;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)dealloc {
  TT_RELEASE_SAFELY(_message);
  TT_RELEASE_SAFELY(_timestamp);

  [super dealloc];
}


///////////////////////////////////////////////////////////////////////////////////////////////////
-(Class)cellClass {
  return [TTTableMessageItemCell class];
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (id)initWithCoder:(NSCoder*)decoder {
  if (self = [super initWithCoder:decoder]) {
    self.message    = [decoder decodeObjectForKey:kTableItemMessageKey];
    self.timestamp  = [decoder decodeObjectForKey:kTableItemTimestampKey];
  }
  return self;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)encodeWithCoder:(NSCoder*)encoder {
  [super encodeWithCoder:encoder];
  if (self.message) {
    [encoder encodeObject:self.message forKey:kTableItemMessageKey];
  }
  if (self.timestamp) {
    [encoder encodeObject:self.timestamp forKey:kTableItemTimestampKey];
  }
}


@end


#pragma mark -
///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
@implementation TTTableCaptionItem

@synthesize caption = _caption;
@synthesize title   = _title;


///////////////////////////////////////////////////////////////////////////////////////////////////
- (TTTableCaptionItem*)applyCaption:(NSString*)caption {
  self.caption = caption;
  return self;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (TTTableCaptionItem*)applyTitle:(NSString*)title {
  self.title = title;
  return self;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)dealloc {
  TT_RELEASE_SAFELY(_caption);
  TT_RELEASE_SAFELY(_title);

  [super dealloc];
}


///////////////////////////////////////////////////////////////////////////////////////////////////
-(Class)cellClass {
  return [TTTableCaptionItemCell class];
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (id)initWithCoder:(NSCoder*)decoder {
  if (self = [super initWithCoder:decoder]) {
    self.caption  = [decoder decodeObjectForKey:kTableItemCaptionKey];
    self.title    = [decoder decodeObjectForKey:kTableItemTitleKey];
  }
  return self;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)encodeWithCoder:(NSCoder*)encoder {
  [super encodeWithCoder:encoder];
  if (self.caption) {
    [encoder encodeObject:self.caption forKey:kTableItemCaptionKey];
  }
  if (self.title) {
    [encoder encodeObject:self.title forKey:kTableItemTitleKey];
  }
}


@end


#pragma mark -
///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
@implementation TTTableSummaryItem

@synthesize title = _title;


///////////////////////////////////////////////////////////////////////////////////////////////////
- (TTTableSummaryItem*)applyTitle:(NSString*)title {
  self.title = title;
  return self;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)dealloc {
  TT_RELEASE_SAFELY(_title);

  [super dealloc];
}


///////////////////////////////////////////////////////////////////////////////////////////////////
-(Class)cellClass {
  return [TTTableSummaryItemCell class];
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (id)initWithCoder:(NSCoder*)decoder {
  if (self = [super initWithCoder:decoder]) {
    self.title = [decoder decodeObjectForKey:kTableItemTitleKey];
  }
  return self;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)encodeWithCoder:(NSCoder*)encoder {
  [super encodeWithCoder:encoder];
  if (self.title) {
    [encoder encodeObject:self.title forKey:kTableItemTitleKey];
  }
}


@end


#pragma mark -
///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
@implementation TTTableLinkItem


///////////////////////////////////////////////////////////////////////////////////////////////////
-(Class)cellClass {
  return [TTTableLinkItemCell class];
}


@end


#pragma mark -
///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
@implementation TTTableButtonItem

@synthesize title = _title;


///////////////////////////////////////////////////////////////////////////////////////////////////
- (TTTableButtonItem*)applyTitle:(NSString*)title {
  self.title = title;
  return self;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)dealloc {
  TT_RELEASE_SAFELY(_title);

  [super dealloc];
}


///////////////////////////////////////////////////////////////////////////////////////////////////
-(Class)cellClass {
  return [TTTableButtonItemCell class];
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (id)initWithCoder:(NSCoder*)decoder {
  if (self = [super initWithCoder:decoder]) {
    self.title = [decoder decodeObjectForKey:kTableItemTitleKey];
  }
  return self;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)encodeWithCoder:(NSCoder*)encoder {
  [super encodeWithCoder:encoder];
  if (self.title) {
    [encoder encodeObject:self.title forKey:kTableItemTitleKey];
  }
}


@end


#pragma mark -
///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
@implementation TTTableMoreButtonItem

@synthesize model     = _model;
@synthesize subtitle  = _subtitle;
@synthesize isLoading = _isLoading;

- (id)init {
  if (self = [super init]) {
    _isLoading = NO;
    _model = nil;
  }
  return self;
}

- (void)dealloc {
  self.model = nil;
  [super dealloc];
}

+ (id)itemWithProperties:(NSDictionary*)properties {
  return [[[self alloc] initWithProperties:properties] autorelease];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (TTTableMoreButtonItem*)applySubtitle:(NSString*)subtitle {
  self.subtitle = subtitle;
  return self;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (TTTableMoreButtonItem*)applyIsLoading:(BOOL)isLoading {
  self.isLoading = isLoading;
  return self;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)dealloc {
  TT_RELEASE_SAFELY(_subtitle);

  [super dealloc];
}


///////////////////////////////////////////////////////////////////////////////////////////////////
-(Class)cellClass {
  return [TTTableMoreButtonItemCell class];
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (id)initWithCoder:(NSCoder*)decoder {
  if (self = [super initWithCoder:decoder]) {
    self.subtitle = [decoder decodeObjectForKey:kTableItemSubtitleKey];
  }
  return self;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)encodeWithCoder:(NSCoder*)encoder {
  [super encodeWithCoder:encoder];
  if (self.subtitle) {
    [encoder encodeObject:self.subtitle forKey:kTableItemSubtitleKey];
  }
}


@end


#pragma mark -
///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
@implementation TTTableActivityItem

@synthesize title = _title;


///////////////////////////////////////////////////////////////////////////////////////////////////
- (TTTableActivityItem*)applyTitle:(NSString*)title {
  self.title = title;
  return self;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)dealloc {
  TT_RELEASE_SAFELY(_title);
  [super dealloc];
}


///////////////////////////////////////////////////////////////////////////////////////////////////
-(Class)cellClass {
  return [TTTableActivityItemCell class];
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (id)initWithCoder:(NSCoder*)decoder {
  if (self = [super initWithCoder:decoder]) {
    self.title = [decoder decodeObjectForKey:kTableItemTitleKey];
  }
  return self;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)encodeWithCoder:(NSCoder*)encoder {
  [super encodeWithCoder:encoder];
  if (self.title) {
    [encoder encodeObject:self.title forKey:kTableItemTitleKey];
  }
}


@end


#pragma mark -
///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
@implementation TTTableStyledTextItem

@synthesize styledText  = _styledText;
@synthesize margin      = _margin;
@synthesize padding     = _padding;


///////////////////////////////////////////////////////////////////////////////////////////////////
- (id)init {
  if( self = [super init] ) {
    _margin = UIEdgeInsetsMake(
      kDefaultStyledTextPadding,
      kDefaultStyledTextPadding,
      kDefaultStyledTextPadding,
      kDefaultStyledTextPadding);
  }

  return self;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (TTTableStyledTextItem*)applyStyledText:(TTStyledText*)styledText {
  self.styledText = styledText;
  return self;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (TTTableStyledTextItem*)applyMargin:(UIEdgeInsets)margin {
  self.margin = margin;
  return self;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (TTTableStyledTextItem*)applyPadding:(UIEdgeInsets)padding {
  self.padding = padding;
  return self;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)dealloc {
  TT_RELEASE_SAFELY(_styledText);

  [super dealloc];
}


///////////////////////////////////////////////////////////////////////////////////////////////////
-(Class)cellClass {
  return [TTTableStyledTextItemCell class];
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (id)initWithCoder:(NSCoder*)decoder {
  if (self = [super initWithCoder:decoder]) {
    self.styledText = [decoder decodeObjectForKey:kTableItemStyledTextKey];
  }
  return self;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)encodeWithCoder:(NSCoder*)encoder {
  [super encodeWithCoder:encoder];
  if (self.styledText) {
    [encoder encodeObject:self.styledText forKey:kTableItemStyledTextKey];
  }
}


@end


#pragma mark -
///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
@implementation TTTableControlItem

@synthesize caption = _caption;
@synthesize control = _control;


///////////////////////////////////////////////////////////////////////////////////////////////////
- (TTTableControlItem*)applyCaption:(NSString*)caption {
  self.caption = caption;
  return self;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (TTTableControlItem*)applyControl:(UIControl*)control {
  self.control = control;
  return self;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)dealloc {
  TT_RELEASE_SAFELY(_caption);
  TT_RELEASE_SAFELY(_control);

  [super dealloc];
}


///////////////////////////////////////////////////////////////////////////////////////////////////
-(Class)cellClass {
  return [TTTableControlItemCell class];
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (id)initWithCoder:(NSCoder*)decoder {
  if (self = [super initWithCoder:decoder]) {
    self.caption = [decoder decodeObjectForKey:kTableItemCaptionKey];
    self.control = [decoder decodeObjectForKey:kTableItemControlKey];
  }
  return self;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)encodeWithCoder:(NSCoder*)encoder {
  [super encodeWithCoder:encoder];
  if (self.caption) {
    [encoder encodeObject:self.caption forKey:kTableItemCaptionKey];
  }
  if (self.control) {
    [encoder encodeObject:self.control forKey:kTableItemControlKey];
  }
}


@end


#pragma mark -
///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
@implementation TTTableLongTextItem

@synthesize text = _text;


///////////////////////////////////////////////////////////////////////////////////////////////////
- (TTTableLongTextItem*)applyText:(NSString*)text {
  self.text = text;
  return self;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)dealloc {
  TT_RELEASE_SAFELY(_text);

  [super dealloc];
}


///////////////////////////////////////////////////////////////////////////////////////////////////
-(Class)cellClass {
  return [TTTableLongTextItemCell class];
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (id)initWithCoder:(NSCoder*)decoder {
  if (self = [super initWithCoder:decoder]) {
    self.text = [decoder decodeObjectForKey:kTableItemMessageKey];
  }
  return self;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)encodeWithCoder:(NSCoder*)encoder {
  [super encodeWithCoder:encoder];
  if (self.text) {
    [encoder encodeObject:self.text forKey:kTableItemMessageKey];
  }
}

@end


/* TODO: CLEANUP


#pragma mark -
///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
@implementation TTTableImageItem

@synthesize imageURL      = _imageURL;
@synthesize defaultImage  = _defaultImage;
@synthesize imageStyle    = _imageStyle;

+ (id)itemWithProperties:(NSDictionary*)properties {
  return [[[self alloc] initWithProperties:properties] autorelease];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark NSObject

- (id)initWithProperties:(NSDictionary*)properties {
  if( self = [super initWithProperties:properties] ) {
    self.imageURL     = [properties objectForKey:kTableItemImageURLKey];
    self.defaultImage = [properties objectForKey:kTableItemDefaultImageKey];
    self.imageStyle   = [properties objectForKey:kTableItemImageStyleKey];
  }

  return self;
}

- (void)dealloc {
  TT_RELEASE_SAFELY(_imageURL);
  TT_RELEASE_SAFELY(_defaultImage);
  TT_RELEASE_SAFELY(_imageStyle);
  [super dealloc];
}

-(Class)cellClass {
  return [TTTableImageItemCell class];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark NSCoding

- (id)initWithCoder:(NSCoder*)decoder {
  if (self = [super initWithCoder:decoder]) {
    self.imageURL = [decoder decodeObjectForKey:kTableItemImageURLKey];
  }
  return self;
}

- (void)encodeWithCoder:(NSCoder*)encoder {
  [super encodeWithCoder:encoder];
  if (self.imageURL) {
    [encoder encodeObject:self.imageURL forKey:kTableItemImageURLKey];
  }
}
@end


#pragma mark -
///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
@implementation TTTableRightImageItem
@end


#pragma mark -
///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
@implementation TTTableGrayTextItem
@end


#pragma mark -
///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
@implementation TTTableViewItem

@synthesize caption = _caption;
@synthesize view    = _view;

+ (id)itemWithProperties:(NSDictionary*)properties {
  return [[[self alloc] initWithProperties:properties] autorelease];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark NSObject

- (id)initWithProperties:(NSDictionary*)properties {
  if( self = [super init] ) {
    self.caption  = [properties objectForKey:kTableItemCaptionKey];
    self.view     = [properties objectForKey:kTableItemViewKey];
  }

  return self;
}

- (void)dealloc {
  TT_RELEASE_SAFELY(_caption);
  TT_RELEASE_SAFELY(_view);
  [super dealloc];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark NSCoding

- (id)initWithCoder:(NSCoder*)decoder {
  if (self = [super initWithCoder:decoder]) {
    self.caption = [decoder decodeObjectForKey:kTableItemCaptionKey];
    self.view = [decoder decodeObjectForKey:kTableItemViewKey];
  }
  return self;
}

- (void)encodeWithCoder:(NSCoder*)encoder {
  [super encodeWithCoder:encoder];
  if (self.caption) {
    [encoder encodeObject:self.caption forKey:kTableItemCaptionKey];
  }
  if (self.view) {
    [encoder encodeObject:self.view forKey:kTableItemViewKey];
  }
}

@end
*/
