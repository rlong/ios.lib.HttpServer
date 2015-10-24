//
//  AVStorageManagerHelper.m
//  av_amigo
//
//  Created by rlong on 8/02/13.
//  Copyright (c) 2013 HexBeerium. All rights reserved.
//

#import "XPStorageManagerHelper.h"

#import "JBBaseException.h"
#import "JBFileUtilities.h"
#import "JBLog.h"

@implementation XPStorageManagerHelper





// vvv derived from [RGFile getFreeSpace]
+(uint64_t)getFreeSpaceForPath:(NSString*)path {
    
    NSFileManager* defaultManager = [NSFileManager defaultManager];
    
    NSError* error = nil;
    
    NSDictionary* attributesOfFileSystem = [defaultManager attributesOfFileSystemForPath:path error:&error];
    if( nil != error ) {
        Log_warnError(error);
        return 0;
    }
    
    NSNumber* fileSystemFreeSize = [attributesOfFileSystem objectForKey:NSFileSystemFreeSize];
    
    if( nil == fileSystemFreeSize ) {
        Log_warn(@"nil == fileSystemFreeSize");
        return 0;
    }
    
    return [fileSystemFreeSize unsignedLongLongValue];
    
}
// ^^^ derived from [RGFile getFreeSpace]

+(BOOL)removeFileWithPath:(NSString*)fullPath swallowErrors:(BOOL)swallowErrors {

    NSFileManager* defaultManager = [NSFileManager defaultManager];
    
    if( [defaultManager fileExistsAtPath:fullPath] ) {
        
        NSError* error = nil;
        
        [defaultManager removeItemAtPath:fullPath error:&error];
        
        if( nil != error ) {
            
            if( swallowErrors ) {
                Log_warnError( error);
                return false;
                
            } else {
                JBBaseException* e = [JBBaseException baseExceptionWithOriginator:self line:__LINE__ callTo:@"[NSFileManager removeItemAtPath:error:]" failedWithError:error];
                [e addStringContext:fullPath withName:@"fullPath"];
                @throw  e;
            }
        }
    }
    
    return true;

}



+(BOOL)removeFileWithName:(NSString*)filename inFolder:(NSString*)folderPath swallowErrors:(BOOL)swallowErrors {
    
    
    NSString* fullPath = [folderPath stringByAppendingPathComponent:filename];
    
    return [self removeFileWithPath:fullPath swallowErrors:swallowErrors];
    


}


+(uint64_t)sizeOfFileWithName:(NSString*)filename inFolder:(NSString*)folderPath {

    NSString* fullPath = [folderPath stringByAppendingPathComponent:filename];
    
    return [JBFileUtilities getFileLength:fullPath];

}


@end
