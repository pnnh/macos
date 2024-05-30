//
//  CPPerson.cpp
//  SwiftCDemo
//
//  Created by yaojinhai on 2019/6/22.
//  Copyright © 2019 yaojinhai. All rights reserved.
//

#include "CPPerson.hpp"
#include "CBridging.h"

#include <tesseract/baseapi.h>
#include <leptonica/allheaders.h>


CPPerson::CPPerson(){
    this->name = "管理员";
    this->age = 20;
    this->isNan = true;
}

CPPerson::CPPerson(const char * name,int age, bool isNan){
    this->name = name;
    this->age = age;
    this->isNan = isNan;
}

void CPPerson::printPersonInfo(){
    std::cout << "i am is " << name << ",my age is "<< age;
    if (isNan) {
        std::cout << "i am a body";
    }else{
        std::cout << "i am a girl";
    }
    std::cout << "\n";
}
const char* CPPerson::getPersonName() {
    return name.data();
}

CPPerson::~CPPerson(){
    std::cout << "\n释放资源2222\n";
}


// MARK: - 实现接口函数
 


CPersonModel create() {
    
    
    
    
    return new CPPerson();
}
CPersonModel createBy(const char* name,int age){
    
    
    printf("jjjj22aaaa");
    
    //testOCR();
    
    
    return new CPPerson(name,age,true);
}
void printPersonInfo(CPersonModel model) {
    CPPerson *p = (CPPerson*)model;
    p->printPersonInfo();
}
const char* getPersonName(CPersonModel model){
    CPPerson *p = (CPPerson*)model;
    return p->getPersonName();
}
void destoryModel(CPersonModel model){
    CPPerson *p = (CPPerson*)model;
    delete p;
}


// 识别一张图片
const char* recognize(const char* path ) {
    
    std::cout << "\n开始识别图片：" << path << std::endl;
    
     char *outText;

     tesseract::TessBaseAPI *api = new tesseract::TessBaseAPI();
     // Initialize tesseract-ocr with English, without specifying tessdata path
     if (api->Init("Documents/tessdata", "chi_sim")) // you can set tessdata path here
     {
       fprintf(stderr, "Could not initialize tesseract.\n");
       exit(1);
     }

     // Open input image with leptonica library
     //Pix *image = pixRead("Documents/test.png");
       Pix *image = pixRead(path);
     api->SetImage(image);
     // Get OCR result
     outText = api->GetUTF8Text();
     printf("OCR output:\n%s", outText);

     // Destroy used object and release memory
     api->End();
     
    // 在外部释放
    //delete [] outText;
     pixDestroy(&image);

     return outText;
    
//    return "hhhhaaa";
}
