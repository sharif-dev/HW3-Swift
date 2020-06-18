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
        var currentIndex = 0
        while currentIndex < characters.count, let child = currentNode.children[characters[currentIndex]] {
            currentIndex += 1
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
    var currentIndex = 0
    while currentIndex < characters.count {
        let character = characters[currentIndex]

        if let child = currentNode.children[character] {
            currentNode = child
        } else {
            currentNode.add(newChild: character)
            currentNode = currentNode.children[character]!
        }
        currentIndex += 1
    }
    currentNode.leafNode = true
  }
}