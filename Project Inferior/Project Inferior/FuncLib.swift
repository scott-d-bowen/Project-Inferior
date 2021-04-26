//
//  FuncLib.swift
//  Project3500
//
//  Created by Scotty B on 23/4/21.
//

import Foundation
import BigInt

class FuncLib {
    
    // static var remainderArray: [(UInt8, BigUInt)] = []

    static var start_date = Date()
    
    // GrabStartTime
    static func grabStartTime() {
        start_date = Date()
    }
    
    // Time since started
    static func timeSinceStarted() {
        print("\(-start_date.timeIntervalSinceNow) seconds elapsed.")
    }
    
    // First we need 4KB of random data
    static func generate4KBrandomdata() -> [UInt8] {
        var random4KB: [UInt8] = [ ]
        for _ in 0..<4096 {
            random4KB.append(UInt8.random(in: 0...255))
        }
        return random4KB
    }
    
    // Then we count the number of occurrences of each unsigned byte value (0-255) using a Dictionary
    static func frequency(random4KB: [UInt8]) -> [UInt8:UInt8] {
        
        var freq: [UInt8:UInt8] = [:]
        
        for idx in 0..<random4KB.count {
            if freq[random4KB[idx]] != nil {
                freq[random4KB[idx]] = freq[random4KB[idx]]! + 1
            } else {
                freq[random4KB[idx]] = 1
            }
        }
        return freq
    }
    
    // Converts Dictionary to Simple Array that is half the size
    static func frequencyCreateArray(frequencyDictionary: [UInt8:UInt8]) -> [UInt8] {
        
        var diffMap: [UInt8] = []
        
        for idx in 0..<frequencyDictionary.count {
            diffMap.append(frequencyDictionary[UInt8(idx)] ?? 0x00)
        }
        
        return diffMap
    }
    
    // FACTORIAL
    static func factorial(_ input: UInt32) -> BigUInt {
        if (input >= 1 ) {
            return input == 1 ? BigUInt(input) : BigUInt(input) * factorial(input - 1)
                // (1 ... n).map { BigUInt($0) }.reduce(BigUInt(1), *)
        } else {
            return 0
        }
    }
    
    // SAVE DATA TO FILE
    static func saveDataToFile(dataToSave: [UInt8], filename: String) {
        print("Saving Data to File...")
        let outputFile = URL(fileURLWithPath: "/Users/sdb/TEST DATA/ProjectSDBX/" + filename)
        // let dataToWrite = Data(bytes: &dataToSave, count: dataToSave.count)
        let dataToWrite = Data(bytes: dataToSave, count: dataToSave.count)
            // * MemoryLayout<[UInt8]>.stride)
        try! dataToWrite.write(to: outputFile)
        print(" - Saved to: " + filename)
    }
    static func saveDataToFile(dataToSave: [UInt16], filename: String) {
        print("Saving Data to File...")
        let outputFile = URL(fileURLWithPath: "/Users/sdb/TEST DATA/ProjectSDBX/" + filename)
        // let dataToWrite = Data(bytes: &dataToSave, count: dataToSave.count)
        let dataToWrite = Data(bytes: dataToSave, count: dataToSave.count * MemoryLayout<[UInt16]>.stride)
        try! dataToWrite.write(to: outputFile)
        print(" - Saved to: " + filename)
    }
    static func saveDataToFile(dataToSave: Data, filename: String) {
        print("Saving Data to File...")
        let outputFile = URL(fileURLWithPath: "/Users/sdb/TEST DATA/ProjectSDBX/" + filename)
        // let dataToWrite = Data(bytes: &dataToSave, count: dataToSave.count)
        let dataToWrite = dataToSave
        try! dataToWrite.write(to: outputFile)
        print(" - Saved to: " + filename)
    }
    static func saveDataToFile(dataToSave: [(UInt8,BigUInt)], filename: String) {
        print("Saving Data to File...")
        let outputFile = URL(fileURLWithPath: "/Users/sdb/TEST DATA/ProjectSDBX/" + filename)
        
        
        let remainderArray: [(UInt8, BigUInt)] = []
        
        
        var remainderDataArray: [Data] = [Data()]
        remainderDataArray.reserveCapacity(8192)
        for idx in 0..<dataToSave.count {
            var byteArray: [UInt8] = [ ]
            byteArray.append(dataToSave[idx].0)
            remainderDataArray[idx].append(contentsOf: byteArray)
            remainderDataArray.append(dataToSave[idx].1.serialize())
        }
        
        // let dataToWrite = Data(bytes: &dataToSave, count: dataToSave.count)
        let dataToWrite = Data(bytes: remainderArray, count: remainderArray.count)
                               // * MemoryLayout<[(UInt8,BigUInt)]>.stride)
        try! dataToWrite.write(to: outputFile)
        print(" - Saved to: " + filename)
    }
    
    // SCOTT'S FACTORADIC
    static func scottsFactoradic(_ n: BigUInt, diffMap: [UInt8]) -> [UInt8] {
        
        var numberToConvert: BigUInt = n
        var factoradicReturn: [UInt8] = [ ]
        var factoradicDividingBy: BigUInt = 256
        var factoradicDividingByCount = 1
        
        var (q, r): (BigUInt, BigUInt) = (1, 0)
        var r_uint8 = UInt8(r)
        while (q > 0 && factoradicDividingBy > 0) {
            (q, r) = numberToConvert.quotientAndRemainder(dividingBy: factoradicDividingBy)
             
            // factoradicDividingByCount += 1 moved to inside of if block
            if (factoradicDividingByCount >= diffMap[Int(factoradicDividingBy-1)]) {
                factoradicDividingBy -= 1       // DECREMENT
                factoradicDividingByCount = 0   // RESET
                factoradicDividingByCount += 1
            }
            
            r_uint8 = UInt8(r)
            factoradicReturn.insert(r_uint8, at: 0)
            
            numberToConvert = q
            // print(q, r, r_uint8)
        }
        return factoradicReturn
    }

}
