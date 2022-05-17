//
//  main.swift
//  Krello
//
//  Created by Bumgeun Song on 2022/05/06.
//

import UIKit

let appDelegateClass: AnyClass = NSClassFromString("AuthenticationManagerIntegrationTest") ?? AppDelegate.self

UIApplicationMain(CommandLine.argc,
                  CommandLine.unsafeArgv,
                  nil,
                  NSStringFromClass(appDelegateClass))
