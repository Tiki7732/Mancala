class Board
  attr_accessor :cups, :name1, :name2

  def initialize(name1, name2)
    @cups = Array.new(14)
    place_stones
    @name1, @name2 = name1, name2
  end

  def place_stones
    cups.each.with_index do |cup, index|
      cups[index] = [:stone, :stone, :stone, :stone] unless index == 6 || index == 13
      cups[index] = [] if index == 6 || index == 13
    end
  end

  def valid_move?(start_pos)
    raise "Invalid starting cup" if !start_pos.between?(0, cups.length)
    raise "Starting cup is empty" if cups[start_pos].empty?
    
  end

  def make_move(start_pos, current_player_name)
    stone_count = cups[start_pos].count
    cups[start_pos] = []
    next_pos = (start_pos + 1) % cups.count
    p1 = current_player_name == name1 ? true : false
    stone_count.times do 
      if p1
        next_pos = 0 if next_pos == 13
      else
        next_pos = 7 if next_pos == 6 
      end
      cups[next_pos].push(:stone)
      next_pos = (next_pos + 1) % cups.count 
    end
    ending_cup_idx = next_pos - 1 unless next_pos == 0
    ending_cup_idx = 13 if next_pos == 0
    self.render
    next_turn(ending_cup_idx)
        
  end

  def next_turn(ending_cup_idx)
   return :prompt if ending_cup_idx == 6 || ending_cup_idx == 13
   return :switch if cups[ending_cup_idx].count == 1
   return ending_cup_idx 
  end

  def render
    print "      #{@cups[7..12].reverse.map { |cup| cup.count }}      \n"
    puts "#{@cups[13].count} -------------------------- #{@cups[6].count}"
    print "      #{@cups.take(6).map { |cup| cup.count }}      \n"
    puts ""
    puts ""
  end

  def one_side_empty?
    return true if cups[0..5].all?{|cup| cup.empty?}
    return true if cups[7..12].all?{|cup| cup.empty?}
    false
  end

  def winner
    p1_score = cups[6].count
    p2_score = cups[13].count

    return :draw if p1_score == p2_score
    winner = p1_score > p2_score ? name1 : name2
    return winner
  end
end


