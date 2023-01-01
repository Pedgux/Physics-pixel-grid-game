
debug=false--debug 
delay = 0.5
timer = delay
val = 1
-- Define the size of the grid
local rows = 34
local columns = 60
-- Define the size of each cell
local cell_size = 32

-- Create an empty grid
local grid = {}

-- Initialize all cells to zero
for row = 1, rows do
  grid[row] = {}
  for column = 1, columns do
    grid[row][column] = 0
  end
end



-- Define the colors for the grid lines and cells
local line_color = {0.5, 0, 1, 255}  -- black
local cell_color = {255, 255, 255, 255}  -- white


function love.load()
    -- Get the dimensions of the desktop
    desktop_width, desktop_height = love.window.getDesktopDimensions()
    
    love.mouse.setVisible(false)
    
    -- Set the window size to the dimensions of the desktop
    love.window.setMode(desktop_width, desktop_height)

end

function love.draw()
    -- Set the line width
    love.graphics.setLineWidth(1)
    -- Draw horizontal lines
    for row = 1, rows do
      love.graphics.setColor(line_color)
      love.graphics.rectangle("line", 0, (row-1)*cell_size, columns*cell_size, cell_size)
    end

    -- Draw vertical lines
    for column = 1, columns do
      love.graphics.setColor(line_color)
      love.graphics.rectangle("line", (column-1)*cell_size, 0, cell_size, rows*cell_size)
    end

    -- Draw squares in each cell
    for row = 1, rows do
      for column = 1, columns do
        love.graphics.setColor(0.5,0,1)
        love.graphics.rectangle("line", (column-1)*cell_size, (row-1)*cell_size, cell_size, cell_size)
        
        if grid[row][column] == 1 then
            -- Fill the cell with a white square if the value is 1
            love.graphics.setColor(1,0.9,0.5)
            love.graphics.rectangle("fill", (column-1)*cell_size, (row-1)*cell_size, cell_size, cell_size)
            
        end
        

        if grid[row][column] == 2 then
          -- Fill the cell with a white square if the value is 1
          love.graphics.setColor(0,0,1)
          love.graphics.rectangle("fill", (column-1)*cell_size, (row-1)*cell_size, cell_size, cell_size)
        end

        if grid[row][column] == 3 then
            -- Fill the cell with a white square if the value is 1
            love.graphics.setColor(1,0,0)
            love.graphics.rectangle("fill", (column-1)*cell_size, (row-1)*cell_size, cell_size, cell_size)
        end
          
        -- Draw the value of the cell in the center of the square
        love.graphics.setColor(1,1,1)
        love.graphics.printf(tostring(grid[row][column]), (column-1)*cell_size, (row-1)*cell_size, cell_size, "center")
      end
    end
end
  
--change the value of a cell manuall
function love.keypressed(key, scancode, isrepeat)
    if key == "escape" then
       love.event.quit()
    end
    if key == "e" then--change the value of val which is the variable used to determine what square to place
        val = val + 1
     end
     if key == "q" then
        val = val - 1
     end
end
--function to set a value to a cell
function setCell(row, column, value)
    grid[row][column] = value
end

delay = 0.025  -- Set the delay between updates
timer = delay  -- Initialize the timer

function love.update(dt)
    timer = timer - dt  -- Decrement the timer
  
    -- If the timer is less than zero
    if timer < 0 then
      -- Reset the timer
      timer = delay
  
      -- Update each cell in the grid
      for row = rows, 1, -1 do
        for column = 1, columns do
          if grid[row][column] == 1 then
            if row == rows then  -- If the cell is in the bottom row
              grid[row][column] = 1  -- Keep the sand in place
            elseif grid[row+1][column] == 0 then  -- If the cell below is empty
              grid[row+1][column] = 1  -- Move the sand down
              grid[row][column] = 0
            elseif grid[row+1][column-1] == 0 then -- If the cell to the bottom left is empty
              -- Move the sand left-down
            elseif grid[row+1][column+1] == 0 then -- If the cell to the bottom right is empty
              -- Move the sand right-down
            else -- If nothing is possible
              -- Keep the sand in place
            end
          end
        end
      end
    end
      --TODO: SIDEWAYS SAND STUFF
  

    --mouse position
    mouseX = love.mouse.getX()
    mouseY = love.mouse.getY()
    --convert mousex and y to grid x and y
    gridX = math.floor(mouseX / cell_size) + 1
    gridY = math.floor(mouseY / cell_size) + 1

    if love.keyboard.isDown("space") then
        love.mouse.setVisible(false)
      else
        love.mouse.setVisible(true)
      end
    --limits the val value 
    if val <= 1 then
        val = 1
    elseif val >= 9 then
        val = 9
    end
    --set value to a cell using mousebuttons
    if love.mouse.isDown(1) then
        setCell(gridY, gridX, val)
    end

    if love.mouse.isDown(2) then
        setCell(gridY, gridX, 0)
    end
end
