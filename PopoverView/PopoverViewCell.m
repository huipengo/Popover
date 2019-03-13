

#import "PopoverViewCell.h"

// extern
CGFloat const PopoverViewCellHorizontalMargin = 15.f; ///< 水平边距
CGFloat const PopoverViewCellVerticalMargin   = 3.f; ///< 垂直边距
CGFloat const PopoverViewCellTitleLeftEdge    = 8.f; ///< 标题左边边距

@interface PopoverViewCell ()

@property (nonatomic, strong) UIButton *button;
@property (nonatomic, weak) UIView *bottomLine;

@end

@implementation PopoverViewCell
@synthesize titleFont = _titleFont, textColor = _textColor, bottomLineColor = _bottomLineColor;

#pragma mark - Life Cycle
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (!(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])) return nil;
    self.backgroundColor = [UIColor clearColor];
    self.contentView.backgroundColor = self.backgroundColor;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    // initialize
    [self initialize];
    
    return self;
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated {
    [super setHighlighted:highlighted animated:animated];
    if (highlighted) {
        self.backgroundColor = (_style == PopoverViewStyleDefault) ? [UIColor colorWithRed:236.0f/255.0f green:236.0f/255.0f blue:236.0f/255.0f alpha:1.0f] : [UIColor colorWithRed:0.23f green:0.23f blue:0.23f alpha:1.0f];
    } else {
        [UIView animateWithDuration:0.3f animations:^{
            self.backgroundColor = [UIColor clearColor];
        }];
    }
}

#pragma mark - Setter
- (void)setStyle:(PopoverViewStyle)style {
    _style = style;
    
    _bottomLine.backgroundColor = self.bottomLineColor;
    [_button setTitleColor:self.textColor forState:UIControlStateNormal];
}

#pragma mark - Private
// 初始化
- (void)initialize {
    // UI
    [self.contentView addSubview:self.button];
    
    // Constraint
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-margin-[_button]-margin-|" options:kNilOptions metrics:@{@"margin" : @(PopoverViewCellHorizontalMargin)} views:NSDictionaryOfVariableBindings(_button)]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-margin-[_button]-margin-|" options:kNilOptions metrics:@{@"margin" : @(PopoverViewCellVerticalMargin)} views:NSDictionaryOfVariableBindings(_button)]];
    
    // 底部线条
    UIView *bottomLine = [[UIView alloc] init];
    bottomLine.backgroundColor = self.bottomLineColor;
    bottomLine.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addSubview:bottomLine];
    _bottomLine = bottomLine;
    
    // Constraint
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[bottomLine]|" options:kNilOptions metrics:nil views:NSDictionaryOfVariableBindings(bottomLine)]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[bottomLine(lineHeight)]|" options:kNilOptions metrics:@{@"lineHeight" : @(1/[UIScreen mainScreen].scale)} views:NSDictionaryOfVariableBindings(bottomLine)]];
}

- (UIButton *)button {
    if (!_button) {
        _button = [UIButton buttonWithType:UIButtonTypeCustom];
        _button.userInteractionEnabled = NO; // has no use for UserInteraction.
        _button.translatesAutoresizingMaskIntoConstraints = NO;
        _button.titleLabel.font = self.titleFont;
        _button.backgroundColor = self.contentView.backgroundColor;
        _button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [_button setTitleColor:self.textColor forState:UIControlStateNormal];
    }
    return _button;
}

#pragma mark - Public
- (void)setTitleFont:(UIFont *)titleFont {
    _titleFont = titleFont;
    
    self.button.titleLabel.font = titleFont;
}

- (void)setTextColor:(UIColor *)textColor {
    _textColor = textColor;
    
    [_button setTitleColor:textColor forState:UIControlStateNormal];
}

- (void)setBottomLineColor:(UIColor *)bottomLineColor {
    _bottomLineColor = bottomLineColor;
    
    _bottomLine.backgroundColor = bottomLineColor;
}

- (void)setAction:(PopoverAction *)action {
    [_button setImage:action.image forState:UIControlStateNormal];
    [_button setTitle:action.title forState:UIControlStateNormal];
    _button.titleEdgeInsets = action.image ? UIEdgeInsetsMake(0, PopoverViewCellTitleLeftEdge, 0, -PopoverViewCellTitleLeftEdge) : UIEdgeInsetsZero;
}

- (void)showBottomLine:(BOOL)show {
    _bottomLine.hidden = !show;
}

@end
