

#import <UIKit/UIKit.h>

@class MyWaterflowLayout;

@protocol MyWaterflowLayoutDelegate <NSObject>

- (CGFloat)waterflowLayout:(MyWaterflowLayout *)waterflowLayout heightForWidth:(CGFloat)width atIndexPath:(NSIndexPath *)indexPath;

@end

@interface MyWaterflowLayout : UICollectionViewLayout

@property (nonatomic, assign) UIEdgeInsets sectionInset;

/** 每一列之间的间距 */
@property (nonatomic, assign) CGFloat columnMargin;

/** 每一行之间的间距 */
@property (nonatomic, assign) CGFloat rowMargin;

/** 显示多少列 */
@property (nonatomic, assign) int columnsCount;

@property (nonatomic, weak) id<MyWaterflowLayoutDelegate> delegate;

@end

