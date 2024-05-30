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

typedef void* CPersonModel;
 
#ifdef __cplusplus
extern "C" {
#endif
    void printHellow(void);
    int getRandomInt(void);
     

    CPersonModel create();
    CPersonModel createBy(const char* name,int age);
    void printPersonInfo(CPersonModel model);
    const char* getPersonName(CPersonModel model);
    void destoryModel(CPersonModel model);

    // 识别某一个图片并返回文本
    const char* recognize(const char* path);
    
#ifdef __cplusplus
}
#endif



#endif /* CBridging_h */
