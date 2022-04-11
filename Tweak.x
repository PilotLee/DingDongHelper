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


@interface _TtC12neighborhood20FillOrderPaymentView : UIView
- (void)btnClick;
@end

// 递归触发买菜事件
%hook _TtC12neighborhood20FillOrderPaymentView
- (void)btnClick {
	%orig;
	__weak typeof(self) weakSelf = self;
	float f = (float)(arc4random()%10) / 1000 ;
	dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
		[weakSelf btnClick];
	});
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
