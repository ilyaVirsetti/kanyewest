include("robot.jl")
include("functions.jl")

r = field_6()
function move_to_angle!(robot)
    path = Tuple{HorizonSide, Int}[]
    side = Sud
    while !isborder(robot, Sud) || !isborder(robot, West)
        pushfirst!(path, (inverse(side), num_steps_along!(robot, side)))
        if side == Sud
            side = right(side)
        else
            side = left(side)
        end
    end
    return path
end

function mark_exter_rect!(robot)
    for side in (Ost, Nord, West, Sud)
        mark_along!(robot, side)
    end
end


function mark_extermal_rect!(robot) # !!! extermal и external разные слова не перепутай
    back_path = move_to_angle!(robot)
    mark_exter_rect!(robot)
    move_to_back!(robot, back_path)
end

mark_extermal_rect!(r)
