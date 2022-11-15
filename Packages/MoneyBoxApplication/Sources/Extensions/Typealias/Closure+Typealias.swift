//
//  Closure+Typealias.swift
//  
//
//  Created by Dmytro Vorko on 15.08.2022.
//

import Foundation

public typealias Closure = () -> Void 
public typealias ArgAdjClosure<InputArg, OutputArg> = (InputArg) -> OutputArg
public typealias ArgClosure<InputArg> = (InputArg) -> Void
