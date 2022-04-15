//
//  TextReader.swift
//  BubbleWord
//
//  Created by 90307297 on 4/11/22.
//

import Foundation

extension String{
    func fileName() -> String{ //Seperates the name of a string from its file extension
        return URL(fileURLWithPath: self).deletingPathExtension().lastPathComponent
    }
    
    func fileExtension() -> String{ //Seperates the file extension of a string from its name
        return URL(fileURLWithPath: self).pathExtension
    }
}

func readFile(inputFile: String) -> String{ //Finds and reads the file from the given string
    
    //Makes a file name
    let fileExtension = inputFile.fileExtension()
    let fileName = inputFile.fileName()
    
    //Trys to find sed file
    let fileProject = Bundle.main.path(forResource: fileName, ofType: fileExtension)
    
    var readStringProject = ""
    
    do{ //Trys to read the contents of the file and put it into the string variable
        readStringProject = try String(contentsOfFile: fileProject!)
    } catch let errror as NSError{
        //If there was an error it prints it
        print(errror)
    }
    
    return readStringProject
}

func organize(data: String) -> [[String]]{//Organizes file data and sorts each word with the same first letter into the same array
    
    var wordGroups: [[String]] = [[]]
    
    var editedData = data[data.index(data.startIndex, offsetBy: 1)..<data.index(data.endIndex, offsetBy: -2)]
    
    var index = data.firstIndex(of: " ")
    
    var dataChunck: String = String(editedData[...editedData.index(index!, offsetBy: 1)])
    
    while index != nil{
        
        let newWord = getWord(word: dataChunck)
        
        editedData = editedData[editedData.index(editedData.startIndex, offsetBy: dataChunck.count)...]
        
        if (newWord[newWord.startIndex] == editedData[editedData.startIndex]){
            wordGroups[wordGroups.count - 1].append(newWord)
        }
        else {
            wordGroups[wordGroups.count - 1].append(newWord)
            wordGroups.append([])
        }
        
        index = editedData.firstIndex(of: " ")
         
        if(index != nil){
            dataChunck = String(editedData[...editedData.index(index!, offsetBy: 1)])
        }
        
    }
    wordGroups[wordGroups.count - 1].append(String(editedData))
    
    print(editedData)
    return wordGroups
}

func getWord(word: String) -> String{
    
    let index = word.firstIndex(of: "\"")
    
    let newWord = word[..<index!]
    
    return String(newWord)
}

func getCount(data: [[String]]) -> [Int]{ //Returns an array with the counts of a 2D arrays contents
    
    var count: [Int] = []
    
    for row in 0...count.count - 1 {
        count.append(data[row].count)
    }
    
    return count
}
