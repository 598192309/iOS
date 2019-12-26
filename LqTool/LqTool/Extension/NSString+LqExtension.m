//
//  NSString+LqExtension.m
//  LqTool
//
//  Created by lqq on 2019/12/20.
//  Copyright © 2019 lqq. All rights reserved.
//

#import "NSString+LqExtension.h"


@implementation NSString (LqExtension)

/**
 *  @brief  根据字符串的宽(或高)和字体的大小计算字符串的size
 *  @param  size 给定字符串的宽或高
 *  @param  font 字体属性
 *  @return 字符串的宽和高
 */
- (CGSize)lq_boundingRectWithSize:(CGSize)size font:(UIFont *)font;
{
    NSDictionary *attribute = @{NSFontAttributeName: font};
    
    CGSize reSize = [self boundingRectWithSize:size
                                       options:
                     NSStringDrawingTruncatesLastVisibleLine |
                     NSStringDrawingUsesLineFragmentOrigin |
                     NSStringDrawingUsesFontLeading
                                    attributes:attribute
                                       context:nil].size;
    
    return reSize;
}


/**
 根据字符串的宽(或高)和字体的大小,字体的行间距计算字符串的size

 @param size 字符串的宽(或高)
 @param font 字体的大小
 @param lineSpacing 字体的行间距
 @return 字符串的size
 */
- (CGSize)lq_boundingRectWithSize:(CGSize)size font:(UIFont *)font lineSpacing:(CGFloat)lineSpacing
{

    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:lineSpacing];//调整行间距
    NSDictionary *attrs = @{NSFontAttributeName:font,NSParagraphStyleAttributeName:paragraphStyle};
    CGSize reSize = [self boundingRectWithSize:size
                                       options:NSStringDrawingTruncatesLastVisibleLine |
                     NSStringDrawingUsesLineFragmentOrigin |
                     NSStringDrawingUsesFontLeading
                                    attributes:attrs
                                       context:nil].size;
    return reSize;
}

/**
 根据字符串的宽(或高)和属性计算字符串的size

 @param size 给定字符串的宽或高
 @param attr 字体属性
 @return 字符串的宽和高
 */
- (CGSize)lq_boundingRectWithSize:(CGSize)size attr:(NSDictionary *)attr {
    
    CGSize reSize = [self boundingRectWithSize:size
                                       options:
                     NSStringDrawingTruncatesLastVisibleLine |
                     NSStringDrawingUsesLineFragmentOrigin |
                     NSStringDrawingUsesFontLeading
                                    attributes:attr
                                       context:nil].size;
    
    return reSize;
}

/**
 判断字符串是否包含emoji表情
 
 @param string 字符串
 @return bool 值
 */
+ (BOOL)lq_stringContainsEmoji:(NSString *)string {
    __block BOOL returnValue = NO;
    
    [string enumerateSubstringsInRange:NSMakeRange(0, [string length])
                               options:NSStringEnumerationByComposedCharacterSequences
                            usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
                                const unichar high = [substring characterAtIndex: 0];
                                
                                // Surrogate pair (U+1D000-1F9FF)
                                if (0xD800 <= high && high <= 0xDBFF) {
                                    const unichar low = [substring characterAtIndex: 1];
                                    const int codepoint = ((high - 0xD800) * 0x400) + (low - 0xDC00) + 0x10000;
                                    
                                    if (0x1D000 <= codepoint && codepoint <= 0x1F9FF){
                                        returnValue = YES;
                                    }
                                    
                                    // Not surrogate pair (U+2100-27BF)
                                } else {
                                    if (0x2100 <= high && high <= 0x27BF){
                                        returnValue = YES;
                                    }
                                }
                            }];
    
    return returnValue;
}


+ (NSString *)lq_filterHTML:(NSString *)html
{
    NSScanner * scanner = [NSScanner scannerWithString:html];
    NSString * text = nil;
    while([scanner isAtEnd]==NO)
    {
        //找到标签的起始位置
        [scanner scanUpToString:@"<" intoString:nil];
        //找到标签的结束位置
        [scanner scanUpToString:@">" intoString:&text];
        //替换字符
        html = [html stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@>",text] withString:@""];
    }
    //    NSString * regEx = @"<([^>]*)>";
    //    html = [html stringByReplacingOccurrencesOfString:regEx withString:@""];
    return html;
}

//汉字的拼音
- (NSString *)lq_pinyin{
    NSMutableString *str = [self mutableCopy];
    CFStringTransform(( CFMutableStringRef)str, NULL, kCFStringTransformMandarinLatin, NO);
    CFStringTransform((CFMutableStringRef)str, NULL, kCFStringTransformStripDiacritics, NO);
    
    return [str stringByReplacingOccurrencesOfString:@" " withString:@""];
}


/**
 *  截取URL中的参数
 *
 *  @return NSMutableDictionary parameters
 */
- (NSMutableDictionary *)lq_getURLParameters {
    
    // 查找参数
    NSRange range = [self rangeOfString:@"?"];
    if (range.location == NSNotFound) {
        return nil;
    }
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    // 截取参数
    NSString *parametersString = [self substringFromIndex:range.location + 1];
    
    // 判断参数是单个参数还是多个参数
    if ([parametersString containsString:@"&"]) {
        
        // 多个参数，分割参数
        NSArray *urlComponents = [parametersString componentsSeparatedByString:@"&"];
        
        for (NSString *keyValuePair in urlComponents) {
            // 生成Key/Value
            NSArray *pairComponents = [keyValuePair componentsSeparatedByString:@"="];
            NSString *key = [pairComponents.firstObject stringByRemovingPercentEncoding];
            NSString *value = [pairComponents.lastObject stringByRemovingPercentEncoding];
            
            // Key不能为nil
            if (key == nil || value == nil) {
                continue;
            }
            
            id existValue = [params valueForKey:key];
            
            if (existValue != nil) {
                
                // 已存在的值，生成数组
                if ([existValue isKindOfClass:[NSArray class]]) {
                    // 已存在的值生成数组
                    NSMutableArray *items = [NSMutableArray arrayWithArray:existValue];
                    [items addObject:value];
                    
                    [params setValue:items forKey:key];
                } else {
                    
                    // 非数组
                    [params setValue:@[existValue, value] forKey:key];
                }
                
            } else {
                
                // 设置值
                [params setValue:value forKey:key];
            }
        }
    } else {
        // 单个参数
        
        // 生成Key/Value
        NSArray *pairComponents = [parametersString componentsSeparatedByString:@"="];
        
        // 只有一个参数，没有值
        if (pairComponents.count == 1) {
            return nil;
        }
        
        // 分隔值
        NSString *key = [pairComponents.firstObject stringByRemovingPercentEncoding];
        NSString *value = [pairComponents.lastObject stringByRemovingPercentEncoding];
        
        // Key不能为nil
        if (key == nil || value == nil) {
            return nil;
        }
        
        // 设置值
        [params setValue:value forKey:key];
    }
    
    return params;
}

/**
 *  设置行间距和字间距
 *
 *  @param lineSpace 行间距
 *  @param kern      字间距
 *
 *  @return 富文本
 */
-(NSAttributedString*)lq_getAttributedStringWithLineSpace:(CGFloat)lineSpace kern:(CGFloat)kern{
    NSMutableParagraphStyle*paragraphStyle = [NSMutableParagraphStyle new];
    //调整行间距
    paragraphStyle.lineSpacing= lineSpace;
    NSDictionary*attriDict =@{NSParagraphStyleAttributeName:paragraphStyle,NSKernAttributeName:@(kern)};
    NSMutableAttributedString*attributedString = [[NSMutableAttributedString   alloc]initWithString:self attributes:attriDict];
    
    return attributedString;
}

-(NSAttributedString*)lq_getAttributedStringWithLineSpace:(CGFloat)lineSpace kern:(CGFloat)kern aliment:(NSTextAlignment)alignment{
    NSMutableParagraphStyle*paragraphStyle = [NSMutableParagraphStyle new];
     //调整行间距
    paragraphStyle.lineSpacing= lineSpace;
    paragraphStyle.alignment = alignment;
    NSDictionary*attriDict =@{NSParagraphStyleAttributeName:paragraphStyle,NSKernAttributeName:@(kern)};
    NSMutableAttributedString*attributedString = [[NSMutableAttributedString   alloc]initWithString:self attributes:attriDict];
     
    return attributedString;
}
@end
