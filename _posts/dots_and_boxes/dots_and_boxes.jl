using Revise
using Random

# TODO add take-back function


mutable struct Move
    player::String
    location::Vector{Int}
end


mutable struct Element
    type::String
    status::String
end


mutable struct Game
    grid::Matrix{Element}
    size::Int
    player::String
    players::Vector{String}
    score::Vector{Int}
    grid_history::Vector{Matrix{Element}}
    move_history::Vector{Move}
    # TODO add current scores
    # TODO add grid size
end


function Game(n::Int, players::Vector{String})
    grid = new_grid(n)
    return Game(grid, players[1], [grid], [], players)
end


function new_grid(n::Int)

    N = 2 * n - 1
    grid = Array{Element}(undef, (N, N))

    for i in 1:N
        for j in 1:N
            if i % 2 == 1
                if j % 2 == 1
                    grid[i,j] = Element("dot", "empty")
                else
                    grid[i,j] = Element("line_h", "empty")
                end
            else
                if j % 2 == 1
                    grid[i,j] = Element("line_v", "empty")
                else
                    grid[i,j] = Element("box", "empty")
                end
            end
        end
    end

    return grid
end


function display_element(element::Element)

    if element.type == "dot"
        print(" . ")

    elseif element.type == "line_h"
        if element.status == "empty"
            print("   ")
        else
            print(" - ")
        end

    elseif element.type == "line_v"
        if element.status == "empty"
            print("   ")
        else
            print(" | ")
        end

    elseif element.type == "box"
        if element.status == "A"
            print(" A ")
        elseif element.status == "B"
            print(" B ")
        else
            print("   ")
        end
    end

end


function display_grid(grid::Array{Element})

    N = size(grid)[1]

    for i in 1:N
        for j in 1:N
            display_element(grid[i,j])
        end
        print("\n")
    end
    print("\n\n")
end


function increment(xs, x)

    idx = findfirst(a->a==x)
    if idx < length(xs)
        return xs[idx+1]
    elseif idx == length(xs)
        return xs[1]
    end
end


function make_move(game, move)

    i = location[1]
    j = location[2]

    if game.grid_current[i, j].type in ["line_h", "line_v"]
        if game.grid_current[i, j].status == "empty"

            game.grid_current[i, j].status = player
            update_boxes(game, move)
            # TODO update score here

            game.player_current = increment(game.players, game.player_current)
            push!(game.grid_history, game.grid_current)
            push!(game.move_history, move)

            return nothing
        end
    end

    error("invalid move location")
end


function check_box_is_full(grid, location)

    i = location[1]
    j = location[2]

    @assert grid[i,j].type == "box"

    if grid[i,j].status == "empty"
        if grid[i-1, j].status != "empty"
            if grid[i+1, j].status != "empty"
                if grid[i, j-1].status != "empty"
                    if grid[i, j+1].status != "empty"
                        return true
                    end
                end
            end
        end
    end

    return false

end



function update_boxes(game, move)

    N = size(game.grid_current)[1]

    for i in 1:N
        for j in 1:N
            if game.grid_current[i,j].type == "box"
                if check_box_is_full(game.grid_current, [i,j])
                    game.grid_current[i,j].status = move.player
                end
            end
        end
    end
end


function make_random_move(game, player)

    # TODO doesnt need to depend on player
    N = size(game.grid_current)[1]
    is = shuffle(1:N)
    js = shuffle(1:N)

    for i in is
        for j in js
            try
                move = Move(player, [i,j])
                make_move(game, move)
                return nothing
            catch
            end
        end
    end

    error("no legal moves")

end


function make_first_available_move(game, player)

    # TODO doesnt need to depend on player
    N = size(game.grid_current)[1]

    for i in 1:N
        for j in 1:N
            try
                move = Move(player, [i,j])
                make_move(game, move)
                return nothing
            catch
            end
        end
    end

    error("no legal moves")

end


function get_score(grid)

    N = size(grid)[1]
    score_A = 0
    score_B = 0

    for i in 1:N
        for j in 1:N
            if grid[i,j].type == "box"
                if grid[i,j].status == "A"
                    score_A += 1
                elseif grid[i,j].status == "B"
                    score_B += 1
                end
            end
        end
    end

    return Dict("A"=>score_A, "B"=>score_B)

end





n = 5
grid = Game(n, ["A", "B"])

for i in 1:1000
    make_random_move(grid, "A")
    #make_first_available_move(grid, "A")
    display_grid(grid)
    make_random_move(grid, "B")
    #make_first_available_move(grid, "B")
    display_grid(grid)
    score = get_score(grid)
    println("A: ", score["A"])
    println("B: ", score["B"])
end
