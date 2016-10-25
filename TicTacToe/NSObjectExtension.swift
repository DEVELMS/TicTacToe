//
//  ViewControllerExtension.swift
//  TicTacToe
//
//  Created by Lucas M Soares on 22/10/16.
//  Copyright © 2016 Lucas M Soares. All rights reserved.
//

import UIKit

protocol Identifying { }

extension Identifying where Self : NSObject {
    
    static var identifier: String { return String(describing: self) }
}

extension NSObject: Identifying { }
