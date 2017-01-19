//
//  ViewController.swift
//  Prime Time
//
//  Created by Stephen Cartwright on 1/18/17.
//  Copyright © 2017 Ōmagatoki. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate {
	
	var pnu = PrimeNumberUtils();
	var counter: Int = 0;
	var correctCount: Int = 0;
	
    @IBOutlet var lbl_IsPrime: UILabel!

	@IBAction func btn_TAGenNum(_ sender: UIButton) {
		resetPrime();
	}
	@IBOutlet var txtFld_Display: UITextField!
	@IBAction func btn_PrimeTrue(_ sender: UIButton) {
		let a = Int(txtFld_Display.text!);
		if(pnu.testPrimality(dbInput: Double(txtFld_Display.text!)!)) {
			updateTxtVw(txtVw: txtVw_DisplayAns, msg: String.init(format: "Correct! %d is a prime", a!));
			correctCount += 1;
		} else {
			
			updateTxtVw(txtVw: txtVw_DisplayAns, msg: String.init(format: "Sorry.. %d is not a prime", a!));
		}
		counter += 1;
		updateScore();
	}
	
	@IBAction func btn_PrimeFalse(_ sender: UIButton) {
		let a = Int(txtFld_Display.text!);
		if(!pnu.testPrimality(dbInput: Double(txtFld_Display.text!)!)){
			updateTxtVw(txtVw: txtVw_DisplayAns, msg: String.init(format: "Correct! %d is not a prime", a!));
			correctCount += 1;

		} else {
			updateTxtVw(txtVw: txtVw_DisplayAns, msg: String.init(format: "Sorry.. %d is a prime", a!));
		}
		counter += 1;
		updateScore();
	}
	
	@IBOutlet var txtVw_DisplayAns: UITextView!
	
	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		// Hide keyboard
		textField.resignFirstResponder();
		return true;
	}
	
	func textFieldDidEndEditing(_ textField: UITextField, reason: UITextFieldDidEndEditingReason) {
		textField.resignFirstResponder();
		return;
	}
	
	func textViewDidEndEditing(_ textView: UITextView) {
		textView.resignFirstResponder();
		return;
	}

	@IBOutlet var lbl_DispPrimeFact: UILabel!
	@IBAction func btn_ShowFactorization(_ sender: UIButton) {
		let c = Int(txtFld_Display.text!);
		updateTxtVw(txtVw: txtVw_DisplayFactorization, msg: String.init(format: "%d = ", c!) +  pnu.primeFactorization(composite: c!));
		resetPrime();
		//counter += 1;
		updateScore();
	}
	@IBOutlet var txtVw_DisplayFactorization: UITextView!
	
	@IBOutlet var lbl_Correct: UILabel!

	
	func resetPrime() -> Void {
		txtFld_Display.text = String(pnu.randomIntGenerator(lowerBound: 1, upperBound: 1000));
	}
	
	func updateTxtVw(txtVw: UITextView, msg: String) {
		let s = String(txtVw.text + "\n" + msg);
		txtVw.text = s;
	}
	
	func updateScore() -> Void {
		lbl_Correct.text = String.init(format: "Correct: %d / %d", correctCount, counter);
	}
	
	
	override func viewDidLoad() {
		
		
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
		pnu = PrimeNumberUtils();
		
		// Handle txtFld_Display user input thorugh delegate callbacks
		txtFld_Display.delegate = self;
		txtVw_DisplayAns.delegate = self;
		txtVw_DisplayFactorization.delegate = self;
		
		resetPrime();

	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}


}

