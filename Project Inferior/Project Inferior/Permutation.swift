//
//  Permutation.swift
//  ProjectRLE3c
//
//  Created by Scotty B.
//

import Foundation
import BigInt

class Permutation {
    
    // Greatly Enhanced Function to get Factoradic representation of a number,n.
    static func getFactoradic(input: UInt) -> (array: [UInt], permutation: BigUInt) {
        
        var num = input
        
        var factoradic: [UInt] = [ ]
        var i: UInt = 1
        
        while (num != 0) {
            factoradic.append(num % i);
            num = num / i;
            i += 1;
        }
        
        var bigIntRep: BigUInt = 0
        for idx in 0..<factoradic.count {
            bigIntRep = bigIntRep + factorial(UInt16(idx)) * BigUInt(factoradic[idx])
        }
        
        let tuple: ([UInt], BigUInt) = (factoradic.reversed(), bigIntRep )
        return tuple;
    }
    static func getFactoradic(n: BigUInt) -> ([UInt],BigUInt) {
        
        var num = n
        
        var factoradic: [UInt] = [ ]
        var i: UInt = 1
        
        while (num != 0) {
            let (_, r) = num.quotientAndRemainder(dividingBy: BigUInt(i))
            factoradic.append(UInt(r));
            num = num / BigUInt(i);
            i += 1;
        }
        
        var bigIntRep: BigUInt = 0
        for idx in 0..<factoradic.count {
            bigIntRep = bigIntRep + factorial(UInt16(idx)) * BigUInt(factoradic[idx])
        }
        
        let tuple: ([UInt], BigUInt) = (factoradic.reversed(), bigIntRep )
        return tuple;
    }
    
    // FACTORIAL
    static func factorial(_ input: UInt16) -> BigUInt {
        if (input >= 1 ) {
            return input == 1 ? BigUInt(input) : BigUInt(input) * factorial(input - 1)
            // (1 ... n).map { BigUInt($0) }.reduce(BigUInt(1), *)
        } else {
            return 0
        }
    }
}
