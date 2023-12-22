sing HorizonSideRobots
include("functions.jl")

r = Robot("untitled10.sit", animate = true)
function check_side!(robot, N, side) # Проверка влезает ли ещё одни квадрат
    flag = true
    num_steps = 0
    for _ in 1:(N-1)
        if isborder(robot, side)
            flag = false
            break
        end
        move!(robot, side)
        num_steps += 1
    end
    if flag
        along!(robot, inverse(side), N-1)
    else
        along!(robot, inverse(side), num_steps)
    end
    return flag
end
function num_steps_mark_along!(robot, direction, num_steps) # Специальная функция для putmarker!(robot, N)
    putmarker!(robot)
    for _ in 1:(num_steps-1)
        move!(robot, direction)
        putmarker!(robot)
    end
end
NxN_marker!(robot, N::Int)::Nothing
function NxN_marker_right!(robot, N::Int)::Nothing
    side = Ost
    for n in 1:N
        num_steps_mark_along!(robot, side, N)
        side = inverse(side)
        if n != N
            move!(robot, Nord)
        end
    end
    along!(robot, Sud, N-1)
    if inverse(side) == West
        along!(robot, Ost, N-1)
    end
end

function NxN_marker_left!(robot, N::Int)::Nothing
    side = West
    for n in 1:N
        num_steps_mark_along!(robot, side, N)
        side = inverse(side)
        if n != N
            move!(robot, Nord)
        end
    end
    along!(robot, Sud, N-1)
    if inverse(side) == Ost
        along!(robot, West, N-1)
    end
end
function mark_chess_field_N_along!(robot, N, state, side)
    while check_side!(robot, N + 1, side)
        if state == 1
            if side == Ost
                NxN_marker_right!(robot, N)
            else
                NxN_marker_left!(robot, N)
            end
            move!(robot, side)
        else
            along!(robot, side, N)
        end
        state = (state + 1) % 2
    end
    if check_side!(robot, N, side) && state == 1
        if side == Ost
            NxN_marker_right!(robot, N)
        else
            NxN_marker_left!(robot, N)
        end
        state = 0
    elseif check_side!(robot, N, side) && state == 0
        along!(robot, side, N-1)
        state = 1
    else
        move!(robot, inverse(side))
    end
    return state
end

function creating_chess_field!(robot, N)
    side = Ost
    state = 1
    while check_side!(robot, N + 1, Nord)
        state = mark_chess_field_N_along!(robot, N, state, side)
        side = inverse(side)
        along!(robot, Nord, N)
    end
    if check_side!(robot, N, Nord)
        mark_chess_field_N_along!(robot, N, state, side)
    end
    along!(robot, Sud)
    along!(robot, West)
end

function chess_field_N!(robot, N)
    path = move_to_angle!(robot, (Sud, West))
    creating_chess_field!(robot, N)
    move_to_back!(robot, path)
end

chess_field_N!(r, 2)
