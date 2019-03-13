

#import <UIKit/UIKit.h>
#import "PopoverAction.h"

UIKIT_EXTERN CGFloat const PopoverViewCellHorizontalMargin; ///< 水平间距边距
UIKIT_EXTERN CGFloat const PopoverViewCellVerticalMargin; ///< 垂直边距
UIKIT_EXTERN CGFloat const PopoverViewCellTitleLeftEdge; ///< 标题左边边距

@interface PopoverViewCell : UITableViewCell

@property (nonatomic, assign) PopoverViewStyle style;

/*! @brief 标题字体 */
@property (nonatomic, strong) UIFont *titleFont;

/*! @brief 标题颜色 */
@property (nonatomic, strong) UIColor *textColor;

/*! @brief 底部线条颜色 */
@property (nonatomic, strong) UIColor *bottomLineColor;

- (void)setAction:(PopoverAction *)action;

- (void)showBottomLine:(BOOL)show;

@end
