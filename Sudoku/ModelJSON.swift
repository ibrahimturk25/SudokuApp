import Foundation

struct SaveMatrix: Codable {
    var trueMatrix: [[Int]] = []
    var falseMatrix: [[Int]] = []
    var arrayRandomNumber: [Int] = []
    var correctArray: [Int] = []
    var wrongArray: [Int] = []
    var score: Int = 0
}


struct JsonData {
    func getJsonFile() -> ([[Int]],[[Int]],[Int],[Int],[Int],Int) {
        let decoder = JSONDecoder()

        do {
            // Belge dizinini al
            if let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
                // Dosyanın tam yolunu manuel olarak oluştur
                let jsonFilePath = documentsDirectory.appendingPathComponent("Resume.json")

                // Dosya var mı kontrol et
                if FileManager.default.fileExists(atPath: jsonFilePath.path) {
                    // Dosya varsa veriyi oku
                    let jsonData = try Data(contentsOf: jsonFilePath)
                    let jsonObject = try decoder.decode(SaveMatrix.self, from: jsonData)

                    let trueMatrix = jsonObject.trueMatrix
                    let falseMatrix = jsonObject.falseMatrix
                    let randomArray = jsonObject.arrayRandomNumber
                    let correctArray = jsonObject.correctArray
                    let wrongArray = jsonObject.wrongArray
                    let score = jsonObject.score
                    
                    return (trueMatrix,falseMatrix,randomArray,correctArray,wrongArray,score)
                
                } else {
                    print("Resume.json dosyası bulunamadı.")
                }
            }
        } catch {
            print("JSON dosyasını okuma ve çözme hatası: \(error)")
        }
        return ([],[],[],[],[],0)
    }

    func setJsonFile(trueMatrix: [[Int]],falseMatrix: [[Int]], randomArray: [Int],correctArray: [Int],wrongArray: [Int],score: Int) {
        let encoder = JSONEncoder()
//        encoder.outputFormatting = .prettyPrinted

        do {
            let saveMatrix = SaveMatrix(trueMatrix: trueMatrix,falseMatrix: falseMatrix,arrayRandomNumber: randomArray,correctArray: correctArray,wrongArray: wrongArray,score: score)

            // Belge dizinini al
            if let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
                // Dosyanın tam yolunu manuel olarak oluştur
                let jsonFilePath = documentsDirectory.appendingPathComponent("Resume.json")

                // Veriyi dosyaya yaz
                try encoder.encode(saveMatrix).write(to: jsonFilePath)
                
                print("Veriler başarıyla güncellendi. Dosya Yolu: \(jsonFilePath)")
            }
        } catch {
            print("JSON dosyasına yazma hatası: \(error)")
        }
    }
}
