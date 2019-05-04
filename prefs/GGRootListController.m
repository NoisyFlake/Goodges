#import <Social/Social.h>
#import <spawn.h>

#import "GGRootListController.h"

@interface GGRootListController ()

- (void)paypal;

@end


@implementation GGRootListController

-(instancetype)init {
    self = [super init];

    if(self) {
        _prefs = [NSClassFromString(@"GGPrefsManager") sharedManager];

        UIBarButtonItem *applyButton = [[UIBarButtonItem alloc] initWithTitle:@"Respring" style:UIBarButtonItemStylePlain target:self action:@selector(respring)];
        self.navigationItem.rightBarButtonItem = applyButton;
    }

    return self;
}

-(NSArray *)specifiers {
	if (!_specifiers) {
		_specifiers = [[self loadSpecifiersFromPlistName:@"Root" target:self] retain];
	}

	return _specifiers;
}

-(void)respring {
    pid_t pid;
    const char* args[] = {"killall", "-9", "backboardd", NULL};
    posix_spawn(&pid, "/usr/bin/killall", NULL, NULL, (char* const*)args, NULL);
}

-(id)readPreferenceValue:(PSSpecifier *)specifier {
    return [_prefs valueForKey:[specifier propertyForKey:@"key"]] ?: [specifier propertyForKey:@"default"];
}

-(void)setPreferenceValue:(id)value specifier:(PSSpecifier *)specifier {
    [_prefs setValue:value forKey:[specifier propertyForKey:@"key"]];
}

-(void)setLabelsUseCB:(id)value specifier:(PSSpecifier *)specifier {
    if([value boolValue]) {
        [_prefs setValue:@(NO) forKey:kHighlightUseCB];
    }

    [self setPreferenceValue:value specifier:specifier];

    [self reloadSpecifierID:@"highlightUseCBSpec" animated:YES];
}

-(void)setHighlightUseCB:(id)value specifier:(PSSpecifier *)specifier {
    if([value boolValue]) {
        [_prefs setValue:@(NO) forKey:kLabelsUseCB];
    }

    [self setPreferenceValue:value specifier:specifier];

    [self reloadSpecifierID:@"labelsUseCBSpec" animated:YES];
}

-(void)_returnKeyPressed:(UIKeyboard *)keyboard {
    [self.view endEditing:YES];

    [super _returnKeyPressed:keyboard];
}

-(void)paypal {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://www.paypal.me/NoisyFlake"]];
}

@end

@implementation GoodgesLogo

- (id)initWithSpecifier:(PSSpecifier *)specifier
{
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Banner" specifier:specifier];
    if (self) {
        CGFloat width = 320;
        CGFloat height = 70;

        CGRect backgroundFrame = CGRectMake(-50, -35, width+50, height);
        background = [[UILabel alloc] initWithFrame:backgroundFrame];
        [background layoutIfNeeded];
        background.backgroundColor = [UIColor colorWithRed:0.35 green:0.34 blue:0.84 alpha:1.0];
        background.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);

        CGRect tweakNameFrame = CGRectMake(0, -40, width, height);
        tweakName = [[UILabel alloc] initWithFrame:tweakNameFrame];
        [tweakName layoutIfNeeded];
        tweakName.numberOfLines = 1;
        tweakName.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
        tweakName.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:40.0f];
        tweakName.textColor = [UIColor whiteColor];
        tweakName.text = @"Goodges";
        // tweakName.backgroundColor = [UIColor colorWithRed:0.30 green:0.85 blue:0.39 alpha:1.0];
        tweakName.textAlignment = NSTextAlignmentCenter;

        CGRect versionFrame = CGRectMake(0, -5, width, height);
        version = [[UILabel alloc] initWithFrame:versionFrame];
        version.numberOfLines = 1;
        version.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
        version.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:15.0f];
        version.textColor = [UIColor whiteColor];
        version.text = @"Version 2.1.5";
        version.backgroundColor = [UIColor clearColor];
        version.textAlignment = NSTextAlignmentCenter;

        [self addSubview:background];
        [self addSubview:tweakName];
        [self addSubview:version];
    }
    return self;
}

- (CGFloat)preferredHeightForWidth:(CGFloat)width {
    return 100.0f;
}
@end
