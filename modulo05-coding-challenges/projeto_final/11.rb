def max_area(height)
  ptr1 = 0
  ptr2 = height.size - 1

  max_water = current_water = 0

  while ptr1 <= ptr2
    width = (ptr1 - ptr2).abs
    if height[ptr1] < height[ptr2]
      water_level = height[ptr1]
      ptr1 += 1
    else
      water_level = height[ptr2]
      ptr2 -= 1
    end

    current_water = width * water_level
    max_water = current_water if current_water > max_water
  end

  max_water
end
