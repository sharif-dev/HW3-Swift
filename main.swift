class TrieNode {
    var value: Character?
    weak var parent: TrieNode?
    var leafNode = false
    var children: [Character: TrieNode] = [:]
  
    init(value: Character? = nil, parent: TrieNode? = nil) {
        self.value = value
        self.parent = parent
    }

    func add(newChild: Character) {
        guard children[newChild] == nil else { return }
        children[newChild] = TrieNode(value: newChild, parent: self)
    }
}


class Trie {
    fileprivate let root: TrieNode

    init() {
        root = TrieNode()
    }

    func contains(word: String) -> Bool {
        guard !word.isEmpty else { return true }
        var currentNode = root

        let characters = Array(word.characters)
        var currentNodeIndex = 0
        while currentNodeIndex < characters.count, let child = currentNode.children[characters[currentNodeIndex]] {
            currentNodeIndex += 1
            currentNode = child
        }

        if currentNode.leafNode {
            return true
        }
        return false
    }

    func insert(word: String) {
    guard !word.isEmpty else { return }
    var currentNode = root

    let characters = Array(word.characters)
    var currentNodeIndex = 0
    while currentNodeIndex < characters.count {
        let character = characters[currentNodeIndex]

        if let child = currentNode.children[character] {
            currentNode = child
        } else {
            currentNode.add(newChild: character)
            currentNode = currentNode.children[character]!
        }
        currentNodeIndex += 1
    }
    currentNode.leafNode = true
  }
}

func findWord(table: [[Character]], seen: inout [[Bool]], i: Int, j: Int ,trieNode: TrieNode, word: inout String) {
    word.append(trieNode.value!)
    guard !trieNode.leafNode else { 
        return
    }
    let rows = table.count
    let columns = table[0].count
    seen[i][j] = true
    if i - 1 >= 0 {
        if j - 1 >= 0 {
            for childCharacter in trieNode.children.keys {
                if !seen[i-1][j-1], childCharacter == table[i-1][j-1] {
                    var wordTemp = word
                    var seenTemp = seen
                    findWord(table: table,seen: &seenTemp, i: i - 1, j: j - 1, trieNode: trieNode.children[childCharacter]!, word: &wordTemp)
                    if wordTemp != "" {
                        print(wordTemp)
                    }
                }
            }
        }        
        for childCharacter in trieNode.children.keys {
            if !seen[i-1][j], childCharacter == table[i-1][j] {
                var wordTemp = word
                var seenTemp = seen
                findWord(table: table,seen: &seenTemp, i: i - 1, j: j, trieNode: trieNode.children[childCharacter]!, word: &wordTemp)
                if wordTemp != "" {
                        print(wordTemp)
                }
            }
        }
        if j + 1 < columns {
            for childCharacter in trieNode.children.keys {
                if !seen[i-1][j+1], childCharacter == table[i-1][j+1] {
                    var wordTemp = word
                    var seenTemp = seen
                    findWord(table: table,seen: &seenTemp, i: i - 1, j: j + 1, trieNode: trieNode.children[childCharacter]!, word: &wordTemp)
                    if wordTemp != "" {
                        print(wordTemp)
                    }
                }
            }
        }
    }
    if j - 1 >= 0 {
        for childCharacter in trieNode.children.keys {
            if !seen[i][j-1], childCharacter == table[i][j-1] {
                var wordTemp = word
                var seenTemp = seen
                findWord(table: table,seen: &seenTemp, i: i, j: j - 1, trieNode: trieNode.children[childCharacter]!, word: &wordTemp)
                if wordTemp != "" {
                        print(wordTemp)
                }
            }
        }
    }
    if j + 1 < columns {
        for childCharacter in trieNode.children.keys {
            if !seen[i][j+1], childCharacter == table[i][j+1] {
                var wordTemp = word
                var seenTemp = seen
                findWord(table: table,seen: &seenTemp, i: i, j: j + 1, trieNode: trieNode.children[childCharacter]!, word: &wordTemp)
                if wordTemp != "" {
                        print(wordTemp)
                }
            }
        }
    }
    if i + 1 < rows {
        if j - 1 >= 0 {
            for childCharacter in trieNode.children.keys {
                if !seen[i+1][j-1], childCharacter == table[i+1][j-1] {
                    var wordTemp = word
                    var seenTemp = seen
                    findWord(table: table,seen: &seenTemp, i: i + 1, j: j - 1, trieNode: trieNode.children[childCharacter]!, word: &wordTemp)
                    if wordTemp != "" {
                        print(wordTemp)
                    }
                }
            }
        }
        for childCharacter in trieNode.children.keys {
            if !seen[i+1][j], childCharacter == table[i+1][j] {
                var wordTemp = word
                var seenTemp = seen
                findWord(table: table,seen: &seenTemp, i: i + 1, j: j, trieNode: trieNode.children[childCharacter]!, word: &wordTemp)
                if wordTemp != "" {
                    print(wordTemp)
                }
            }
        }
        if j + 1 < columns {
            for childCharacter in trieNode.children.keys {
                if !seen[i+1][j+1], childCharacter == table[i+1][j+1] {
                    var wordTemp = word
                    var seenTemp = seen
                    findWord(table: table,seen: &seenTemp, i: i + 1, j: j + 1, trieNode: trieNode.children[childCharacter]!, word: &wordTemp)
                    if wordTemp != "" {
                        print(wordTemp)
                    }
                }
            }
        } 
    }
}


let trie = Trie()
var rows = 0
var columns = 0

var input = readLine(strippingNewline: true)?
    .split {$0 == " "}
    .map (String.init)

if let words = input {
    for word in words {
        trie.insert(word: word)
    }
}

input = readLine()?
    .split {$0 == " "}
    .map (String.init)

if let numbers = input {
    rows = Int(numbers[0])!
    columns = Int(numbers[1])!
}


var table = [[Character]]()
for _ in 0...rows-1 {
    var letters = [Character]()
    let line = readLine(strippingNewline: true)!

    for char in line {
        if char != " " {
            letters.append(char)
        }
    }
    table.append(letters)
}

var word = ""
for i in 0...rows-1 {
    for j in 0...columns-1 {
        for key in trie.root.children.keys {
            if key == table[i][j] {
                word = ""
                var seen = Array(repeating: Array(repeating: false, count: columns), count: rows)
                findWord(table: table,seen: &seen, i: i, j: j, trieNode: trie.root.children[key]!, word: &word)
            }
        }
    }
}