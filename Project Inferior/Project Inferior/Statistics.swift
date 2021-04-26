//
//  Statistics.swift
//  ProjectSDBX
//
//  Created by Scotty B on 26/4/21.
//

import Foundation

class Statistics {
    
    static func generateRandomData(blockSize: UInt32) -> [UInt8] {
        var byteArray: [UInt8] = [ ]
        for _ in 0..<blockSize {
            byteArray.append(UInt8.random(in: 0...255))
            // 0x00 and 0x01 are both 'special cases'
            // randomDataTest[iterCount * BlockSize + idx] = byteArray[idx]
        }
        return byteArray
    }
    
    static func frequency(inputArray: [UInt8]) -> [UInt8:UInt8] {
        
        var freqDict: [UInt8:UInt8] = [:]
        
        for idx in 0..<inputArray.count {
            if freqDict[inputArray[idx]] != nil {
                freqDict[inputArray[idx]] = freqDict[inputArray[idx]]! + 1
            } else {
                freqDict[inputArray[idx]] = 1
            }
        }
        return freqDict
    }
    
    // Converts Dictionary to Simple Array that is half the size
    static func frequencyCreateSimpleArray(frequencyDictionary: [UInt8:UInt8]) -> PancakeStack {
        
        let emptyByteArr: [UInt8] = [ ]
        var pancakeStack: PancakeStack = PancakeStack(diffMap: emptyByteArr)
        
        for idx in 0..<256 {
            pancakeStack.diffMap.append(frequencyDictionary[UInt8(idx)] ?? 0x00)
        }
        
        return pancakeStack
    }
    
    
}
