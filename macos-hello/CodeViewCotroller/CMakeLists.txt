cmake_minimum_required(VERSION 3.27)

project(hello LANGUAGES Swift)

add_executable(hello 
    main.swift 
    AppDelegate.swift 
    ViewController.swift 
    JFProgrammaticallyViewController.swift
    WindowDelegate.swift)
 