//
//  Closure+Typealias.swift
//  
//
//  Created by Dmytro Vorko on 15.08.2022.
//

import Foundation

public typealias Closure = () -> Void 
public typealias ArgClosure<InputArg, OutputArg> = (InputArg) -> OutputArg
