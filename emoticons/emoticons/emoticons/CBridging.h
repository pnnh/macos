//
//  CBridging.h
//  SwiftCDemo
//
//  Created by yaojinhai on 2019/6/22.
//  Copyright © 2019 yaojinhai. All rights reserved.
//

#ifndef CBridging_h
#define CBridging_h

#include <stdio.h>
 
#ifdef __cplusplus
extern "C" {
#endif
    void printHellow(void);
    int getRandomInt(void);
     
    
    
#ifdef __cplusplus
}
#endif



#endif /* CBridging_h */
