//
//  ViewController.swift
//  Budgeteer
//
//  Created by Brendon Warwick on 03/08/2018.
//  Copyright © 2018 BW. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    // MARK: - Outlets
    @IBOutlet weak var spentTodayTextField: UITextField!
    @IBOutlet weak var spentYesterdayLabel: UILabel!
    @IBOutlet weak var leftToSpendTodayLabel: UILabel!
    
    // MARK: - Attributes
    var dailyBudget = 30.0
    var spentToday = 0.0
    var todaysBudget = 30.0
    
    // MARK: - Initialization
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        spentTodayTextField.delegate = self
        
        let currentDate = todaysDate()
        var lastDateOpened = BWDate().loadLatestFromDisk()
        
        // if the returned date is 1/1/1970 then we say it is the same day
        if lastDateOpened == BWDate() {
            lastDateOpened = currentDate
        }
        
        spentToday = getSpentToday()
        
        // Check for New day
        if !(currentDate == lastDateOpened) {
            todaysBudget = getTodaysBudget()
        } 

        updateMoneyLeftForToday()
        updateView()
        
        // Store the day
        currentDate.saveToDisk()
    }
    
    // MARK: - Methods
    
    func getSpentToday() -> Double {
        if let spent = UserDefaults.standard.object(forKey: "amountSpent") as? Double {
            return spent
        }
        return 0.0
    }
    
    // Need to set todays budget and display what was spent yesterday
    func getTodaysBudget() -> Double {
        spentYesterdayLabel.text = "£\(spentToday.format(f: ".2"))"
        let todaysBudget = dailyBudget + (dailyBudget - spentToday)
        
        print("Todays budget is \(todaysBudget)")
        
        // Reset how much the user has spent, as it's a new day, after calculating new budget for the day
        spentToday = 0
        
        return todaysBudget
    }
    
    func todaysDate() -> BWDate {
        let calendar = NSCalendar.init(calendarIdentifier: NSCalendar.Identifier.gregorian)
        
        let currentDay = (calendar?.component(NSCalendar.Unit.day, from: Date()))!
        let currentMonth = (calendar?.component(NSCalendar.Unit.month, from: Date()))!
        let currentYear = (calendar?.component(NSCalendar.Unit.year, from: Date()))!
        
        return BWDate(currentDay, currentMonth, currentYear)
    }
    
    func updateSpentToday() {
        UserDefaults.standard.set(spentToday, forKey: "amountSpent")
        spentTodayTextField.text = "£" + spentToday.format(f: ".2")
    }
    
    func updateMoneyLeftForToday() {
        let moneyLeftForToday = todaysBudget - spentToday
        leftToSpendTodayLabel.text = moneyLeftForToday > 0 ? "£\(moneyLeftForToday.format(f: ".2"))" : "Nothing 💵🔥"
    }
    
    // MARK: - Textfield delegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.text = ""
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        spentToday = Double(textField.text ?? "0") ?? 0.0
        updateView()
    }
    
    // MARK: - User Interface
    
    func updateView() {
        updateMoneyLeftForToday()
        updateSpentToday()
    }
    
    // MARK: - Actions
    
    @IBAction func viewTapped(_ sender: Any) {
        spentTodayTextField.resignFirstResponder()
    }
}
