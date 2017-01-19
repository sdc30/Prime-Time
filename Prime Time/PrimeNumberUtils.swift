//
//  PrimeNumberUtils.swift
//  Prime Time
//
//  Created by Stephen Cartwright on 1/19/17.
//  Copyright © 2017 Ōmagatoki. All rights reserved.
//

import Foundation
import UIKit

class PrimeNumberUtils {
	
	private var primeHolder = [Int](), compositeHolder = [Int]();
	private var count: Int = 0;
	var message: String = "";
	
	func PrimeNumberUtils() -> Void {
		
	}
	
	func randomIntGenerator(lowerBound: Int, upperBound: Int) -> Int {
		let l = UInt32(lowerBound);
		let u = UInt32(upperBound);
		
		return Int(arc4random_uniform(u) + l);
	}
	
	func testPrimality(dbInput: Double) -> Bool {
		
		/*
		*	Using the square root property of Prime numbers
				A prime number is a integer (whole number) greater than 1 divisble only by 1 and itself.
				If any whole number lteq to sqrt(n) evenly divides n, then n cannot be a prime number.
				
				Assumption: Every composite (non prime) number has a proper factor less than or equal to its square root.
				
				Proof: We reason with proof by contradiction. Assume there exsists a composite number where
				a proper factor is not lteq its sqrt, call it n. If n can be written as a pair of factors, say (a, b) where
				a, b are between 1 and n, then n = a*b. If both a > sqrt(n) and b > sqrt(n), then a*n > n. =><= contradiction.
				Our assumption was ab = n and if not then at least one of a, b is lteq sqrt(n) and if n is composite, then
				n has a prime factor p <= sqrt(n).
				
				E.g. 6 is a not prime number. Suppose it is. Factors of 6 are: 1, 2, 3, 6. We only have 2, 3 to work with given
				our criterion and both 2, 3 are between 1, 6 = n. If 2 > 2.45 and 3 > 2.45 then 6 >= 6. But 2 is not > 2.45 so
				we find p = 2 <= 2.45 and 6 is non prime.
				
				
		
		Anyway.. we start with 2 since we need an integer > 1.
		
		
		*/
		
		var stillPrime = true;
		var currentInt = 2;
		// The numbers should be whole numbers so explicit cast should go from a .0..0 decimal to whole no issues

		let number = Int(dbInput);
		// We only need to check up until the floor'd integer of the square root

		let flsqrt = Int(floor(sqrt(dbInput)));
		
		repeat {
			// If the number tested is divisible by our current integer, its composite
			// If the number is the current integer then its going to divide evenly and ofc thats a factor
			if number % currentInt == 0 && number != currentInt {
				stillPrime = false;
			}
			
			currentInt += 1;
		} while currentInt <= flsqrt && number != currentInt
		
		
		return stillPrime;
	}

	func primeFactorization(composite: Int) -> String {
		var factors = [Int]();
			primeHolder = findPrimes(bound: composite);
		
		var count = 0;
		var currentFactor = 0;
		var factorCount = 0;
		var powerCounter = 1.0;
		let dbNum = Double(composite);
		var pwr = 0.0;
		var currentPrime = primeHolder[count];
		let primeCount = primeHolder.count;
			message = "";
		
		// We cant have primes larger than all primes that are held
		// and the number has to be bigger than the current prime
		while count < primeCount && composite > currentPrime {
			
			currentPrime = primeHolder[count];

			if composite % currentPrime == 0 {
				factors.append(currentPrime);
			}
			
			count += 1;
			
		}
		
		// Adjust my own indicies..
		factorCount = factors.count - 1;
		
		for i in 0...factorCount {
			currentFactor = factors[i];
			count = 0;
			powerCounter = 1;
			pwr = pow(Double(currentFactor), powerCounter);
			
			// So we want to find out if the power number evenly divides our composite 
			// A way to acomplish this is by checking if when we mod 1 its == 0
			while (dbNum / pwr).truncatingRemainder(dividingBy: 1) == 0 {
				count += 1;
				powerCounter += 1;
				pwr = pow(Double(currentFactor), powerCounter);
			}
			
			if count > 0 {
				message += String(format: "%d^%d", currentFactor, count);
			}
			if i < factorCount {
				message += "*";
			}
			
		}
		
		return message;
		
	}
	
	func findPrimes(bound: Int) -> [Int] {
		var count = 2;
		var primeCount = 0;
		var input = 0.0;
		
		var alPrimes = [Int]();
		
		while count < bound + 1 {
			
			input = Double(count);
			if testPrimality(dbInput: input) {
				alPrimes.append(count);
				primeCount += 1;
			}
			count += 1;
		}
		
		return alPrimes;
	}
	
	func log(m: Int) -> String{
		
		return "";
	}
}
