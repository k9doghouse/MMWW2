// https://github.com/k9doghouse/MMWW2.git
//  ViewController.swift
//  UITableViewCellCustom
//
//  Thanks: Lawrence F MacFadyen
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

var daWord : String = ""
var daGuess : String = ""
var daResult : String = ""
var daCount : Int = 0
var list : [String] = Four().four
var count : Int = 0
let cellIdentifier = "Cell"

var game = GamePlay(gameWord : "",
                    guess : "",
                    result : "",
                    guesses : [""],
                    results : [""],
    howManyLettersInTheWord: 4)

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate
{
    @IBOutlet var tableView: UITableView!
    @IBOutlet var textField: UITextField!

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
            print(game.howManyLettersInTheWord," letter word")
        case 1:
            game.howManyLettersInTheWord = 5
            print(game.howManyLettersInTheWord," letter word")
        case 2:
            game.howManyLettersInTheWord = 6
            print(game.howManyLettersInTheWord," letter word")
        default:
            print(game.howManyLettersInTheWord," letter word (default:)")
            break;
        }
    }

    @IBAction func allowDoubleLettersOrNotSwitch(_ sender: UISwitch)
    {

    }

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
            daCount += 1; print("daCount: ",daCount)
        }
    }
}// end class ViewController...

extension ViewController {
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
}

extension ViewController
{
    func clearTheBoard()
    {
        game.guesses.removeAll()
        game.results.removeAll()
        game = GamePlay(gameWord: "",
                        guess: "",
                        result: "",
                        guesses: [""],
                        results: [""],
                        howManyLettersInTheWord: 4)
        textField.text = "" 
        daWord = ""
        daGuess = ""
        daResult = ""
        count = 0
        tableView.reloadData()
    }
}

extension StringProtocol where Index == String.Index
{ func nsRange(from range: Range<Index>) -> NSRange
    { return NSRange(range, in: self) } }

extension ViewController
{
    func getGameWordWithNoDoubledLetters()
    {
        list.shuffle()
        daWord = list.randomElement() ?? "OOPS!"
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
    }
}
