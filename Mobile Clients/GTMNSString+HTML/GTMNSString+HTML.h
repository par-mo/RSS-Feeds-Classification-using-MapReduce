

#import <Foundation/Foundation.h>

@interface NSString (GTMNSStringHTMLAdditions)

- (NSString *)gtm_stringByEscapingForHTML;
- (NSString *)gtm_stringByEscapingForAsciiHTML;
- (NSString *)gtm_stringByUnescapingFromHTML;

@end