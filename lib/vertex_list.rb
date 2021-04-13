# frozen_string_literal: true

require_relative '../lib/square'
require_relative '../lib/piece'

# The list of squares on the chessboard
class VertexList
  attr_reader :vertex_array

  def initialize
    @vertex_array = []
    build_vertex_list
    @size = @vertex_array.length
    @vertex_array = index_adjacents
  end

  def square(column, row)
    sq = @vertex_array.select { |square| square.column == column && square.row == row }
    sq[0]
  end

  def build_vertex_list
    8.times do |column|
      8.times do |row|
        @vertex_array.push(Square.new(column + 1, row + 1))
      end
    end
  end

  def breadth_first_search(start_pos, end_pos)
    start_pos_index = @vertex_array.index { |square| square.position == start_pos }
    end_pos_index = @vertex_array.index { |square| square.position == end_pos }

    prev = solve(start_pos_index)

    reconstruct_path(start_pos_index, end_pos_index, prev)
  end

  private

  def solve(start)
    queue = []
    queue.push(start)

    visited = Array.new(@size, false)
    visited[start] = true

    manage_queue(queue, visited, Array.new(@size, nil))
  end

  def reconstruct_path(_start, end_, prev)
    path = []
    add_to_path(path, end_, prev)
    path.reverse
  end

  def manage_queue(queue, visited, prev)
    return prev if queue.empty?

    node = queue.shift
    neighbours = @vertex_array[node].piece.adjacents
    neighbours.each do |neighbour|
      next if visited[neighbour]

      queue.push(neighbour)
      visited[neighbour] = true
      prev[neighbour] = node
    end
    manage_queue(queue, visited, prev)
  end

  def add_to_path(path, node, prev)
    return path if node.nil?

    path.push(node)
    add_to_path(path, prev[node], prev)
  end

  def index_adjacents
    @vertex_array.each do |square|
      p 'Hello!'
      next if square.piece.nil?

      square.piece.adjacents = square.piece.adjacents.map do |position|
        @vertex_array.index { |sq| sq.position == position }
      end
    end
  end
end
