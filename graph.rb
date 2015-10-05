require './node.rb'

class Graph
	attr_accessor :nodes

	def initialize
		@nodes = Array.new	
		@todo = Array.new
		@done = Array.new
	end

	def addNode(nodeValue = "")
		@nodes.push Node.new(nodeValue, nodes.size)
	end

	def fordBellman(startNode = 0)
		minNodeWeight = Array.new(@nodes.size)
		for k in 0..minNodeWeight.size - 1
			minNodeWeight[k] = 1000
		end
		minNodeWeight[startNode] = 0
		
		for runs in 0..@nodes.size - 1
			@nodes.each do |node|
				for i in 0..node.edges.size - 1
					if(minNodeWeight[node.id] + @nodes[node.id].weight[i] < minNodeWeight[@nodes[node.id].edges[i]])
						minNodeWeight[@nodes[node.id].edges[i]] = minNodeWeight[node.id] + @nodes[node.id].weight[i]
					end
				end
			end
		end
		return minNodeWeight
	end

	def depthSearch(curNodeId = 0, value = "")			
		if @nodes[curNodeId].value == value
			return curNodeId
		end
		@done.push curNodeId
	
		nodes[curNodeId].edges.each do |destNodeId|
			if !@done.include? destNodeId and !@todo.include? destNodeId
				@todo.push destNodeId		
			end	
		end
		if @todo.size == 0
			if @done.size == @nodes.size
				return -1
			else
				@nodes.each do |node|
					if !@done.include? node.id
						return depthSearch(node.id, value)
					end
				end
			end
		else
			return depthSearch(@todo.pop, value)
		end
	end
end







if __FILE__ == $0
	myGraph = Graph.new

	puts "\n#############"
	puts "# Graphomat #"
	puts "#############"
	while true
		puts "\nMenu:"
		puts "1) Graph anzeigen"
		puts "2) Testgraph erstellen"
		puts "3) Knoten hinzufügen"
		puts "4) Kante hinzufügen"
		puts "5) Aktuellen Graph löschen"
		puts "6) Beenden"
		print "Wahl: "
		choice = gets
	
		if choice[0] ==  "1"
			if(myGraph.nodes.size == 0)
				puts "No Graph existant right now"
			end
			myGraph.nodes.each do |node|
				puts node.id.to_s + ") " + node.value.to_s
				for i in 0..node.edges.size - 1 
					puts "\tEdge to: " + node.edges[i].to_s + " with weight " + node.weight[i].to_s
				end
			end
		elsif choice[0] == "2"	
			if myGraph.nodes.size != 0
				puts "Es ist bereits ein Graph in bearbeitung.\nEs wird kein neuer erstellt."
				next
			end
			myGraph.addNode("Peter0")
			myGraph.addNode("Hannes1")
			myGraph.addNode("Klementine2")
			myGraph.addNode("Karoline3")
			myGraph.addNode("Jörg4")
			myGraph.addNode("Friedrich5")
			myGraph.addNode("Mayer6")
			myGraph.nodes[0].addEdge(5, 2)
			myGraph.nodes[1].addEdge(4, 6)
			myGraph.nodes[1].addEdge(3, 4)
			myGraph.nodes[2].addEdge(5, 1)
			myGraph.nodes[2].addEdge(4, 2)
			myGraph.nodes[3].addEdge(4, 5)
			myGraph.nodes[3].addEdge(1, 4)
			myGraph.nodes[4].addEdge(1, 6)
			myGraph.nodes[4].addEdge(2, 2)
			myGraph.nodes[4].addEdge(3, 5)
			myGraph.nodes[4].addEdge(5, 1)
			myGraph.nodes[5].addEdge(0, 2)
			myGraph.nodes[5].addEdge(2, 1)
			myGraph.nodes[5].addEdge(4, 1)
			puts "Graph erstellt"
		elsif choice[0] == "3"
			print "\tKnotenname: "
			name = gets
			myGraph.addNode(name)
			puts "Knoten hinzugefügt"
		elsif choice[0] == "4"
			print "\tKante von Knoten: "
			from = Integer
			print "\tKante zu Knoten: "
			to = gets
			print "\tKantengewicht: "
			weight = gets
			myGraph.nodes[from].addEdge to, weight
		elsif choice[0] == "5"
			myGraph = Graph.new
		elsif choice[0] == "6"
			break
		end
	end
	
	bellmanresult = myGraph.fordBellman(0)
	puts "Bellman-Ford (Von Knoten 0 zu folgenden Knoten): "
	for i in 0..bellmanresult.size - 1
		puts i.to_s + ") shortest path: " + bellmanresult[i].to_s
	end
	puts "Result of Search: " + myGraph.depthSearch(5, "Hannes1").to_s
end
