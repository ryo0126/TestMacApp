//
//  ViewController.swift
//  DecimalConverter
//
//  Created by Ryo on 2019/12/27.
//  Copyright © 2019 Ryoga. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    @IBOutlet weak var decimalTextField: NSTextField!
    @IBOutlet weak var hexTextField: NSTextField!
    @IBOutlet weak var octalTextField: NSTextField!
    @IBOutlet weak var binaryTextField: NSTextField!

    @IBOutlet weak var decimalCopyButton: NSButton!
    @IBOutlet weak var hexCopyButton: NSButton!
    @IBOutlet weak var octalCopyButton: NSButton!
    @IBOutlet weak var binaryCopyButton: NSButton!

    var model: Model!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupModel()
    }

    private func setupUI() {
        decimalTextField.delegate = self
        hexTextField.delegate = self
        octalTextField.delegate = self
        binaryTextField.delegate = self
    }

    private func setupModel() {
        model = Model()
        updateTextFields()
    }

    @IBAction func onDecimalCopyButtonTapped(_ sender: NSButton) {
        setStringToClipboard(decimalTextField.stringValue)
    }

    @IBAction func onHexCopyButtonTapped(_ sender: NSButton) {
        setStringToClipboard(hexTextField.stringValue)
    }

    @IBAction func onOctalCopyButtonTapped(_ sender: NSButton) {
        setStringToClipboard(octalTextField.stringValue)
    }

    @IBAction func onBinaryCopyButtonTapped(_ sender: NSButton) {
        setStringToClipboard(binaryTextField.stringValue)
    }

    private func updateTextFields() {
        decimalTextField.stringValue = model.decimalString
        hexTextField.stringValue = model.hexString
        octalTextField.stringValue = model.octalString
        binaryTextField.stringValue = model.binaryString
    }

    private func setStringToClipboard(_ string: String) {
        let clipboard = NSPasteboard.general
        clipboard.clearContents()
        clipboard.setString(string, forType: .string)
    }
}

extension ViewController: NSTextFieldDelegate {

    func controlTextDidChange(_ obj: Notification) {
        let textField = obj.object as! NSTextField
        let rawText = textField.stringValue
        let text = rawText.isEmpty ? "0" : rawText

        switch textField {
        case decimalTextField:
            let numbers = text.replacingOccurrences(
                of: "\\D",
                with: "",
                options: .regularExpression
            )
            model.updateValue(toNumericalString: numbers, radix: .decimal)
        case hexTextField:
            let numbers = text.replacingOccurrences(
                of: "[^0-9A-Fa-f]",
                with: "",
                options: .regularExpression
            )
            model.updateValue(toNumericalString: numbers, radix: .hex)
        case octalTextField:
            let numbers = text.replacingOccurrences(
                of: "[^0-7]",
                with: "",
                options: .regularExpression
            )
            model.updateValue(toNumericalString: numbers, radix: .octal)
        case binaryTextField:
            let numbers = text.replacingOccurrences(
                of: "[^0-1]",
                with: "",
                options: .regularExpression
            )
            model.updateValue(toNumericalString: numbers, radix: .binary)
        default:
            fatalError("Unknown TextField detected.")
        }
        updateTextFields()
    }
}
