#import <UIKit/UIKit.h>
@protocol AsyncImageViewDelegate;
@interface AsyncImageView : UIImageView
@property (nonatomic, strong) UIActivityIndicatorView *progressIndicator;
@property (nonatomic, unsafe_unretained) UIActivityIndicatorViewStyle progressIndicatorStyle;
@property (nonatomic, strong) NSURL *imageUrl;
@property (nonatomic, strong) NSURLConnection *connection;
@property (nonatomic, strong) NSMutableData *data;
@property (nonatomic, unsafe_unretained) id<AsyncImageViewDelegate> delegate;
@property (nonatomic, strong) id userData;
-(id) initWithFrame:(CGRect)frame ImageUrl:(NSURL*) url;
-(void) createProgressIndicator;
-(void) startLoading;
@end

@protocol AsyncImageViewDelegate <NSObject>

-(void) didFinishLoadingImage:(UIImage*) image UserData:(id) userdata;

@end
