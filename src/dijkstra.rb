require 'priority_queue'

class Graph
  def initialize()
    @vertices = {}
  end

  def add_vertex(name, edges)
    @vertices[name] = edges
  end

  def shortest_path(start, finish)
    maxint = (2**(0.size * 8 -2) -1) # our representation of infinity
    distances = {}
    previous = {}
    results = PriorityQueue.new

    # initialisation
    @vertices.each do |vertex, _|
      if vertex == start
        distances[vertex] = 0
        results[vertex] = 0
      else
        distances[vertex] = maxint
        results[vertex] = maxint
      end
      previous[vertex] = nil
    end

    # finding the shortest path
    while results
      smallest = results.delete_min_return_key

      # check if we have reached our finish goal
      if smallest == finish
        path = []
        while previous[smallest]
          path.push(smallest)
          smallest = previous[smallest]
        end
        return path
      end

      if smallest == nil || distances[smallest] == maxint
        break
      end

      @vertices[smallest].each do |neighbor, value|
        alt = distances[smallest] + value

        if alt < distances[neighbor]
          distances[neighbor] = alt
          results[neighbor] = alt
          previous[neighbor] = smallest
        end

      end
    end
    return distances.inspect
  end

  def to_s
    return @vertices.inspect
  end
end


g = Graph.new
g.add_vertex('A', {'B' => 7, 'C' => 8})
g.add_vertex('B', {'A' => 7, 'F' => 2})
g.add_vertex('C', {'A' => 8, 'F' => 6, 'G' => 4})
g.add_vertex('D', {'F' => 8})
g.add_vertex('E', {'H' => 1})
g.add_vertex('F', {'B' => 2, 'C' => 6, 'D' => 8, 'G' => 9, 'H' => 3})
g.add_vertex('G', {'C' => 4, 'F' => 9})
g.add_vertex('H', {'E' => 1, 'F' => 3})

puts g.shortest_path("A", "F")
puts "-------"
puts g.shortest_path("A", "H")
