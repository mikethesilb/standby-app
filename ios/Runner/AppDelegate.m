#import "AppDelegate.h"
#import "GeneratedPluginRegistrant.h"
// Add the following import.
#import "GoogleMaps/GoogleMaps.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application
    didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  [GeneratedPluginRegistrant registerWithRegistry:self];
  // Add the following line, with your API key
  [GMSServices provideAPIKey: @"AIzaSyAfsKzR0ed3j9MPDdT82TEi7fOtEZxsYWU"];
  return [super application:application didFinishLaunchingWithOptions:launchOptions];
}

@end