-- This file contains collision detection functions

function boxbox(left1, right1, top1, bottom1, left2, right2, top2, bottom2)
	if (bottom1 < top2) or (top1 > bottom2) or (right1 < left2) or (left1 > right2) then
		return(false)
	end
    return(true)
end

function boxpoint(left, right, top, bottom, x, y)
	if (x < left) or (x > right) or (y < top) or (y > bottom)  then
		return(false)
	end
	return(true)
end

function boxline(left, right, top, bottom, x1, y1, x2, y2)
	deltax = x2 - x1
	deltay = y2 - y1
	err = 0
	deltaerr = math.abs(deltay / deltax) -- Devide by zero
	y = y1
	for x=x1,x2 do
		if boxpoint(left, right, top, bottom, x, y) then
			return(true)
		end
		err = err + deltaerr
		if err >= 0.5 then
			y = y + 1
			err = err - 1
		end
	end
	return(false)
end

-- for the object collision to work the object table must have:
--- x
--- y
--- col_x_offset
--- col_y_offset
--- col_w
--- col_h
function getColBox(object)
    left = object.x + object.col_x_offset
    right = left + object.col_w
    top = object.y + object.col_y_offset
    bottom = top + object.col_h
	return left, right, top, bottom
end

function objline(object, x1, y1, x2, y2)
	left, right, top, bottom = getColBox(object)
	return boxline(left, right, top, bottom, x1, y1, x2, y2)
end
