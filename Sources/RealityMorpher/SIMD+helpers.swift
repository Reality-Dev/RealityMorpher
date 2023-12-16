//
//  SIMD+helpers.swift
//  
//
//  Created by Oliver Dew on 11/08/2023.
//

import simd
import SwiftUI

extension SIMD4 {
	var xyz: SIMD3<Scalar> {
		get {
			SIMD3(x: x, y: y, z: z)
		}
		set {
			self = SIMD4(newValue, w)
		}
	}
}

extension SIMD8: VectorArithmetic & AdditiveArithmetic where Scalar == Float {
	public mutating func scale(by rhs: Double) {
		self *= Float(rhs)
	}
	
	public var magnitudeSquared: Double {
        SIMD8<Double>(self).lengthSquared
	}
}

extension SIMD8 where Scalar == Double {
    var lengthSquared: Double {
        var result: Scalar = 0
        for i in self.indices {
            result += self[i] * self[i]
        }
        return result
    }

    var length: Double {
        return sqrt(lengthSquared)
    }
}
