//
//  main.swift
//  Project Inferior
//
//  Created by Scott D. Bowen on 12-Feb-1996 to 12-Feb-1999
//

import Foundation
import BigInt

// BENCHMARK
func benchmarkCode() {
    print("\(-start_date.timeIntervalSinceNow) seconds elapsed.")
    start_date = Date()
}


var start_date = Date()
print("Hello, World!")

for idx: UInt16 in 0...692 {
    let x = Permutation.factorial(idx)
    let y = (idx * 8) >= (x.bitWidth) ? true : false
    print("\(idx); \(idx * 8); \(x.bitWidth); \(y); \(Int(idx) * 8 - x.bitWidth)")
}

benchmarkCode()

let __512 = Permutation.factorial(256).power(2).bitWidth
let _4096 = Permutation.factorial(256).power(16).bitWidth
let _8192 = Permutation.factorial(256).power(32).bitWidth
print(__512 / 8, _4096 / 8, _8192 / 8)

benchmarkCode()

let BLOCK_SIZE: UInt32 = 691
var byteArray: [UInt8] = [ ]
for idx in 0..<(64 * 1024 * 1024) / BLOCK_SIZE {
    byteArray.append(contentsOf: Statistics.generateRandomData(
                     blockSize: BLOCK_SIZE).sorted() )
    if (idx % 256 == 0) {
        print(".", terminator: "")
    }
}
print()
benchmarkCode()

FuncLib.saveDataToFile(dataToSave: byteArray, filename: "Project-Inferior.sdbx")
//  256: LRZIP (ZPAQ): ~16,209,003 bytes ( ~61.8 bytes each) +  210.5 byte factoradic = 272.3 bytes
//  512: LRZIP (ZPAQ): ~10,674,633 bytes ( ~81.4 bytes each) +  421.0 byte factoradic = 502.4 bytes
// 4096: LRZIP (ZPAQ):  ~4,428,642 bytes (~270.3 bytes each) + 3368.0 byte factoradic = 3638.3 bytes
// 8192: LRZIP (ZPAQ):  ~2,854,057 bytes (~348.4 bytes each) + 6736.0 byte factoradic = 7084.4 bytes
benchmarkCode()

print("Goodbye.")
