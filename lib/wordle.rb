
class Wordle

  def initialize filename
    load_words filename
  end

  def load_words filename
    words = JSON.parse(File.read(filename))
    #testing
    #words = words[0..100]

    # Hash of hash of arrays
    whohoa = Hash.new{|h,k| h[k] = Hash.new {|h,k| h[k] = [] } }
    @positionalchar = Hash.new {|h,k| h[k] = Hash.new {|h,k| h[k] = [] } }
    @nonpositionalchar = Hash.new {|h,k| h[k] = [] }
    # initialize (not necessary, but it's nice to see things stored
    # in alphabetical order, as well as see empty entries
    "ABCDEFGHIJKLMNOPQRSTUVWXYZ".chars.each do |char|
      @nonpositionalchar[char] = []
      @positionalchar[char][0] = []
      @positionalchar[char][1] = []
      @positionalchar[char][2] = []
      @positionalchar[char][3] = []
      @positionalchar[char][4] = []
    end
    words.each do |word|
      word.chars.each_with_index do |char, i|
        whohoa[word][char] << i
        @nonpositionalchar[char] << word
        @positionalchar[char][i] << word
      end
    end
    # dedup @nonpositionalchar
    @nonpositionalchar.each{|c,w| w.uniq!}

  end

  def get_words input, positional
    # inputs like 
    # AUDIO
    # A_D__
    wordsets = Array.new
    if positional == true
      input.chars.each_with_index do |char, i|
        if char.match /[A-Z]/
          wordsets << Set.new(self.words(char.upcase, i))
        end
      end
    else
      input.chars.each do |char|
        if char.match /[A-Z]/
          wordsets << Set.new(self.words(char.upcase))
        end
      end
    end
    return self.get_intersection(wordsets)
  end

  private

  def get_intersection wordsets
      case wordsets.count
      when 0
        return []
      when 1
        return wordsets[0]
      when 2
        return wordsets[0] & wordsets[1]
      when 3
        return wordsets[0] & wordsets[1] & wordsets[2]
      when 4
        return wordsets[0] & wordsets[1] & wordsets[2] & wordsets[3]
      when 5
        return wordsets[0] & wordsets[1] & wordsets[2] & wordsets[3] & wordsets[4]
      else
        return "Error"
      end
    
  end
 
  def words char, pos=-1
    if pos < 0 || pos > 4
      @nonpositionalchar[char]
    else
      @positionalchar[char][pos]
    end
  end

end
