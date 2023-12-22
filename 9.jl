using HorizonSideRobots
include("functions.jl")

r = Robot("untitled9.sit", animate = true)
mark_chess_along!(robot, side, state)
function mark_chess_along!(robot, side, state)
    while !isborder(robot, side)
        if state == 1
            putmarker!(robot)
        end
        state = (state + 1) % 2
        move!(robot, side)
    end
    return state
end

function chess_field!(robot)
    putmarker!(robot)
    Nord_num_steps = numsteps_along!(robot, Sud)
    Ost_num_steps = numsteps_along!(robot, West)
    num_steps = Nord_num_steps + Ost_num_steps
    if num_steps % 2 == 0
        state = 1
    else
        stete = 0
    end
    side = Ost
    while !isborder(robot, Nord)
        state = mark_chess_along!(robot, side, state)
        if state == 1
            putmarker!(robot)
            move!(robot, Nord)
        else
            move!(robot, Nord)
        end
        state = (state + 1) % 2
        side = inverse(side)
    end
    mark_chess_along!(robot, side, state)
    putmarker!(robot)
    along!(robot, (Sud, West))
    along!(robot, Nord, Nord_num_steps)
    along!(robot, Ost, Ost_num_steps)
end

chess_field!(r)
