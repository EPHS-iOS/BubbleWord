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

func organize(data: String) -> [[String]]{
    
    let editedData = data[data.index(data.startIndex, offsetBy: 1)..<data.index(data.endIndex, offsetBy: -2)].lowercased()
    
    var lastWord = "a"
    
    var allWords: [String] = editedData.components(separatedBy: "\", \"")
    
    var wordGroups: [[String]] = [[]]
    
    while allWords.count > 0 {
        
        if(lastWord[lastWord.startIndex] != allWords[0][allWords[0].startIndex]){
            wordGroups.append([])
        }
        
        wordGroups[wordGroups.count - 1].append(allWords.removeFirst())
        
        lastWord = wordGroups[wordGroups.count - 1][wordGroups[wordGroups.count - 1].count - 1]
    }
    print(wordGroups.count)
    return wordGroups
}

func getCount(data: [[String]]) -> [Int]{ //Returns an array with the counts of a 2D arrays contents
    
    var count: [Int] = []
    
    for row in 0...count.count - 1 {
        count.append(data[row].count)
    }
    
    return count
}
