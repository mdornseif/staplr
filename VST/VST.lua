#!/usr/bin/env lua

-- VST - very simple terminal

local movement = require("Movement")

if table.getn(arg) == 0 then
    print(string.format("Usage: %s %s stapler_id", arg[-1], arg[0]))
    os.exit()
end

lift_id = arg[1]

-- redirect all output to /dev/tty1 and clear screen
io.output("/dev/tty1")
keyb.init_tty("/dev/tty1")

running = 1
while running ~= 0 do
    current_movement = Movement:next(lift_id)
    if current_movement ~= nil then
        current_movement:display()
        current_movement:handle_input()
    else
        io.write("\nKeine Umlagerungen\nF1: Weiter\n\n")
		io.flush()
		while input ~= "F1" do
			input = keyb.getkey()
		end
			
    end
end

keyb.restore_tty()
