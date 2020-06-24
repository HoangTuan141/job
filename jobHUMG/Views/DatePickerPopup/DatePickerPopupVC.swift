//
//  DatePickerPopupVC.swift
//  jobHUMG
//
//  Created by Hoàng Tuấn on 4/19/20.
//  Copyright © 2020 TuanHA-D1. All rights reserved.
//

import UIKit

class DatePickerPopupVC: UIViewController {

    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var dateLabel: UILabel!
    
    var onClickChoose: ((_ date: String) -> Void)?
    var date: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        date = datePicker.date.toString(formatter: .dayMonthYear) ?? ""
        dateLabel.text = date
    }
    
    private func setupView() {
        date = datePicker.date.toString(formatter: .dayMonthYear) ?? ""
        dateLabel.text = date
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissPopup))
        self.view.addGestureRecognizer(tapGesture)
    }
    
    @objc func dismissPopup() {
        self.dismiss(animated: false, completion: nil)
    }
    
    @IBAction func datePickerChanged(_ sender: Any) {
        date = datePicker.date.toString(formatter: .dayMonthYear) ?? ""
        dateLabel.text = date
    }
    
    @IBAction func cancelPressed(_ sender: Any) {
        self.dismiss(animated: false, completion: nil)
    }
    
    @IBAction func choosePressed(_ sender: Any) {
        self.onClickChoose?(date ?? "")
        self.dismiss(animated: false, completion: nil)
    }
}
