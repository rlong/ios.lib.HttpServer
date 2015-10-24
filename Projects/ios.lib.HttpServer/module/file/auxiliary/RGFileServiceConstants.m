//
//  RGFileConstants.m
//  remote_gateway
//
//  Created by Richard Long on 27/09/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "RGFileServiceConstants.h"

@implementation RGFileServiceConstants


//static NSString* _SORT_BY_AGE = @"age";


+(NSString*)FILEINFO_FILELENGTH {
    return @"length";
}

+(NSString*)PULL_PUSH_TRANSACTION_ID {
    
    return @"transactionId";
}

+(NSString*)PULL_FILE_LENGTH {
    
    return @"fileLength";
}


+(NSString*)SERVICE_NAME { 
    return @"remote_gateway.FileService";
}





@end
