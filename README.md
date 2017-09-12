# KNHeadTensile


#### 没什么工作。 所以做了一个小demo 简单实现可拉伸头部

### 效果图

![](https://github.com/krystalName/KNHeadTensile/blob/master/HeadTensile.gif)


### 主要代码就这么一段
```objc
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat yOffset = scrollView.contentOffset.y;
    
    if (yOffset > 0) {
        
        self.headImageView.frame  = ({
            CGRect frame = _originalRect;
            frame.origin.y = _originalRect.origin.y - yOffset;
            frame;
        });
    }else{
        
        self.headImageView.frame = ({
            CGRect frame = _originalRect;
            frame.size.height = _originalRect.size.height - yOffset;
            frame.size.width = frame.size.height/ration;
            frame.origin.x = _originalRect.origin.x  - (frame.size.width - _originalRect.size.width)/2;
            frame;
        });
    }
}

```
