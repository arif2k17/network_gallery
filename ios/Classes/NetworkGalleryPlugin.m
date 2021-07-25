#import "NetworkGalleryPlugin.h"
#if __has_include(<network_gallery/network_gallery-Swift.h>)
#import <network_gallery/network_gallery-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "network_gallery-Swift.h"
#endif

@implementation NetworkGalleryPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftNetworkGalleryPlugin registerWithRegistrar:registrar];
}
@end
