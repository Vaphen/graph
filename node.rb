class Node
	attr_accessor :value
	attr_accessor :edges
	attr_accessor :weight
	attr_accessor :id

	def initialize(value = "", id = 0)
		@id = id
		@edges = Array.new
		@weight = Array.new
		@value = value
	end

	def addEdge(destination = -1, weight = 1)
		if destination < 0 || weight < 1
			return
		end
		@edges.push destination
		@weight.push weight
	end
end
