# TODO import HorizonSideRobots as HSR
# TODO unify move[_...]! function interface (return path)

# XXX putmarker! after or before move?

using HorizonSideRobots


function inverse_side(side::HorizonSide)
    return HorizonSide((Int(side)+2)%4)
end


function move_till_border!(robot::Robot, side::HorizonSide)::Integer
    steps_till_border::Integer = 0

    while (!isborder(robot, side))
        HorizonSideRobots.move!(robot, side)
        steps_till_border += 1
    end

    return steps_till_border
end


# TODO [overload] ... move!(..., steps::Integer=1; ...)::Bool
function move_steps!(robot::Robot, side::HorizonSide, steps::Integer)::Bool
    while (steps > 0)
        if (!isborder(robot, side))
            HorizonSideRobots.move!(robot, side)
            steps -= 1
        else
            return false
        end
    end

    return true
end


# XXX what should this function return?
function mark_line!(robot::Robot, side::HorizonSide)::Integer
    steps_in_side::Integer = 0

    putmarker!(robot)
    while (!isborder(robot, side))
        move!(robot, side)
        steps_in_side += 1
        putmarker!(robot)
    end

    return steps_in_side
end