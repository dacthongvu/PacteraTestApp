#import "AsyncImageView.h"

@implementation AsyncImageView
@synthesize imageUrl, progressIndicator, connection, data, delegate, userData, progressIndicatorStyle;

-(id) initWithFrame:(CGRect)frame ImageUrl:(NSURL*) url{
    if (self = [super initWithFrame:frame]){
        self.imageUrl = url;
        [self startLoading];
    }
    return self;
}

-(void) startLoading{

    [self createProgressIndicator];
    [self.progressIndicator startAnimating];
    self.contentMode = UIViewContentModeScaleAspectFit;
    
    NSURLRequest* request = [NSURLRequest requestWithURL:self.imageUrl cachePolicy: NSURLRequestUseProtocolCachePolicy timeoutInterval: 3.0];
    self.connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
}

-(void) createProgressIndicator{
    int x, y, w, h;
    if (self.frame.size.width < 100){
        w = 20; h = 20; x = self.frame.size.width / 2 - 10; y = (self.frame.size.height / 2) - 10;
    }
    else{
        w = 40; h = 40; x = self.frame.size.width / 2 - 20; y = (self.frame.size.height / 2) - 20;
    }
    self.progressIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:self.progressIndicatorStyle];
    self.progressIndicator.frame = CGRectMake(x, y, w, h);
    [self addSubview:self.progressIndicator];
}

//the URL connection calls this repeatedly as data arrives
- (void)connection:(NSURLConnection *)theConnection didReceiveData:(NSData *)incrementalData {
	if (self.data==nil) { self.data = [[NSMutableData alloc] initWithCapacity:2048]; }
	[self.data appendData:incrementalData];
}

//the URL connection calls this once all the data has downloaded
- (void)connectionDidFinishLoading:(NSURLConnection*)theConnection {
    self.image = [UIImage imageWithData:self.data];
    
    [self.progressIndicator stopAnimating];
    if (delegate){
        [delegate didFinishLoadingImage:self.image UserData:self.userData];
    }
}

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"Asynch image load connection error: %@", error);
	[self.progressIndicator stopAnimating];
    self.image = [UIImage imageNamed:@"NoImage.png"];
    
    if (delegate){
        [delegate didFinishLoadingImage:nil UserData:nil];
    }
}

@end
