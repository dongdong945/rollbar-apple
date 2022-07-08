//
//  RollbarLoggerRegistryTests.m
//  
//
//  Created by Andrey Kornich on 2022-06-30.
//

#import <XCTest/XCTest.h>

@import Foundation;
@import RollbarNotifier;

#import "../../Sources/RollbarNotifier/RollbarLoggerRegistry.h"
#import "../../Sources/RollbarNotifier/RollbarDestinationRecord.h"
#import "../../Sources/RollbarNotifier/RollbarLoggerRecord.h"

@interface RollbarLoggerRegistryTests : XCTestCase

@end

@implementation RollbarLoggerRegistryTests

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

- (void)testBasics {

    RollbarLoggerRegistry *registry = [RollbarLoggerRegistry new];
    XCTAssertNotNil(registry);
    XCTAssertEqual(0, [registry totalDestinationRecords]);
    
    RollbarConfig *config = [RollbarConfig configWithAccessToken:@"Token_A"];
    
    RollbarLogger *loggerA = [registry loggerWithConfiguration:config];
    XCTAssertNotNil(loggerA);
    XCTAssertEqual(1, [registry totalDestinationRecords]);
    XCTAssertEqual(1, [registry totalLoggerRecords]);
//    XCTAssertEqual(1, loggerA.loggerRecord.destinationRecord.totalLoggerRecords);

    RollbarLogger *loggerA1 = [registry loggerWithConfiguration:config];
    XCTAssertNotNil(loggerA1);
    XCTAssertEqual(1, [registry totalDestinationRecords]);
    XCTAssertEqual(2, [registry totalLoggerRecords]);
//    XCTAssertEqual(2, loggerA1.loggerRecord.destinationRecord.totalLoggerRecords);
    
    config = [RollbarConfig configWithAccessToken:@"Token_B"];
    
    RollbarLogger *loggerB = [registry loggerWithConfiguration:config];
    XCTAssertNotNil(loggerB);
    XCTAssertEqual(2, [registry totalDestinationRecords]);
    XCTAssertEqual(3, [registry totalLoggerRecords]);
//    XCTAssertEqual(1, loggerB.loggerRecord.destinationRecord.totalLoggerRecords);
    
    
//    [registry unregisterLogger:loggerA];
    XCTAssertEqual(2, [registry totalDestinationRecords], @"All registry records stay!");
    XCTAssertEqual(2, [registry totalLoggerRecords]);
//    XCTAssertEqual(1, loggerA1.loggerRecord.destinationRecord.totalLoggerRecords);

//    [registry unregisterLogger:loggerA1];
    XCTAssertEqual(2, [registry totalDestinationRecords], @"All registry records stay!");
    XCTAssertEqual(1, [registry totalLoggerRecords]);
//    XCTAssertEqual(1, loggerB.loggerRecord.destinationRecord.totalLoggerRecords);

//    [registry unregisterLogger:loggerB];
    XCTAssertEqual(2, [registry totalDestinationRecords], @"All registry records stay!");
    XCTAssertEqual(0, [registry totalLoggerRecords]);
}

- (void)testLoggerScope {
    
    RollbarConfig *config = [RollbarConfig configWithAccessToken:@"Token"];
    [[RollbarInfrastructure sharedInstance] configureWith:config];

    RollbarLoggerRegistry *registry = [RollbarLoggerRegistry new];

    XCTAssertNotNil(registry);
    XCTAssertEqual(0, [registry totalDestinationRecords]);
    
    [self useLoggerWithinLimitedScope:registry];
}

- (void)useLoggerWithinLimitedScope:(nonnull RollbarLoggerRegistry *)registry {
    
    @autoreleasepool {
        RollbarLogger *logger = [registry loggerWithConfiguration:[RollbarConfig new]]; //[[RollbarInfrastructure sharedInstance] createLogger];
        XCTAssertNotNil(logger);
        XCTAssertEqual(1, [registry totalDestinationRecords]);
        XCTAssertEqual(1, [registry totalLoggerRecords]);
//        XCTAssertEqual(1, logger.loggerRecord.destinationRecord.totalLoggerRecords);
//        XCTAssertTrue(logger.loggerRecord.isInScope);
    }
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
