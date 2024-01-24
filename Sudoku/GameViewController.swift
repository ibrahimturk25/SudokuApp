
import UIKit

class GameViewController: UIViewController {
    @IBOutlet weak var labelScore: UILabel!
    @IBOutlet var textFieldCollection: [UITextField]!
    var boolean = false
    var originalColor: UIColor!
    var randomArray: [Int] = []
    var wrongColorArray: [Int] = []
    var correctColorArray: [Int] = []
    var matriks: [[Int]]!
    var userMatrix: [[Int]]!
    var textDictionary = [Int: String]()
    var score = 0
    var i: Int = 0
    var j: Int = 0
    var difficulty = 0
    var checkButton = true
    let matrixStruct = createMatrix()
    let jsonMatrix = JsonData()
    let customInputView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.delegate = self
        if difficulty == 0 {
            matriks = jsonMatrix.getJsonFile().0
            userMatrix = jsonMatrix.getJsonFile().1
            randomArray = jsonMatrix.getJsonFile().2
            correctColorArray = jsonMatrix.getJsonFile().3
            score = jsonMatrix.getJsonFile().5
            labelScore.text = String(score)
        }else{
            randomArray = matrixStruct.createRandNumber(randomCount: difficulty)
            matriks = matrixStruct.createMatrix()
            userMatrix = matriks
            jsonMatrix.setJsonFile(trueMatrix: matriks, falseMatrix: userMatrix, randomArray: randomArray,correctArray: correctColorArray,wrongArray: wrongColorArray,score: score)
            labelScore.text = String(score)

        }
        deleteText()
    }

    func deleteText(){
        let sortedTextViews = textFieldCollection.sorted{$0.tag < $1.tag}
   
        for textFieldCollection in sortedTextViews{
            textFieldCollection.textColor = .white
            textFieldCollection.tintColor = .clear
            if correctColorArray.contains(textFieldCollection.tag){ //Dizi kontrol
                textFieldCollection.textColor = .orange
                textFieldCollection.isEnabled = false
            }
            if wrongColorArray.contains(textFieldCollection.tag){
                textFieldCollection.textColor = .red
            }
            jsonMatrix.setJsonFile(trueMatrix: matriks, falseMatrix: userMatrix, randomArray: randomArray,correctArray: correctColorArray,wrongArray: wrongColorArray,score: score)
            textFieldCollection.inputView = customInputView  //burada klavye yerine Başka bir View açıyoruz
            textFieldCollection.delegate = self
            textFieldCollection.frame.size.width = 45
            textFieldCollection.frame.size.height = 45
            textFieldCollection.text = "\(userMatrix[i][j])"
            checkMatrix()
            for x in randomArray{
                if textFieldCollection.tag == x{
                    textDictionary[textFieldCollection.tag] = textFieldCollection.text!
                    textFieldCollection.text = ""
                }
            }
        }
        jsonMatrix.setJsonFile(trueMatrix: matriks, falseMatrix: userMatrix, randomArray: randomArray,correctArray: correctColorArray,wrongArray: wrongColorArray,score: score)
    }
    @IBAction func buttonClicked(_ sender: UIButton) {
        switch sender.titleLabel!.text {
        case "1":
            deneme(sender: sender)
        case "2":
            deneme(sender: sender)
        case "3":
            deneme(sender: sender)
        case "4":
            deneme(sender: sender)
        case "5":
            deneme(sender: sender)
        case "6":
            deneme(sender: sender)
        case "7":
            deneme(sender: sender)
        case "8":
            deneme(sender: sender)
        case "9":
            deneme(sender: sender)
        default:
            deneme(sender: sender)
        }
    }
    func deneme(sender: UIButton){
                for textField in textFieldCollection {
                    switch sender.titleLabel!.text {
                    case "X":
                        if textField.isFirstResponder{
                            textField.text = ""
                        }
                    default:
                        if textField.isFirstResponder && textField.text == "" {   // .isFirstResponder seçilen textField ile işlem yapar
                            print(randomArray)
                            textField.text = sender.titleLabel?.text
                            for key in textDictionary.keys{
                                if textField.tag == key{
                                    if textField.text == textDictionary[textField.tag]{
                                        textField.textColor = .orange
                                        textField.isEnabled = false
                                        correctColorArray.append(textField.tag)
                                        textDictionary.removeValue(forKey: textField.tag)
                                        if let index = randomArray.firstIndex(of: textField.tag) { // random array içerisindeki seçileni sildik
                                            randomArray.remove(at: index)
                                        }
                                        jsonMatrix.setJsonFile(trueMatrix: matriks, falseMatrix: userMatrix, randomArray: randomArray,correctArray: correctColorArray,wrongArray: wrongColorArray,score: score)
                                        if textDictionary.count == 0 {
                                            matrixStruct.createAlert(vc: self)
                                        }
                                    }
                                    else{
                                        textField.textColor = .red
                                        wrongColorArray.append(textField.tag)
                                    }
                                    textField.resignFirstResponder()
                                }
                            }
                        }
                    }
                }
            
        
    }
    func setRoundedBackground(for view: UIView) {       //yuvarlak arka plan için görünüm
                          
        view.backgroundColor = .gray
        view.frame.size.width = 40
        view.frame.size.height = 40
        view.layer.cornerRadius = view.frame.height / 2
        view.layer.masksToBounds = true
       }

    func checkMatrix(){
        j = j+1
        if j == 9 {
            j = 0
            i = i+1
            if i == 9{
                i = 0
            }
        }
    }
    
}



extension GameViewController: UITextFieldDelegate{
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField.text == "" || textField.textColor == .red || textField.textColor == .orange {
            originalColor = textField.backgroundColor
            setRoundedBackground(for: textField)
            boolean = true
        }else{
            textField.isEnabled = false
        }
   
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
      
        boolean = false
        textField.backgroundColor = originalColor
    }
}
extension GameViewController: UINavigationControllerDelegate{
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
//        NAVİGATİON CONTROLLER DA BACK TUŞUNA BASINCA YENİ BİR SAYFA AÇILMALI
        
    }
}
