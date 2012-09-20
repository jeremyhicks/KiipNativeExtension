//
//  KIIP.m
//  KIIP
//
//  Created by Jeremy Hicks on 9/15/12.
//  Copyright (c) 2012 Jeremy Hicks. All rights reserved.
//

#include "FlashRuntimeExtensions.h"
#import "KIIPANE.h"
#import "KiipDelegate.h"

@implementation KIIPANE

KiipDelegate *kD;

FREObject setLocation(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[])
{
    if (kD)
    {
        
    }
    else {
        kD = [kD initKiip];
    }
    
    [kD setLocation];
    
    return NULL;
}

FREObject unlockAchievement(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[])
{
    if (kD)
    {
        
    }
    else {
        kD = [kD initKiip];
    }
    
    [kD unlockAchievement];
    
    return NULL;
}

// required methods, list your custom functions here
void ContextInitializer(void* extData, const uint8_t* ctxType, FREContext ctx, uint32_t* numFunctionsToTest, const FRENamedFunction** functionsToSet)
{
    
	*numFunctionsToTest = 2;
    
	FRENamedFunction* func = (FRENamedFunction*)malloc(sizeof(FRENamedFunction) * *numFunctionsToTest);
	func[0].name = (const uint8_t*)"setLocation";
	func[0].functionData = NULL;
	func[0].function = &setLocation;
    
    func[1].name = (const uint8_t*)"unlockAchievement";
	func[1].functionData = NULL;
	func[1].function = &unlockAchievement;
    
	*functionsToSet = func;
    
}

void ContextFinalizer(FREContext ctx)
{
	// nullify things
	
   	return;
}

void ExtInitializer(void** extDataToSet, FREContextInitializer* ctxInitializerToSet, FREContextFinalizer* ctxFinalizerToSet) {
	*extDataToSet = NULL;
	*ctxInitializerToSet = &ContextInitializer;
	*ctxFinalizerToSet = &ContextFinalizer;
}

void ExtFinalizer(void* extData) {
	return;
}


void minimalFinalizerFunction(void * extData)
{
	return;
}

@end
