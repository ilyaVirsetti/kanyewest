using HorizonSideRobots
include("functions.jl")

r = Robot(11, 12, animate = true)
function checkerboard_line!(robot, side)
    if !isborder(robot, side)
        move!(robot, side)
        no_delated_action!(robot, side)
    end
end

function no_delated_action!(robot, side)
    if !isborder(robot, side)
        putmarker!(robot)
        move!(robot, side)
        checkerboard_line!(robot, side)
    else
        putmarker!(robot)
    end
end

checkerboard_line!(r, Nord)
checkerboard_line!(r, Ost)
