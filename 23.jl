using HorizonSideRobots
include("functions.jl")

r = Robot("ilyha2009.sit", animate = true)

function recursion_along!(robot, side)
    if !isborder(robot, side)
        move!(robot, side)
        recursion_along!(robot, side)
    end
end

function to_symmetric_position!(robot, side)
    if !isborder(robot, inverse(side))
        move!(robot, inverse(side))
        to_symmetric_position!(robot, side)
        move!(robot, inverse(side))
    else
        recursion_along!(robot, side)
    end
end

to_symmetric_position!(r, West)
