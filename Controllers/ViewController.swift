// https://github.com/k9doghouse/MMWW2.git
//
//  ViewController.swift
//  MMWW2
//
//  2018 k9doghouse
//

import UIKit

struct GamePlay
{
    var gameWord : String
    var guess : String
    var result : String
    var guesses : [String]
    var results : [String]
    var howManyLettersInTheWord : Int
}
var maxLength : Int = 4
var daWord : String = ""
var daGuess : String = ""
var daResult : String = ""
var daCount : Int = 0
var list4 : [String] = Four().four
var list5 : [String] = Five().five
var list6 : [String] = Six().six
var count : Int = 0
let cellIdentifier = "Cell"

var game = GamePlay(gameWord : "",
                    guess : "",
                    result : "",
                    guesses : [""],
                    results : [""],
    howManyLettersInTheWord: maxLength)

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate
{
    @IBOutlet var tableView: UITableView!
    @IBOutlet var textField: UITextField!
    @IBOutlet weak var guessguess: UILabel!
    @IBOutlet weak var resultresult: UILabel!
    @IBOutlet weak var countcount: UILabel!
    @IBOutlet weak var textView: UITextView!
    
    func startGame()
    {
        clearTheBoard()
        getGameWordWithNoDoubledLetters()
    }

    override func viewDidLoad()
    {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 40.0
        tableView.rowHeight = UITableView.automaticDimension
        startGame()
    }

    override func didReceiveMemoryWarning()
    { super.didReceiveMemoryWarning() }

    func numberOfSections(in tableView: UITableView) -> Int
    { return 1 }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    { return game.results.count }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier,
                                                 for: indexPath) as! GamePlayTableViewCell
        let row = indexPath.row
        count = row

        switch count
        {
            case 0:
                cell.cellCountLabel.text = "#"
                cell.cellCountLabel.textColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
                cell.cellGuessLabel.text = "guess "
                cell.cellGuessLabel.textColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
                cell.cellResultLabel.text = "result"
                cell.cellResultLabel.textColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            default:
                cell.cellCountLabel.text = String(count)
                cell.cellGuessLabel.text = game.guesses[row]
                cell.cellResultLabel.text = game.results[row]
        }
        return cell
    }

    @IBAction func enterButtonTapped(_ sender: UIButton)
    {
        let unwantedCharacters = CharacterSet(charactersIn: "[0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ!~`@#$%^&*-+();:=_{}[],.<>?\\/|\"\']")

        daGuess = textField.text?.lowercased() ?? "OUCH"
        guard daGuess.rangeOfCharacter(from: unwantedCharacters) == nil else { return }
        game.guess = daGuess
        guessguess.text = daGuess
        let guessString = daGuess
        guard Set(guessString).count == game.howManyLettersInTheWord else { return }

        getResultStringForUsersInput()
        textField.text = ""
    }

    @IBAction public func segmentedControlValueChanged(_ sender: UISegmentedControl)
    {
        switch sender.selectedSegmentIndex
        {
        case 0:
            game.howManyLettersInTheWord = 4
            maxLength = game.howManyLettersInTheWord
            startGame()
        case 1:
            game.howManyLettersInTheWord = 5
            maxLength = game.howManyLettersInTheWord
            startGame()
        case 2:
            game.howManyLettersInTheWord = 6
            maxLength = game.howManyLettersInTheWord
            startGame()
        default:
            game.howManyLettersInTheWord = 4
            maxLength = game.howManyLettersInTheWord
            startGame()
        }
    }

    @IBAction func allowDoubleLettersOrNotSwitch(_ sender: UISwitch)
    {  }

    func solved()
    {
        Alert.showSolvedAlert(on: self)
        clearTheBoard()
        startGame()
    }

    func getResultStringForUsersInput()
    {
        if game.guess == game.gameWord
        { solved() }
        else
        {
            daResult = result(for: game.guess)
            resultresult.text = daResult
            daCount += 1
            countcount.text = String(daCount)
        }
    }
}// end class ViewController...

extension ViewController
{
    func result(for guessString: String) -> String
    {
        var includedAndCorrect = 0
        var includedOnly  = 0
        var guessLetter = Array(daGuess) /*Array(game.guess)*/
        let gameWordLetter = Array(daWord) /*Array(game.gameWord)*/

        for (index, letter) in guessLetter.enumerated()
        {
            if guessLetter[index] == gameWordLetter[index]
            {
                includedAndCorrect += 1
                guessLetter[index] = "𓃓"  // remove the character fom the mix
            }
            else if game.gameWord.contains(letter)
            {
                includedOnly += 1
                guessLetter[index] = "𓃓" // remove the character fom the mix
            }
        }
        game.result = " \(includedAndCorrect) 😎   \(includedOnly) 🙃"
        game.guesses.append(game.guess)
        game.results.append(game.result)
        tableView.reloadData()
        daResult = ""
        daGuess = ""
        return game.result
    }

    func clearTheBoard()
    {
        game.guesses.removeAll()
        game.results.removeAll()

        

        game = GamePlay(gameWord: "",
                        guess: "",
                        result: "",
                        guesses: [""],
                        results: [""],
                        howManyLettersInTheWord: maxLength)
        resultresult.text = ""
        guessguess.text = ""
        textField.text = ""
        countcount.text = ""
        daWord = ""
        daGuess = ""
        daResult = ""
        count = 0
        tableView.reloadData()
    }

    func getGameWordWithNoDoubledLetters()
    {
        switch game.howManyLettersInTheWord
        {
            case 4:
                list4.shuffle()
                daWord = list4.randomElement() ?? "OOPS!"
                game.gameWord = daWord
                let first  = 0
                let second = 1
                let third  = 2
                let fourth = 3
                let template = daWord

                let firstCharStart  = template.index(template.startIndex, offsetBy: first)
                let firstCharEnd    = template.index(template.endIndex,   offsetBy: -fourth)
                let secondCharStart = template.index(template.startIndex, offsetBy: second)
                let secondCharEnd   = template.index(template.endIndex,   offsetBy: -third)
                let thirdCharStart  = template.index(template.startIndex, offsetBy: third)
                let thirdCharEnd    = template.index(template.endIndex,   offsetBy: -second)
                let fourthCharStart = template.index(template.startIndex, offsetBy: fourth)
                let fourthCharEnd   = template.index(template.endIndex,   offsetBy: -first)

                let char1 = template[firstCharStart..<firstCharEnd]
                let char2 = template[secondCharStart..<secondCharEnd]
                let char3 = template[thirdCharStart..<thirdCharEnd]
                let char4 = template[fourthCharStart..<fourthCharEnd]
                print("4. chars: ",char1+char2+char3+char4)

                if  char1 == char2 ||
                    char1 == char3 ||
                    char1 == char4 ||
                    char2 == char3 ||
                    char2 == char4 ||
                    char3 == char4
                { getGameWordWithNoDoubledLetters() }
                else
                { daWord = template }
            case 5:
                list5.shuffle()
                daWord = list5.randomElement() ?? "OOPS!"
                game.gameWord = daWord
                let first  = 0
                let second = 1
                let third  = 2
                let fourth = 3
                let fifth  = 4
                let template = daWord

                let firstCharStart  = template.index(template.startIndex, offsetBy: first)
                let firstCharEnd    = template.index(template.endIndex,   offsetBy: -fifth)

                let secondCharStart = template.index(template.startIndex, offsetBy: second)
                let secondCharEnd   = template.index(template.endIndex,   offsetBy: -fourth)

                let thirdCharStart  = template.index(template.startIndex, offsetBy: third)
                let thirdCharEnd    = template.index(template.endIndex,   offsetBy: -third)

                let fourthCharStart = template.index(template.startIndex, offsetBy: fourth)
                let fourthCharEnd   = template.index(template.endIndex,   offsetBy: -second)

                let fifthCharStart  = template.index(template.startIndex, offsetBy: fifth)
                let fifthCharEnd    = template.index(template.endIndex,   offsetBy: -first)

                let char1 = template[firstCharStart..<firstCharEnd]
                let char2 = template[secondCharStart..<secondCharEnd]
                let char3 = template[thirdCharStart..<thirdCharEnd]
                let char4 = template[fourthCharStart..<fourthCharEnd]
                let char5 = template[fifthCharStart..<fifthCharEnd]
                print("5. chars: ",char1+char2+char3+char4+char5)

                if  char1 == char2 ||
                    char1 == char3 ||
                    char1 == char4 ||
                    char1 == char5 ||
                    char2 == char3 ||
                    char2 == char4 ||
                    char2 == char5 ||
                    char3 == char4 ||
                    char3 == char5 ||
                    char4 == char5
                { getGameWordWithNoDoubledLetters() }
                else
                { daWord = template }
            case 6:
                list6.shuffle()
                daWord = list6.randomElement() ?? "OOPS!"
                game.gameWord = daWord
                let first  = 0
                let second = 1
                let third  = 2
                let fourth = 3
                let fifth  = 4
                let sixth  = 5
                let template = daWord

                let firstCharStart  = template.index(template.startIndex, offsetBy: first)
                let firstCharEnd    = template.index(template.endIndex,   offsetBy: -sixth)
                let secondCharStart = template.index(template.startIndex, offsetBy: second)
                let secondCharEnd   = template.index(template.endIndex,   offsetBy: -fifth)
                let thirdCharStart  = template.index(template.startIndex, offsetBy: third)
                let thirdCharEnd    = template.index(template.endIndex,   offsetBy: -fourth)
                let fourthCharStart = template.index(template.startIndex, offsetBy: fourth)
                let fourthCharEnd   = template.index(template.endIndex,   offsetBy: -third)
                let fifthCharStart  = template.index(template.startIndex, offsetBy: fifth)
                let fifthCharEnd    = template.index(template.endIndex,   offsetBy: -second)
                let sixthCharStart  = template.index(template.startIndex, offsetBy: sixth)
                let sixthCharEnd    = template.index(template.endIndex,   offsetBy: -first)

                let char1 = template[firstCharStart..<firstCharEnd]
                let char2 = template[secondCharStart..<secondCharEnd]
                let char3 = template[thirdCharStart..<thirdCharEnd]
                let char4 = template[fourthCharStart..<fourthCharEnd]
                let char5 = template[fifthCharStart..<fifthCharEnd]
                let char6 = template[sixthCharStart..<sixthCharEnd]
                print("6. chars: ",char1+char2+char3+char4+char5+char6)

                if  char1 == char2 ||
                    char1 == char3 ||
                    char1 == char4 ||
                    char1 == char5 ||
                    char1 == char6 ||
                    char2 == char3 ||
                    char2 == char4 ||
                    char2 == char5 ||
                    char2 == char6 ||
                    char3 == char4 ||
                    char3 == char5 ||
                    char3 == char6 ||
                    char4 == char5 ||
                    char4 == char6 ||
                    char5 == char6
                { getGameWordWithNoDoubledLetters() }
                else
                { daWord = template }
            default:
                list4.shuffle()
                daWord = list4.randomElement() ?? "OOPS!"
                game.gameWord = daWord
                let first  = 0
                let second = 1
                let third  = 2
                let fourth = 3

                let template = daWord

                let firstCharStart  = template.index(template.startIndex, offsetBy: first)
                let firstCharEnd    = template.index(template.endIndex,   offsetBy: -fourth)
                let secondCharStart = template.index(template.startIndex, offsetBy: second)
                let secondCharEnd   = template.index(template.endIndex,   offsetBy: -third)
                let thirdCharStart  = template.index(template.startIndex, offsetBy: third)
                let thirdCharEnd    = template.index(template.endIndex,   offsetBy: -second)
                let fourthCharStart = template.index(template.startIndex, offsetBy: fourth)
                let fourthCharEnd   = template.index(template.endIndex,   offsetBy: -first)

                let char1 = template[firstCharStart..<firstCharEnd]
                let char2 = template[secondCharStart..<secondCharEnd]
                let char3 = template[thirdCharStart..<thirdCharEnd]
                let char4 = template[fourthCharStart..<fourthCharEnd]
                print("default. chars: ",char1+char2+char3+char4)

                if  char1 == char2 ||
                    char1 == char3 ||
                    char1 == char4 ||
                    char2 == char3 ||
                    char2 == char4 ||
                    char3 == char4
                { getGameWordWithNoDoubledLetters() }
                else
                { daWord = template }
        }
    }
} // end extension ViewController...

extension StringProtocol where Index == String.Index
{
    func nsRange(from range: Range<Index>) -> NSRange
    { return NSRange(range, in: self) }
}

extension UITextField
{
    @objc func checkMaxLength(textField: UITextField)
    {
        guard let prospectiveText = self.text, prospectiveText.count > maxLength
        else
        { return }

        let selection = selectedTextRange

        let indexEndOfText = prospectiveText.index(prospectiveText.startIndex, offsetBy: maxLength)
        let substring = prospectiveText[..<indexEndOfText]
        text = String(substring)
        selectedTextRange = selection
    }
}
