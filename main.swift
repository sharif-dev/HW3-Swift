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
