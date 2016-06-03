//
//  EGORefreshTableHeaderView.m
//  Demo
//
//  Created by Devin Doty on 10/14/09October14.
//  Copyright 2009 enormego. All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

#import "EGORefreshTableHeaderView.h"

@interface EGORefreshTableHeaderView (Private)

@end

@implementation EGORefreshTableHeaderView

@synthesize delegate=_delegate;


- (id)initWithFrame:(CGRect)frame arrowImageName:(NSString *)arrow textColor:(UIColor *)textColor  {
    if((self = [super initWithFrame:frame]))
    {
		
		self.autoresizingMask = UIViewAutoresizingFlexibleWidth;
//		self.backgroundColor = [UIColor colorWithRed:0Xfc/255.0 green:0Xfc/255.0 blue:0Xfc/255.0 alpha:1.0f];
        self.backgroundColor = [UIColor UIViewBackGroundColor];

		UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, frame.size.height - 30.0f, self.frame.size.width, 20.0f)];
		label.autoresizingMask = UIViewAutoresizingFlexibleWidth;
		label.font = [UIFont systemFontOfSize:12.0f];
		label.textColor = textColor;
		label.shadowColor = [UIColor colorWithWhite:0.9f alpha:1.0f];
		label.shadowOffset = CGSizeMake(0.0f, 1.0f);
		label.backgroundColor = [UIColor clearColor];
		label.textAlignment = NSTextAlignmentCenter;
		[self addSubview:label];
		_lastUpdatedLabel=label;
		[label release];
		
		label = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, frame.size.height - 48.0f, self.frame.size.width, 20.0f)];
		label.autoresizingMask = UIViewAutoresizingFlexibleWidth;
		label.font = [UIFont boldSystemFontOfSize:13.0f];
        label.font = [UIFont systemFontOfSize:13.0f];
		label.textColor = textColor;
		label.shadowColor = [UIColor colorWithWhite:0.9f alpha:1.0f];
		label.shadowOffset = CGSizeMake(0.0f, 1.0f);
		label.backgroundColor = [UIColor clearColor];
		label.textAlignment = NSTextAlignmentCenter;
		[self addSubview:label];
		_statusLabel=label;
		[label release];
        
        
//        CGRect migframe = CGRectMake(0,frame.size.height-[UIImage imageNamed:@"che.gif"].size.height,0,0);
//        migframe.size = [UIImage imageNamed:@"che.gif"].size;
//        // 读取gif图片数据
//        NSData *gif = [NSData dataWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"che" ofType:@"gif"]];
//        // view生成
//        UIWebView *webView = [[UIWebView alloc] initWithFrame:migframe];
//        webView.userInteractionEnabled = NO;//用户不可交互
//        [webView loadData:gif MIMEType:@"image/gif" textEncodingName:nil baseURL:nil];
//        [self addSubview:webView];
		
//		CALayer *layer = [CALayer layer];
//		layer.frame = CGRectMake(25.0f, frame.size.height - 65.0f, 30.0f, 55.0f);
//		layer.contentsGravity = kCAGravityResizeAspect;
//		layer.contents = (id)[UIImage imageNamed:arrow].CGImage;
//		
//#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 40000
//		if ([[UIScreen mainScreen] respondsToSelector:@selector(scale)]) {
//			layer.contentsScale = [[UIScreen mainScreen] scale];
//		}
//#endif
//		[[self layer] addSublayer:layer];
//		_arrowImage=layer;
//		
//		UIActivityIndicatorView *view = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
//		view.frame = CGRectMake(25.0f, frame.size.height - 38.0f, 20.0f, 20.0f);
//		[self addSubview:view];
//		_activityView = view;
//		[view release];
		
        ////custom
        UIActivityIndicatorView *view = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        view.frame = CGRectMake((SCREEN_WIDTH - 20.0f) / 2.0f, _statusLabel.top - 5.0f, 20.0f, 20.0f);
        [self addSubview:view];
        _activityView = view;
        [view release];
        ////
		[self setState:EGOOPullRefreshNormal];
    }
	
    return self;
	
}

- (id)initWithFrame:(CGRect)frame  {
  return [self initWithFrame:frame arrowImageName:@"blueArrow" textColor:TEXT_COLOR];
}

#pragma mark -
#pragma mark Setters

- (void)refreshLastUpdatedDate {
	
	if ([_delegate respondsToSelector:@selector(egoRefreshTableDataSourceLastUpdated:)]) {
		
		NSDate *date = [_delegate egoRefreshTableDataSourceLastUpdated:self];
		
		[NSDateFormatter setDefaultFormatterBehavior:NSDateFormatterBehaviorDefault];
		NSDateFormatter *dateFormatter = [[[NSDateFormatter alloc] init] autorelease];
		[dateFormatter setDateStyle:NSDateFormatterShortStyle];
		[dateFormatter setTimeStyle:NSDateFormatterShortStyle];

		_lastUpdatedLabel.text = [NSString stringWithFormat:L(@"最后刷新时间: %@"), [dateFormatter stringFromDate:date]];
		[[NSUserDefaults standardUserDefaults] setObject:_lastUpdatedLabel.text forKey:@"EGORefreshTableView_LastRefresh"];
		[[NSUserDefaults standardUserDefaults] synchronize];
		
	} else {
		
		_lastUpdatedLabel.text = nil;
		
	}

}

- (void)setState:(EGOPullRefreshState)aState{
    [_statusLabel setHidden: NO];
    [_activityView setHidden: YES];
	switch (aState) {
		case EGOOPullRefreshNormal:
			
			if (_state == EGOOPullRefreshPulling)
            {
				[CATransaction begin];
				[CATransaction setAnimationDuration:FLIP_ANIMATION_DURATION];
				_arrowImage.transform = CATransform3DIdentity;
				[CATransaction commit];
			}
			
			_statusLabel.text = L(@"往下拉刷新数据...");
			[_activityView stopAnimating];
			[CATransaction begin];
			[CATransaction setValue:(id)kCFBooleanTrue forKey:kCATransactionDisableActions]; 
			_arrowImage.hidden = NO;
			_arrowImage.transform = CATransform3DIdentity;
			[CATransaction commit];
			
			[self refreshLastUpdatedDate];
			
			break;
        case EGOOPullRefreshPulling:
            
            _statusLabel.text = L(@"释放刷新数据...");
            [CATransaction begin];
            [CATransaction setAnimationDuration:FLIP_ANIMATION_DURATION];
            _arrowImage.transform = CATransform3DMakeRotation((M_PI / 180.0) * 180.0f, 0.0f, 0.0f, 1.0f);
            [CATransaction commit];
            
            break;
		case EGOOPullRefreshLoading:
            [_statusLabel setHidden: YES];
            [_activityView setHidden: NO];
			_statusLabel.text = L(@"刷新中...");
			[_activityView startAnimating];
			[CATransaction begin];
			[CATransaction setValue:(id)kCFBooleanTrue forKey:kCATransactionDisableActions]; 
			_arrowImage.hidden = YES;
			[CATransaction commit];
			
			break;
        case EGOOPullRefreshOver:
            _statusLabel.text = L(@"刷新完成...");
            [_activityView startAnimating];
            [CATransaction begin];
            [CATransaction setValue:(id)kCFBooleanTrue forKey:kCATransactionDisableActions];
            _arrowImage.hidden = YES;
            [CATransaction commit];
            
            break;
		default:
			break;
	}
	
	_state = aState;
}


#pragma mark -
#pragma mark ScrollView Methods

- (void)egoRefreshScrollViewDidScroll:(UIScrollView *)scrollView {	
//	NSLog(@"egoRefreshScrollViewDidScroll scrollView.contentOffset.y= %f", scrollView.contentOffset.y);
	if (_state == EGOOPullRefreshLoading)
    {
		CGFloat offset = MAX(scrollView.contentOffset.y * -1, 0);
		offset = MIN(offset, 60);
		scrollView.contentInset = UIEdgeInsetsMake(offset, 0.0f, 0.0f, 0.0f);
	}
    else if (scrollView.isDragging)
    {
		BOOL _loading = NO;
		if ([_delegate respondsToSelector:@selector(egoRefreshTableDataSourceIsLoading:)])
        {
			_loading = [_delegate egoRefreshTableDataSourceIsLoading:self];
		}
		if (_state == EGOOPullRefreshPulling && scrollView.contentOffset.y > -65.0f && scrollView.contentOffset.y < 0.0f && !_loading)
        {
			[self setState:EGOOPullRefreshNormal];
		}
        else if (_state == EGOOPullRefreshNormal && scrollView.contentOffset.y < -65.0f && !_loading)
        {
			[self setState:EGOOPullRefreshPulling];
		}
		
		if (scrollView.contentInset.top != 0)
        {
			scrollView.contentInset = UIEdgeInsetsZero;
		}
		
	}
	
}

- (void)egoRefreshScrollViewDidEndDragging:(UIScrollView *)scrollView {
    //NSLog(@"egoRefreshScrollViewDidEndDragging scrollView.contentOffset.y= %f", scrollView.contentOffset.y);
	BOOL _loading = NO;
	if ([_delegate respondsToSelector:@selector(egoRefreshTableDataSourceIsLoading:)])
    {
		_loading = [_delegate egoRefreshTableDataSourceIsLoading:self];
	}
	if (scrollView.contentOffset.y <= - 65.0f && !_loading)
    {
		if ([_delegate respondsToSelector:@selector(egoRefreshTableDidTriggerRefresh:)])
        {
			[_delegate egoRefreshTableDidTriggerRefresh:EGORefreshHeader];
		}
		[self setState:EGOOPullRefreshLoading];
		[UIView beginAnimations:nil context:NULL];
		[UIView setAnimationDuration:0.2];
		scrollView.contentInset = UIEdgeInsetsMake(60.0f, 0.0f, 0.0f, 0.0f);
		[UIView commitAnimations];
	}
	
}

- (void)egoRefreshScrollViewDataSourceDidFinishedLoading:(UIScrollView *)scrollView{
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:.3];
	[scrollView setContentInset:UIEdgeInsetsMake(0.0f, 0.0f, 0.0f, 0.0f)];
	[UIView commitAnimations];
	[self setState:EGOOPullRefreshNormal];
}


#pragma mark -
#pragma mark Dealloc
- (void)dealloc {
	_delegate=nil;
	_activityView = nil;
	_statusLabel = nil;
	_arrowImage = nil;
	_lastUpdatedLabel = nil;
    [super dealloc];
}


@end
