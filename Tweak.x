// See http://iphonedevwiki.net/index.php/Logos
#import <UIKit/UIKit.h>

@interface DDBaseCustomAlert:UIView
@end
@interface _TtC12neighborhood25FillOrderLimitedAlertView : DDBaseCustomAlert
- (id)initWithAlertType:(unsigned long long)arg1;
- (id)initWithCoder:(id)arg1;
- (id)init;
- (id)initWithFrame:(struct CGRect)arg1;
- (void)reloadBtnClick;
- (void)backToCartBtnClick;
- (void)onClickBackground;
- (void)dismissPicker;
- (void)onClickBackgroundView;
- (void)dismissWithRemove:(_Bool)arg1 complete:(id)arg2;
- (void)dismissWithComplete:(id)arg1;
- (void)dismissAlertWithComplete:(id)arg1;
@end
@interface OrderStockoutAlertView : DDBaseCustomAlert
@property(retain, nonatomic) UIButton *sureButton;
- (void)setupSubviews;
@end

//自动确认支付
%hook OrderStockoutAlertView
- (void)setupSubviews {
	%orig;
	[self.sureButton sendActionsForControlEvents:UIControlEventTouchUpInside];
}
%end


@interface _TtC12neighborhood20FillOrderPaymentView : UIView
- (void)btnClick;
- (void)addObserver;
- (void)onSystemVolumeChanged:(NSNotification *)notification;
@end

// 递归触发买菜事件
%hook _TtC12neighborhood20FillOrderPaymentView
static BOOL btn_selected = NO;
- (void)btnClick {
	%orig;
	__weak typeof(self) weakSelf = self;
	float f = (float)(arc4random()%10) / 1000 ;
	dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
		if (btn_selected) {
			[weakSelf btnClick];
		}
	});
}

// 监听音量进行开关触发
%new
-(void)systemVolumeDidChangeNoti:(NSNotification* )noti{
	if ([noti.name isEqualToString:@"AVSystemController_SystemVolumeDidChangeNotification"]) {
		NSDictionary *dic = noti.userInfo;
		float res = [dic[@"AVSystemController_AudioVolumeNotificationParameter"] floatValue];
		if (res == 1) {
			btn_selected = YES;
			[self btnClick];
		}else {
			btn_selected = NO;
		}
	}
}
%new

// 增加入口
- (void)addObserver{
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		[[NSNotificationCenter defaultCenter] addObserver:self
		selector:@selector(systemVolumeDidChangeNoti:) name:@"AVSystemController_SystemVolumeDidChangeNotification"
		object:nil];
		[[UIApplication sharedApplication] beginReceivingRemoteControlEvents];
	});
}

- (id)init {
	[self addObserver];
	return %orig;
}
%end

// 屏蔽网络不可用弹窗
%hook NetworkUnavailableView
- (id)init {
	return nil;
}
- (id)initWithFrame:(struct CGRect)arg1 {
	return nil;
}
%end

// 屏蔽超限弹窗
%hook _TtC12neighborhood25FillOrderLimitedAlertView
- (void)layoutSubviews {
	[self onClickBackground];
	[self onClickBackgroundView];
	[self dismissWithRemove:YES complete:^{}];
	[self dismissWithComplete:^{}];
	[self dismissAlertWithComplete:^{}];
%orig;
}
%end
