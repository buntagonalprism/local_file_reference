#import "LocalFileReferencePlugin.h"
#import <local_file_reference/local_file_reference-Swift.h>

@implementation LocalFileReferencePlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftLocalFileReferencePlugin registerWithRegistrar:registrar];
}
@end
