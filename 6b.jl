include("robot.jl")
include("functions.jl")

r = field_6()
function move_to_angle!(robot, sides::NTuple{2, HorizonSide})::Array
    path = Tuple{HorizonSide, Int}[]
    side = sides[1]
    while !isborder(robot, sides[1]) || !isborder(robot, sides[2])
        pushfirst!(path, (inverse(side), num_steps_along!(robot, side)))
        if side == sides[1]
            side = sides[2]
        else
            side = sides[1]
        end
    end
    return path
end

function get_point_and_return!(robot, path::Array, main_side::HorizonSide)
    num_steps = 0
    for side in path
        if side[1] == main_side
            num_steps += side[2]
        end
    end
    along!(robot, main_side, num_steps)
    putmarker!(robot)
    along!(robot, inverse(main_side), num_steps)
end

function mark_four_positions!(robot)
    for sides in ((West, Sud), (Nord, West), (Ost, Nord), (Sud, Ost))
        path = move_to_angle!(robot, sides::NTuple{2, HorizonSide})
        get_point_and_return!(robot, path, inverse(sides[2]))
        move_to_back!(robot, path)
    end
end

mark_four_positions!(r)
